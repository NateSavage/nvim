require('origami').setup({
    pauseFoldsOnSearch = true,
    foldKeymaps = {
        setup = false,
    },
    autoFold = {
        enabled = false,
    },
    foldtext = {
        enabled = true,
        lineCount = {
            template = '  %d lines',
            hlgroup = 'OrigamiFoldedLines',
        },
    },
})
