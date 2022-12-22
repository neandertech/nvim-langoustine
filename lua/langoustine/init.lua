local function deepCopy(original)
  local copy = {}
  for k, v in pairs(original) do
    if type(v) == "table" then
      v = deepCopy(v)
    end
    copy[k] = v
  end
  return copy
end

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local langoustine_config = {
  command_prefix = { "langoustine-tracer", "trace" }
}

local function get_lsps()
  local lsps = {}

  for _, v in pairs(vim.lsp.get_active_clients()) do
    if v.config.langoustine_tracer == nil then
      table.insert(lsps, { name = v.name, config = v.config, id = v.id })
    end
  end


  return lsps
end

local M = {}

M.enable_lsp_tracer = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "LSP client to restart with tracing",
    finder = finders.new_table({
      results = get_lsps(),
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.name,
          ordinal = entry.name
        }

      end
    }),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local old_client = selection.value
        local old_config = old_client.config
        local attached_buffers = vim.lsp.get_buffers_by_client_id(old_client.id)
        local old_command = old_config.cmd
        local new_command = langoustine_config.command_prefix

        for _, arg in pairs(old_command) do
          table.insert(new_command, arg)
        end

        local new_config = deepCopy(old_config)
        new_config.cmd = new_command
        new_config.langoustine_tracer = { old_cmd = old_command }

        for _, bufnr in ipairs(attached_buffers) do
          vim.lsp.buf_detach_client(bufnr, old_client.id)
        end

        vim.lsp.stop_client(old_client.id, true)
        vim.lsp.stop_client(old_client.id, true)

        vim.inspect(vim.lsp.start(new_config, { bufnr = nil, reuse_client = function(_, _) return false end }))

      end)
      return true
    end,
  }):find()
end


return M
