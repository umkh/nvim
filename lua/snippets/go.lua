local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

ls.add_snippets("go", {
  -- oddiy error check
  s("ie", {
    t({"if err != nil {",
      "\treturn err",
      "}"})
  }),
  
  -- nil va error qaytarish uchun
  s("iee", {
    t({"if err != nil {",
      "\treturn nil, err",
      "}"})
  }),
  
  -- log bilan error qaytarish
  s("iel", {
    t({"if err != nil {",
      "\tlog.Error(err)",
      "\treturn err",
      "}"})
  }),
})
