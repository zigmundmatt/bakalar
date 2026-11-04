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

return {
  { Inlines = nbsp_inlines },
  { Div = kde_block },
}
