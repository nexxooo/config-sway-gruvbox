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

		vim.keymap.set("n", "<Leader>db", function()
			dap.toggle_breakpoint()
		end, {desc="toggle breakpoint"})

		vim.keymap.set("n", "<Leader>dc", function()
			dap.continue()
		end, {desc="lancer"})
		vim.keymap.set("n", "<Leader>do", function()
			dap.step_over()
		end, {desc ="ligne suivante"})
		vim.keymap.set("n", "<Leader>di", function()
			dap.step_into()
		end, {desc="entrer fonction"})
		vim.keymap.set("n", "<Leader>du", function()
			dap.step_out()
		end, {desc="sortir fonction"})
		-- Leader + dB (majuscule) pour un point d'arrêt avec condition
		vim.keymap.set("n", "<Leader>dB", function()
			require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Breakpoint Conditionnel" })

		vim.keymap.set("n", "<Leader>dh", function()
			require("dap").set_breakpoint(nil, vim.fn.input("Nombre de passages (Hit count): "))
		end, { desc = "Breakpoint Hit Count" })

		-- Log Point (Affiche un message au lieu de s'arrêter)
		vim.keymap.set("n", "<Leader>dl", function()
			require("dap").set_breakpoint(nil, nil, vim.fn.input("Message de log: "))
		end, { desc = "Log Point" })

		dap.adapters.codelldb = {
			type = "executable",
			command = "codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"

			-- On windows you may have to uncomment this:
			-- detached = false,
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
