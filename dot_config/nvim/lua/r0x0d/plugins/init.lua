-- Plugin specifications organized by category
-- This file is loaded by lazy.nvim

local function is_plugin_spec(tbl)
    -- A plugin spec has a string as first element (the plugin name)
    -- or has a [1] key that is a string
    return type(tbl[1]) == 'string' or tbl.dir ~= nil or tbl.url ~= nil
end

local function flatten(tbl, result)
    result = result or {}
    for _, v in ipairs(tbl) do
        if type(v) == 'table' then
            if is_plugin_spec(v) then
                -- It's a plugin spec, add it directly
                table.insert(result, v)
            else
                -- It's a list of specs, recurse
                flatten(v, result)
            end
        end
    end
    return result
end

return flatten {
    require 'r0x0d.plugins.editor',
    require 'r0x0d.plugins.coding',
    require 'r0x0d.plugins.ui',
    require 'r0x0d.plugins.git',
    require 'r0x0d.plugins.tools',
}

