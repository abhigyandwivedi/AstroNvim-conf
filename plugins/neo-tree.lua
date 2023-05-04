return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = false,
    opts = function(_, opts)
      return require("astronvim.utils").extend_tbl(opts, {
        sources = {
          "filesystem",
        },
        add_blank_line_top = true,
        hide_root_node = true,
        retain_hidden_root_indent = true,
        enable_git_status = true,
        source_selector = {
          winbar = true,
        },
        git_status_async = false,
        -- log_level = "trace",
        -- log_to_file = true,
      })
    end,
  },
}
