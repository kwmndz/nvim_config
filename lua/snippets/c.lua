local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("c", {
    s("if", fmt("if ({}) {{\n    {}\n}}", { i(1, "condition"), i(2) })),

    s("ife", fmt("if ({}) {{\n    {}\n}} else {{\n    {}\n}}", {
        i(1, "condition"), i(2), i(3),
    })),

    s("elif", fmt("else if ({}) {{\n    {}\n}}", { i(1, "condition"), i(2) })),

    s("for", fmt("for ({} = {}; {} < {}; {}++) {{\n    {}\n}}", {
        i(1, "int i"), i(2, "0"), i(3, "i"), i(4, "n"), i(5, "i"), i(6),
    })),

    s("while", fmt("while ({}) {{\n    {}\n}}", { i(1, "condition"), i(2) })),

    s("do", fmt("do {{\n    {}\n}} while ({});", { i(1), i(2, "condition") })),

    s("sw", fmt("switch ({}) {{\n    case {}:\n        {}\n        break;\n    default:\n        {}\n        break;\n}}", {
        i(1, "expr"), i(2, "val"), i(3), i(4),
    })),

    s("fn", fmt("{} {}({}) {{\n    {}\n}}", {
        i(1, "void"), i(2, "func_name"), i(3), i(4),
    })),

    s("main", fmt("int main(int argc, char *argv[]) {{\n    {}\n    return 0;\n}}", { i(1) })),

    s("struct", fmt("typedef struct {{\n    {}\n}} {};", { i(1), i(2, "Name") })),

    s("inc", fmt("#include <{}>", { i(1, "stdio.h") })),
    s("inq", fmt('#include "{}"', { i(1, "header.h") })),

    s("pf", fmt('printf("{}", {});', { i(1, "fmt"), i(2) })),
    s("mal", fmt("{} *{} = malloc(sizeof(*{}));", { i(1, "int"), i(2, "ptr"), i(3, "ptr") })),
})
