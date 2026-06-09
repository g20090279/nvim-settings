local ls = require("luasnip")
local s = ls.s
local i = ls.i
local t = ls.t

return {
	-- 'tikz' is the trigger word
	s("tikz", {
		t({ "\\documentclass{standalone}", "" }), -- exmpty string latter means newline
		t({ "\\usepackage{tikz}", "" }),
		t({ "\\begin{document}", "" }),
		t({ "\\begin{tikzpicture}", "" }),
		t({ "", "" }),
		i(1, "%%% Your Tikz Code Here"), -- Placeholder for the node content
		t({ "", "" }),
		t({ "", "" }),
		t({ "\\end{tikzpicture}", "" }),
		t({ "\\end{document}", "" }),
	}),

	-- fix the friendly-snippet plugin
	s("itemize", {
		t({ "\\begin{itemize}", "" }),
		t("     \\item "),
		i(1, "%%% First item"),
		t({ "", "\\end{itemize}" }),
	}),
}
