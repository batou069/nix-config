return {
    "kawre/leetcode.nvim",
    cmd = "Leet",
    build = "TSUpdate html", -- if you have `nvim-treesitter` installed
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "ibhagwan/fzf-lua",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    opts = {
        ---@type lc.lang
        lang = "python",
        plugins = {
            non_standalone = true,
        },    
    },
}