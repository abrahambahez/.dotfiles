-- Convierte notas al pie de pandoc en sidenotes de Tufte CSS
local note_counter = 0

function Note(el)
  note_counter = note_counter + 1
  local id = "sn-" .. note_counter
  local content = pandoc.write(pandoc.Pandoc(el.content), "html")
  content = content:gsub("^%s*<p>", ""):gsub("</p>%s*$", "")
  return pandoc.RawInline("html", string.format(
    '<label for="%s" class="margin-toggle sidenote-number"></label>'
    .. '<input type="checkbox" id="%s" class="margin-toggle"/>'
    .. '<span class="sidenote">%s</span>',
    id, id, content
  ))
end
