-- Pandoc Lua filter for the FMT thesis build.
--
-- 1. "Kde:" blocks. In Markdown write, right after an equation:
--
--      ::: kde
--      - $A$ – Hamakerova konstanta [J]
--      - $R$ – poloměr částice [m]
--      :::
--
--    In LaTeX this becomes the fmtkde environment (Calibri 11 pt, one symbol
--    per line, introduced by "Kde:"), as required by the FMT template.
--
-- 2. Czech typography: a non-breaking space after one-letter prepositions and
--    conjunctions (k, s, v, z, o, u, a, i), so they never end a line.
--
-- 3. Tables in the template's grid style. Columns without a width share the
--    text width equally (as an inserted Word table does). Pandoc writes the
--    table as a booktabs longtable; that code is rewritten to vertical rules
--    and the fmttable* rules defined in fmt-thesis.cls.

local one_letter = {
  k = true, s = true, v = true, z = true, o = true, u = true, a = true, i = true,
  K = true, S = true, V = true, Z = true, O = true, U = true, A = true, I = true,
}

local function nbsp_inlines(inlines)
  local out = pandoc.Inlines{}
  local i = 1
  while i <= #inlines do
    local el = inlines[i]
    local nxt = inlines[i + 1]
    if el.t == 'Str' and one_letter[el.text] and nxt
        and (nxt.t == 'Space' or nxt.t == 'SoftBreak') then
      out:insert(pandoc.Str(el.text .. '\u{00A0}'))
      i = i + 2
    else
      out:insert(el)
      i = i + 1
    end
  end
  return out
end

local function kde_block(div)
  if not div.classes:includes('kde') then
    return nil
  end
  if not FORMAT:match('latex') then
    return nil
  end
  local blocks = pandoc.Blocks{ pandoc.RawBlock('latex', '\\begin{fmtkde}') }
  for _, block in ipairs(div.content) do
    if block.t == 'BulletList' or block.t == 'OrderedList' then
      for _, item in ipairs(block.content) do
        for _, b in ipairs(item) do
          blocks:insert(b)
        end
      end
    else
      blocks:insert(block)
    end
  end
  blocks:insert(pandoc.RawBlock('latex', '\\end{fmtkde}'))
  return blocks
end

local function plain_replace(text, from, to)
  return (text:gsub(from:gsub('%p', '%%%0'), (to:gsub('%%', '%%%%'))))
end

local function grid_table(tbl)
  if not FORMAT:match('latex') then
    return nil
  end
  local n = #tbl.colspecs
  local all_default = true
  for _, cs in ipairs(tbl.colspecs) do
    if cs[2] ~= nil then all_default = false end
  end
  if all_default then
    for i, cs in ipairs(tbl.colspecs) do
      tbl.colspecs[i] = { cs[1], 1 / n }
    end
  end
  -- body only: the writer options of this run would make it standalone
  local tex = pandoc.write(pandoc.Pandoc({ tbl }), 'latex')

  -- column spec: outer 1.5 pt rules, 0.75 pt rules between columns
  local outer = '!{\\vrule width\\fmttableouterrule}'
  tex = tex:gsub('(\\begin{longtable}%[%]){@{}(.-)@{}}', function(head, cols)
    cols = cols:gsub('>{', '|>{')
    cols = cols:gsub('^(%s*)|', '%1' .. outer, 1)
    return head .. '{' .. cols .. outer .. '}'
  end, 1)
  -- widths: pandoc subtracts the inner column gaps only
  tex = tex:gsub('%(\\linewidth %- %d+\\tabcolsep%)', string.format(
    '(\\linewidth - %d\\tabcolsep - 2\\fmttableouterrule - %d\\arrayrulewidth)',
    2 * n, n - 1))

  for _, rule in ipairs({ 'toprule', 'midrule', 'bottomrule' }) do
    tex = plain_replace(tex, '\\' .. rule .. '\\noalign{}', '\\fmttablethick')
    tex = plain_replace(tex, '\\' .. rule, '\\fmttablethick')
  end

  -- thin rule between body rows (the last row is closed by the foot rule)
  local foot = '\\endlastfoot\n'
  local s, e = tex:find(foot, 1, true)
  if e then
    local body_end = tex:find('\\end{longtable}', e, true)
    local body = tex:sub(e + 1, body_end - 1)
    body = body:gsub(' \\\\\n', ' \\\\ \\fmttablethin\n')
    body = body:gsub('(.*) \\fmttablethin\n', '%1\n')
    tex = tex:sub(1, e) .. body .. tex:sub(body_end)
  end

  return pandoc.RawBlock('latex',
    '\\begingroup\\fmttablesetup\n' .. tex .. '\n\\endgroup')
end

return {
  { Inlines = nbsp_inlines },
  { Div = kde_block },
  { Table = grid_table },
}
