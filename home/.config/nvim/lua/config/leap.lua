local leap = require('leap')

leap.add_default_mappings()

-- I have , and : swapped so I match that configuration in leap
leap.opts.special_keys.prev_target = { '<tab>', ':' }
