local M = {}

vim.lsp.config("basedpyright", {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "pyrightconfig.json", ".git" },
  settings = {
    basedpyright = {
      disableOrganizeImports = true, -- ruff handles it
      analysis = { typeCheckingMode = "standard", autoImportCompletions = true },
    },
  },
})

vim.lsp.config("ruff", {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
})

vim.lsp.config("dockerls", {
  cmd = { "docker-langserver", "--stdio" },
  filetypes = { "dockerfile" },
  root_markers = { "Dockerfile", "Containerfile", ".git" },
})

vim.lsp.config("yamlls", {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yaml.docker-compose" },
  root_markers = { ".git" },
  settings = {
    yaml = {
      keyOrdering = false,
      schemaStore = { enable = false, url = "" }, -- schemastore.nvim supplies schemas
    },
  },
  before_init = function(_, config)
    require("config.loader").load("schemastore")
    local ok, ss = pcall(require, "schemastore")
    if ok then config.settings.yaml.schemas = ss.yaml.schemas() end
  end,
})

vim.lsp.config("jsonls", {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  root_markers = { ".git" },
  init_options = { provideFormatter = true },
  settings = {
    json = {
      validate = { enable = true },
    },
  },
  before_init = function(_, config)
    require("config.loader").load("schemastore")
    local ok, ss = pcall(require, "schemastore")
    if ok then config.settings.json.schemas = ss.json.schemas() end
  end,
})

vim.lsp.config("taplo", {
  cmd = { "taplo", "lsp", "stdio" },
  filetypes = { "toml" },
  root_markers = { "taplo.toml", ".taplo.toml", "Cargo.toml", "pyproject.toml", ".git" },
})

-- pip/dnf: rpm-spec-language-server (binary: rpm_lsp_server)
vim.lsp.config("rpm_spec_ls", {
  cmd = { "rpm_lsp_server", "--stdio" },
  filetypes = { "spec" },
  root_markers = { ".git" },
})

vim.lsp.config("bashls", {
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "bash" },
  root_markers = { ".git" },
})

vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = { library = { vim.env.VIMRUNTIME }, checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
})

-- Only servers whose binary is installed are enabled, so missing ones stay quiet.
function M.enable()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-completion", { clear = true }),
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if client and client:supports_method("textDocument/completion") then
        vim.lsp.completion.enable(true, client.id, ev.buf, {
          autotrigger = true,
          convert = function(item)
            local icons = require("config.icons")
            local label = item.label:gsub("%b()", "") -- drop "(args)" noise
            return {
              abbr = icons.kind(item.kind) .. " " .. label,
              kind = vim.lsp.protocol.CompletionItemKind[item.kind] or "",
            }
          end,
        })
      end
    end,
  })
  local servers = {
    "basedpyright", "ruff", "dockerls", "yamlls", "jsonls",
    "taplo", "rpm_spec_ls", "bashls", "lua_ls",
  }
  local enable = {}
  for _, s in ipairs(servers) do
    local cmd = vim.lsp.config[s].cmd
    if cmd and vim.fn.executable(cmd[1]) == 1 then
      table.insert(enable, s)
    end
  end
  vim.lsp.enable(enable)
end

return M
