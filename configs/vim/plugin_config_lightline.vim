
" Lightline
let g:lightline = {
\  'active': {
\    'left': [
\      ['mode', 'paste' ],
\      ['gitbranch', 'readonly', 'filename', 'modified']
\    ],
\    'right': [
\      ['lineinfo'],
\      ['percent'],
\      ['fileformat', 'fileencoding', 'filetype']
\    ]
\  },
\  'inactive': {
\    'left': [
\       [ 'filename', 'fullfilename' ]
\    ],
\    'right': [
\       [ 'lineinfo' ],
\       [ 'percent' ]
\    ]
\  },
\  'component': {
\    'fullfilename': '@%F'
\  },
\  'component_function': {
\    'gitbranch': 'fugitive#head'
\  },
\}
