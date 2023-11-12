ENABLED_LANGUAGES = {
  python = true
}

require('refactoring').setup({
    prompt_func_return_type = ENABLED_LANGUAGES,
    prompt_func_param_type = ENABLED_LANGUAGES,
})
