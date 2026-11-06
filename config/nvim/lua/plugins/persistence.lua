-- Loads on first real file so the session saved on exit exists even when the
-- dashboard was never used (the dashboard lists these sessions).
require("persistence").setup()
