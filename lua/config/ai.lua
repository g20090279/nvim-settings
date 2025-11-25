require('minuet').setup {
    provider = 'gemini',
    provider_options = {
        gemini = {
            api_key = os.getenv("GEMINI_API_KEY"),
            model = "gemini-2.0-flash",  -- or whichever Gemini model you prefer
            -- optional settings:
            optional = {
                max_tokens = 256,
                top_p = 0.9,
            },
        },
    },
    virtualtext = {
        auto_trigger_ft = { "lua", "python", "javascript" },
        keymap = {
            accept = '<A-A>',
            accept_line = '<A-a>',
            next = '<A-]>',
            prev = '<A-[>',
            dismiss = '<A-e>',
        },
    },
}

