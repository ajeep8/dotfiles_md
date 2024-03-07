--[[
Generated by EmmyLua(https://github.com/EmmyLua)
Created by yamamoto.
DateTime: 2020/10/04 16:54

# docx-comment.lua

Convert a span with `comment` attribute

[Comment point to]{comment="Comment string"}

to Docx comment

[Comment string]{.comment-start}Comment point to[]{.comment-end}

]]

--local stringify = require("pandoc.utils").stringify
local List = require("pandoc").List

local debug = require("pandocker.utils").debug
local KEY = "comment"

if FORMAT == "docx" then
    local function replace(el)
        if not List({ nil, "" }):includes(el.attributes[KEY]) then
            -- 'comment' attribute value is not blank nor nil
            local comment_string = el.attributes[KEY]
            debug(comment_string)
            local comment_start = pandoc.Span({ pandoc.Str(comment_string) }, { "", { "comment-start" }, {} })
            local comment_end = pandoc.Span(pandoc.Null, { "", { "comment-end" }, {} })
            el.attributes[KEY] = nil
            return pandoc.Span({ comment_start, el, comment_end })
        end
    end
end

return { { Span = replace } }