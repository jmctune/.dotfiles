require("mason").setup()
require("mason-lspconfig").setup {
	ensure_installed = {
		"bashls",
		"graphql",
		"lua_ls",
		"nginx_language_server",
		"powershell_es",
		"pyright",
		"tflint",
		"yamlls",
	},
}

require("lspconfig").lua_ls.setup {}
require("lspconfig").pyright.setup {}
require("lspconfig").tflint.setup {}
require("lspconfig").bashls.setup {}
require("lspconfig").graphql.setup {}
require("lspconfig").nginx_language_server.setup {}
require("lspconfig").powershell_es.setup {}
require("lspconfig").yamlls.setup {}
