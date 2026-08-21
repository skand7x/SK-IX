return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
      require('nvim-treesitter').install { 'rust', 'python', 'lua', 'javascript', 'typescript', 'html', 'css', 'json', 'yaml' }      
  end,
}
