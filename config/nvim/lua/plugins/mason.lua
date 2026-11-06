-- Plugin only; the tool list lives in mason_tools.lua. Its bin dir is put on
-- PATH early in groups.lua, so this lazy load does not delay finding servers.
require("mason").setup()
