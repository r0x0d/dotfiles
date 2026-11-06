-- telescope is a hard dependency (groups.lua requires it), so no fallback picker
require("octo").setup({ picker = "telescope" })
