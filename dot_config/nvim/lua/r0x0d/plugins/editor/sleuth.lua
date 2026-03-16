-- Sleuth: Automatic indentation detection
return {
    'tpope/vim-sleuth',
    event = { 'BufReadPre', 'BufNewFile' }, -- Load when opening files
}

