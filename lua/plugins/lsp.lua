return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- only if using nvim-cmp
  },
  config = function()
    -- capabilities: what nvim-cmp can do (snippets, etc.)
    -- delete this + the vim.lsp.config(...).capabilities lines if no nvim-cmp
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- runs once per buffer when a server attaches
    local on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, silent = true }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
      end, opts)
    end

    -- shared defaults applied to every server via the special "*" config
    vim.lsp.config("*", {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- ===== Python =====
    vim.lsp.config("pyright", {})

    -- ===== C / C++ =====
    vim.lsp.config("clangd", {
      cmd = { "clangd", "--background-index", "--clang-tidy" },
    })

    vim.lsp.config("qmlls", {})
    -- ===== Nix =====
    vim.lsp.config("nixd", {
      settings = {
        nixd = {
          formatting = { command = { "alejandra" } },
        },
      },
    })

    -- ===== Lua =====
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = {
            checkThirdParty = false,
            library = { vim.env.VIMRUNTIME },
          },
          telemetry = { enable = false },
        },
      },
    })

    -- ===== Bash =====
    vim.lsp.config("bashls", {})

    -- actually turn all of them on
    vim.lsp.enable({ "pyright", "clangd", "nixd", "lua_ls", "bashls", "qmlls" })

    -- diagnostic UI
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
    })
  end,
}
