return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		dependencies = { "nvim-neotest/nvim-nio" },
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		dapui.setup()


		-- 3. LISTENERS POUR L'INTERFACE (Auto-open/close)
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		-- 4. VOS RACCOURCIS CLAVIER (DÉJÀ CONFIGURÉS)
		vim.keymap.set("n", "<Leader>db", function()
			dap.toggle_breakpoint()
		end, { desc = "toggle breakpoint" })

		vim.keymap.set("n", "<Leader>dc", function()
			dap.continue()
		end, { desc = "lancer" })

		vim.keymap.set("n", "<Leader>do", function()
			dap.step_over()
		end, { desc = "ligne suivante" })

		vim.keymap.set("n", "<Leader>di", function()
			dap.step_into()
		end, { desc = "entrer fonction" })

		vim.keymap.set("n", "<Leader>du", function()
			dap.step_out()
		end, { desc = "sortir fonction" })

		-- 5. AUTRES ADAPTATEURS (C/C++)
		dap.adapters.codelldb = {
			type = "executable",
			command = "codelldb",
		}
		dap.configurations.c = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}
	end,
}
