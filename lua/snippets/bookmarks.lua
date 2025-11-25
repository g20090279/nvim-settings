local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("all", {
    s("bm", {
        t("BookmarkBegin\n"),
        t("BookmarkTitle: "), i(1, "Title"), t("\n"),
        t("BookmarkLevel: "), i(2, "1"), t("\n"),
        t("BookmarkPageNumber: "), i(3, "1"), t("\n"),
    }),
})

