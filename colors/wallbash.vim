" Name:         wallbash
" Description:  wallbash template
" Author:       The HyDE Project
" License:      Same as Vim
" Last Change:  April 2025

if exists('g:loaded_wallbash') | finish | endif
let g:loaded_wallbash = 1


" Detect background based on terminal colors
if $BACKGROUND =~# 'light'
  set background=light
else
  set background=dark
endif

" hi clear
let g:colors_name = 'wallbash'

let s:t_Co = &t_Co

" Terminal color setup
if (has('termguicolors') && &termguicolors) || has('gui_running')
  let s:is_dark = &background == 'dark'

  " Define terminal colors based on the background
  if s:is_dark
    let g:terminal_ansi_colors = ['2E3440', '617C8E', '7A8C99', '7A8C99',
                                \ '617C8E', 'A1B2C2', 'A1B2C2', 'E6E5E5',
                                \ '4C566A', '7A8C99', 'A1B2C2', 'B8C5D1',
                                \ '7A8C99', 'B8C5D1', 'B8C5D1', 'FFFFFF']
  else
    " Lighter colors for light theme
    let g:terminal_ansi_colors = ['FFFFFF', 'A1B2C2', 'B8C5D1', 'B8C5D1',
                                \ 'A1B2C2', 'D8E0E9', 'D8E0E9', '5E81AC',
                                \ 'E6E5E5', 'B8C5D1', 'D8E0E9', 'D8E0E9',
                                \ 'B8C5D1', 'D8E0E9', 'D8E0E9', '2E3440']
  endif

  " Nvim uses g:terminal_color_{0-15} instead
  for i in range(g:terminal_ansi_colors->len())
    let g:terminal_color_{i} = g:terminal_ansi_colors[i]
  endfor
endif

      " For Neovim compatibility
      if has('nvim')
        " Set Neovim specific terminal colors
        let g:terminal_color_0 = '#' . g:terminal_ansi_colors[0]
        let g:terminal_color_1 = '#' . g:terminal_ansi_colors[1]
        let g:terminal_color_2 = '#' . g:terminal_ansi_colors[2]
        let g:terminal_color_3 = '#' . g:terminal_ansi_colors[3]
        let g:terminal_color_4 = '#' . g:terminal_ansi_colors[4]
        let g:terminal_color_5 = '#' . g:terminal_ansi_colors[5]
        let g:terminal_color_6 = '#' . g:terminal_ansi_colors[6]
        let g:terminal_color_7 = '#' . g:terminal_ansi_colors[7]
        let g:terminal_color_8 = '#' . g:terminal_ansi_colors[8]
        let g:terminal_color_9 = '#' . g:terminal_ansi_colors[9]
        let g:terminal_color_10 = '#' . g:terminal_ansi_colors[10]
        let g:terminal_color_11 = '#' . g:terminal_ansi_colors[11]
        let g:terminal_color_12 = '#' . g:terminal_ansi_colors[12]
        let g:terminal_color_13 = '#' . g:terminal_ansi_colors[13]
        let g:terminal_color_14 = '#' . g:terminal_ansi_colors[14]
        let g:terminal_color_15 = '#' . g:terminal_ansi_colors[15]
      endif

" Function to dynamically invert colors for UI elements
function! s:inverse_color(color)
  " This function takes a hex color (without #) and returns its inverse
  " Convert hex to decimal values
  let r = str2nr(a:color[0:1], 16)
  let g = str2nr(a:color[2:3], 16)
  let b = str2nr(a:color[4:5], 16)

  " Calculate inverse (255 - value)
  let r_inv = 255 - r
  let g_inv = 255 - g
  let b_inv = 255 - b

  " Convert back to hex
  return printf('%02x%02x%02x', r_inv, g_inv, b_inv)
endfunction

" Function to be called for selection background
function! InverseSelectionBg()
  if &background == 'dark'
    return 'D8E0E9'
  else
    return '3B4252'
  endif
endfunction

" Add high-contrast dynamic selection highlighting using the inverse color function
augroup WallbashDynamicHighlight
  autocmd!
  " Update selection highlight when wallbash colors change
  autocmd ColorScheme wallbash call s:update_dynamic_highlights()
augroup END

function! s:update_dynamic_highlights()
  let l:bg_color = synIDattr(synIDtrans(hlID('Normal')), 'bg#')
  if l:bg_color != ''
    let l:bg_color = l:bg_color[1:] " Remove # from hex color
    let l:inverse = s:inverse_color(l:bg_color)

    " Apply inverse color to selection highlights
    execute 'highlight! CursorSelection guifg=' . l:bg_color . ' guibg=#' . l:inverse

    " Link dynamic highlights to various selection groups
    highlight! link NeoTreeCursorLine CursorSelection
    highlight! link TelescopeSelection CursorSelection
    highlight! link CmpItemSelected CursorSelection
    highlight! link PmenuSel CursorSelection
    highlight! link WinSeparator VertSplit
  endif
endfunction

" Make selection visible right away for current colorscheme
call s:update_dynamic_highlights()

" Conditional highlighting based on background
if &background == 'dark'
  " Base UI elements with transparent backgrounds
  hi Normal guibg=NONE guifg=#FFFFFF gui=NONE cterm=NONE
  hi Pmenu guibg=#5E81AC guifg=#FFFFFF gui=NONE cterm=NONE
  hi StatusLine guifg=#FFFFFF guibg=#5E81AC gui=NONE cterm=NONE
  hi StatusLineNC guifg=#FFFFFF guibg=#4C566A gui=NONE cterm=NONE
  hi VertSplit guifg=#617C8E guibg=NONE gui=NONE cterm=NONE
  hi LineNr guifg=#617C8E guibg=NONE gui=NONE cterm=NONE
  hi SignColumn guifg=NONE guibg=NONE gui=NONE cterm=NONE
  hi FoldColumn guifg=#FFFFFF guibg=NONE gui=NONE cterm=NONE

  " NeoTree with transparent background including unfocused state
  hi NeoTreeNormal guibg=NONE guifg=#FFFFFF gui=NONE cterm=NONE
  hi NeoTreeEndOfBuffer guibg=NONE guifg=#FFFFFF gui=NONE cterm=NONE
  hi NeoTreeFloatNormal guibg=NONE guifg=#FFFFFF gui=NONE cterm=NONE
  hi NeoTreeFloatBorder guifg=#617C8E guibg=NONE gui=NONE cterm=NONE
  hi NeoTreeWinSeparator guifg=#4C566A guibg=NONE gui=NONE cterm=NONE

  " NeoTree with transparent background
  hi NeoTreeNormal guibg=NONE guifg=#FFFFFF gui=NONE cterm=NONE
  hi NeoTreeEndOfBuffer guibg=NONE guifg=#FFFFFF gui=NONE cterm=NONE
  hi NeoTreeRootName guifg=#D8E0E9 guibg=NONE gui=bold cterm=bold

  " TabLine highlighting with complementary accents
  hi TabLine guifg=#FFFFFF guibg=#5E81AC gui=NONE cterm=NONE
  hi TabLineFill guifg=NONE guibg=NONE gui=NONE cterm=NONE
  hi TabLineSel guifg=#2E3440 guibg=#D8E0E9 gui=bold cterm=bold
  hi TabLineSeparator guifg=#617C8E guibg=#5E81AC gui=NONE cterm=NONE

  " Interactive elements with dynamic contrast
  hi Search guifg=#4C566A guibg=#B8C5D1 gui=NONE cterm=NONE
  hi Visual guifg=#4C566A guibg=#A1B2C2 gui=NONE cterm=NONE
  hi MatchParen guifg=#4C566A guibg=#D8E0E9 gui=bold cterm=bold

  " Menu item hover highlight
  hi CmpItemAbbrMatch guifg=#D8E0E9 guibg=NONE gui=bold cterm=bold
  hi CmpItemAbbrMatchFuzzy guifg=#B8C5D1 guibg=NONE gui=bold cterm=bold
  hi CmpItemMenu guifg=#FFFFFF guibg=NONE gui=italic cterm=italic
  hi CmpItemAbbr guifg=#FFFFFF guibg=NONE gui=NONE cterm=NONE
  hi CmpItemAbbrDeprecated guifg=#E6E5E5 guibg=NONE gui=strikethrough cterm=strikethrough

  " Specific menu highlight groups
  hi WhichKey guifg=#D8E0E9 guibg=NONE gui=NONE cterm=NONE
  hi WhichKeySeparator guifg=#E6E5E5 guibg=NONE gui=NONE cterm=NONE
  hi WhichKeyGroup guifg=#A1B2C2 guibg=NONE gui=NONE cterm=NONE
  hi WhichKeyDesc guifg=#B8C5D1 guibg=NONE gui=NONE cterm=NONE
  hi WhichKeyFloat guibg=#4C566A guifg=NONE gui=NONE cterm=NONE

  " Selection and hover highlights with inverted colors
  hi CursorColumn guifg=NONE guibg=#5E81AC gui=NONE cterm=NONE
  hi Cursor guibg=#FFFFFF guifg=#2E3440 gui=NONE cterm=NONE
  hi lCursor guibg=#FFFFFF guifg=#2E3440 gui=NONE cterm=NONE
  hi CursorIM guibg=#FFFFFF guifg=#2E3440 gui=NONE cterm=NONE
  hi TermCursor guibg=#FFFFFF guifg=#2E3440 gui=NONE cterm=NONE
  hi TermCursorNC guibg=#FFFFFF guifg=#2E3440 gui=NONE cterm=NONE
  hi CursorLine guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi CursorLineNr guifg=#D8E0E9 guibg=NONE gui=bold cterm=bold

  hi QuickFixLine guifg=#4C566A guibg=#A1B2C2 gui=NONE cterm=NONE
  hi IncSearch guifg=#4C566A guibg=#D8E0E9 gui=NONE cterm=NONE
  hi NormalNC guibg=#4C566A guifg=#FFFFFF gui=NONE cterm=NONE
  hi Directory guifg=#B8C5D1 guibg=NONE gui=NONE cterm=NONE
  hi WildMenu guifg=#4C566A guibg=#D8E0E9 gui=bold cterm=bold

  " Add highlight groups for focused items with inverted colors
  hi CursorLineFold guifg=#D8E0E9 guibg=#4C566A gui=NONE cterm=NONE
  hi FoldColumn guifg=#FFFFFF guibg=NONE gui=NONE cterm=NONE
  hi Folded guifg=#FFFFFF guibg=#5E81AC gui=italic cterm=italic

  " File explorer specific highlights
  hi NeoTreeNormal guibg=NONE guifg=#FFFFFF gui=NONE cterm=NONE
  hi NeoTreeEndOfBuffer guibg=NONE guifg=#FFFFFF gui=NONE cterm=NONE
  hi NeoTreeRootName guifg=#D8E0E9 guibg=NONE gui=bold cterm=bold
  hi NeoTreeFileName guifg=#FFFFFF guibg=NONE gui=NONE cterm=NONE
  hi NeoTreeFileIcon guifg=#B8C5D1 guibg=NONE gui=NONE cterm=NONE
  hi NeoTreeDirectoryName guifg=#B8C5D1 guibg=NONE gui=NONE cterm=NONE
  hi NeoTreeDirectoryIcon guifg=#B8C5D1 guibg=NONE gui=NONE cterm=NONE
  hi NeoTreeGitModified guifg=#A1B2C2 guibg=NONE gui=NONE cterm=NONE
  hi NeoTreeGitAdded guifg=#7A8C99 guibg=NONE gui=NONE cterm=NONE
  hi NeoTreeGitDeleted guifg=#617C8E guibg=NONE gui=NONE cterm=NONE
  hi NeoTreeGitUntracked guifg=#7A8C99 guibg=NONE gui=NONE cterm=NONE
  hi NeoTreeIndentMarker guifg=#5E6B8B guibg=NONE gui=NONE cterm=NONE
  hi NeoTreeSymbolicLinkTarget guifg=#A1B2C2 guibg=NONE gui=NONE cterm=NONE

  " File explorer cursor highlights with strong contrast
  " hi NeoTreeCursorLine guibg=#A1B2C2 guifg=#2E3440 gui=bold cterm=bold
  " hi! link NeoTreeCursor NeoTreeCursorLine
  " hi! link NeoTreeCursorLineSign NeoTreeCursorLine

  " Use wallbash colors for explorer snack in dark mode
  hi WinBar guifg=#FFFFFF guibg=#5E81AC gui=bold cterm=bold
  hi WinBarNC guifg=#FFFFFF guibg=#4C566A gui=NONE cterm=NONE
  hi ExplorerSnack guibg=#D8E0E9 guifg=#2E3440 gui=bold cterm=bold
  hi BufferTabpageFill guibg=#2E3440 guifg=#E6E5E5 gui=NONE cterm=NONE
  hi BufferCurrent guifg=#FFFFFF guibg=#D8E0E9 gui=bold cterm=bold
  hi BufferCurrentMod guifg=#FFFFFF guibg=#A1B2C2 gui=bold cterm=bold
  hi BufferCurrentSign guifg=#D8E0E9 guibg=#4C566A gui=NONE cterm=NONE
  hi BufferVisible guifg=#FFFFFF guibg=#5E81AC gui=NONE cterm=NONE
  hi BufferVisibleMod guifg=#FFFFFF guibg=#5E81AC gui=NONE cterm=NONE
  hi BufferVisibleSign guifg=#A1B2C2 guibg=#4C566A gui=NONE cterm=NONE
  hi BufferInactive guifg=#E6E5E5 guibg=#4C566A gui=NONE cterm=NONE
  hi BufferInactiveMod guifg=#617C8E guibg=#4C566A gui=NONE cterm=NONE
  hi BufferInactiveSign guifg=#617C8E guibg=#4C566A gui=NONE cterm=NONE

  " Fix link colors to make them more visible
  hi link Hyperlink NONE
  hi link markdownLinkText NONE
  hi Underlined guifg=#FF00FF guibg=NONE gui=bold,underline cterm=bold,underline
  hi Special guifg=#FF00FF guibg=NONE gui=bold cterm=bold
  hi markdownUrl guifg=#FF00FF guibg=NONE gui=underline cterm=underline
  hi markdownLinkText guifg=#FF00FF guibg=NONE gui=bold cterm=bold
  hi htmlLink guifg=#FF00FF guibg=NONE gui=bold,underline cterm=bold,underline

  " Add more direct highlights for badges in markdown
  hi markdownH1 guifg=#FF00FF guibg=NONE gui=bold cterm=bold
  hi markdownLinkDelimiter guifg=#FF00FF guibg=NONE gui=bold cterm=bold
  hi markdownLinkTextDelimiter guifg=#FF00FF guibg=NONE gui=bold cterm=bold
  hi markdownIdDeclaration guifg=#FF00FF guibg=NONE gui=bold cterm=bold

  " === Syntax Highlight Groups (dark theme) ===
  hi Comment      guifg=#617C8E guibg=NONE gui=italic cterm=italic
  hi Constant     guifg=#D8E0E9 guibg=NONE gui=NONE cterm=NONE
  hi String       guifg=#A1B2C2 guibg=NONE gui=NONE cterm=NONE
  hi Character    guifg=#A1B2C2 guibg=NONE gui=NONE cterm=NONE
  hi Number       guifg=#7A8C99 guibg=NONE gui=NONE cterm=NONE
  hi Float        guifg=#7A8C99 guibg=NONE gui=NONE cterm=NONE
  hi Boolean      guifg=#D8E0E9 guibg=NONE gui=NONE cterm=NONE
  hi Identifier   guifg=#FFFFFF guibg=NONE gui=NONE cterm=NONE
  hi Function     guifg=#7A8C99 guibg=NONE gui=NONE cterm=NONE
  hi Statement    guifg=#A1B2C2 guibg=NONE gui=NONE cterm=NONE
  hi Keyword      guifg=#A1B2C2 guibg=NONE gui=bold cterm=bold
  hi Conditional  guifg=#A1B2C2 guibg=NONE gui=NONE cterm=NONE
  hi Repeat       guifg=#A1B2C2 guibg=NONE gui=NONE cterm=NONE
  hi Label        guifg=#B8C5D1 guibg=NONE gui=NONE cterm=NONE
  hi Operator     guifg=#FFFFFF guibg=NONE gui=NONE cterm=NONE
  hi Exception    guifg=#7A8C99 guibg=NONE gui=bold cterm=bold
  hi PreProc      guifg=#B8C5D1 guibg=NONE gui=NONE cterm=NONE
  hi Include      guifg=#B8C5D1 guibg=NONE gui=NONE cterm=NONE
  hi Define       guifg=#A1B2C2 guibg=NONE gui=NONE cterm=NONE
  hi Macro        guifg=#B8C5D1 guibg=NONE gui=NONE cterm=NONE
  hi PreCondit    guifg=#A1B2C2 guibg=NONE gui=NONE cterm=NONE
  hi Type         guifg=#B8C5D1 guibg=NONE gui=NONE cterm=NONE
  hi StorageClass guifg=#A1B2C2 guibg=NONE gui=NONE cterm=NONE
  hi Structure    guifg=#B8C5D1 guibg=NONE gui=NONE cterm=NONE
  hi Typedef      guifg=#B8C5D1 guibg=NONE gui=NONE cterm=NONE
  hi Todo         guifg=#2E3440 guibg=#A1B2C2 gui=bold cterm=bold
  hi Error        guifg=#FFFFFF guibg=#617C8E gui=NONE cterm=NONE
  hi SpellBad     guifg=#617C8E guibg=NONE gui=undercurl cterm=undercurl
  hi SpellCap     guifg=#7A8C99 guibg=NONE gui=undercurl cterm=undercurl
else
  " Light theme with transparent backgrounds
  hi Normal guibg=NONE guifg=#2E3440 gui=NONE cterm=NONE
  hi Pmenu guibg=#E6E5E5 guifg=#2E3440 gui=NONE cterm=NONE
  hi StatusLine guifg=#FFFFFF guibg=#4C566A gui=NONE cterm=NONE
  hi StatusLineNC guifg=#2E3440 guibg=#FFFFFF gui=NONE cterm=NONE
  hi VertSplit guifg=#4C566A guibg=NONE gui=NONE cterm=NONE
  hi LineNr guifg=#4C566A guibg=NONE gui=NONE cterm=NONE
  hi SignColumn guifg=NONE guibg=NONE gui=NONE cterm=NONE
  hi FoldColumn guifg=#4C566A guibg=NONE gui=NONE cterm=NONE

  " NeoTree with transparent background including unfocused state
  hi NeoTreeNormal guibg=NONE guifg=#2E3440 gui=NONE cterm=NONE
  hi NeoTreeEndOfBuffer guibg=NONE guifg=#2E3440 gui=NONE cterm=NONE
  hi NeoTreeFloatNormal guibg=NONE guifg=#2E3440 gui=NONE cterm=NONE
  hi NeoTreeFloatBorder guifg=#4C566A guibg=NONE gui=NONE cterm=NONE
  hi NeoTreeWinSeparator guifg=#FFFFFF guibg=NONE gui=NONE cterm=NONE

  " NeoTree with transparent background
  hi NeoTreeNormal guibg=NONE guifg=#2E3440 gui=NONE cterm=NONE
  hi NeoTreeEndOfBuffer guibg=NONE guifg=#2E3440 gui=NONE cterm=NONE
  hi NeoTreeRootName guifg=#3B4252 guibg=NONE gui=bold cterm=bold

  " TabLine highlighting with complementary accents
  hi TabLine guifg=#2E3440 guibg=#FFFFFF gui=NONE cterm=NONE
  hi TabLineFill guifg=NONE guibg=NONE gui=NONE cterm=NONE
  hi TabLineSel guifg=#FFFFFF guibg=#3B4252 gui=bold cterm=bold
  hi TabLineSeparator guifg=#4C566A guibg=#FFFFFF gui=NONE cterm=NONE

  " Interactive elements with complementary contrast
  hi Search guifg=#FFFFFF guibg=#434C5E gui=NONE cterm=NONE
  hi Visual guifg=#FFFFFF guibg=#4C566A gui=NONE cterm=NONE
  hi MatchParen guifg=#FFFFFF guibg=#3B4252 gui=bold cterm=bold

  " Menu item hover highlight
  hi CmpItemAbbrMatch guifg=#3B4252 guibg=NONE gui=bold cterm=bold
  hi CmpItemAbbrMatchFuzzy guifg=#434C5E guibg=NONE gui=bold cterm=bold
  hi CmpItemMenu guifg=#4C566A guibg=NONE gui=italic cterm=italic
  hi CmpItemAbbr guifg=#2E3440 guibg=NONE gui=NONE cterm=NONE
  hi CmpItemAbbrDeprecated guifg=#5E81AC guibg=NONE gui=strikethrough cterm=strikethrough

  " Specific menu highlight groups
  hi WhichKey guifg=#3B4252 guibg=NONE gui=NONE cterm=NONE
  hi WhichKeySeparator guifg=#5E81AC guibg=NONE gui=NONE cterm=NONE
  hi WhichKeyGroup guifg=#4C566A guibg=NONE gui=NONE cterm=NONE
  hi WhichKeyDesc guifg=#434C5E guibg=NONE gui=NONE cterm=NONE
  hi WhichKeyFloat guibg=#FFFFFF guifg=NONE gui=NONE cterm=NONE

  " Selection and hover highlights with inverted colors
  hi CursorColumn guifg=NONE guibg=#E6E5E5 gui=NONE cterm=NONE
  hi Cursor guibg=#2E3440 guifg=#FFFFFF gui=NONE cterm=NONE
  hi lCursor guibg=#FFFFFF guifg=#2E3440 gui=NONE cterm=NONE
  hi CursorIM guibg=#FFFFFF guifg=#2E3440 gui=NONE cterm=NONE
  hi TermCursor guibg=#2E3440 guifg=#FFFFFF gui=NONE cterm=NONE
  hi TermCursorNC guibg=#FFFFFF guifg=#2E3440 gui=NONE cterm=NONE
  hi CursorLine guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
  hi CursorLineNr guifg=#3B4252 guibg=NONE gui=bold cterm=bold

  hi QuickFixLine guifg=#FFFFFF guibg=#434C5E gui=NONE cterm=NONE
  hi IncSearch guifg=#FFFFFF guibg=#3B4252 gui=NONE cterm=NONE
  hi NormalNC guibg=#FFFFFF guifg=#4C566A gui=NONE cterm=NONE
  hi Directory guifg=#3B4252 guibg=NONE gui=NONE cterm=NONE
  hi WildMenu guifg=#FFFFFF guibg=#3B4252 gui=bold cterm=bold

  " Add highlight groups for focused items with inverted colors
  hi CursorLineFold guifg=#3B4252 guibg=#FFFFFF gui=NONE cterm=NONE
  hi FoldColumn guifg=#4C566A guibg=NONE gui=NONE cterm=NONE
  hi Folded guifg=#2E3440 guibg=#E6E5E5 gui=italic cterm=italic

  " File explorer specific highlights
  hi NeoTreeNormal guibg=NONE guifg=#2E3440 gui=NONE cterm=NONE
  hi NeoTreeEndOfBuffer guibg=NONE guifg=#2E3440 gui=NONE cterm=NONE
  hi NeoTreeRootName guifg=#3B4252 guibg=NONE gui=bold cterm=bold
  hi NeoTreeFileName guifg=#2E3440 guibg=NONE gui=NONE cterm=NONE
  hi NeoTreeFileIcon guifg=#434C5E guibg=NONE gui=NONE cterm=NONE
  hi NeoTreeDirectoryName guifg=#434C5E guibg=NONE gui=NONE cterm=NONE
  hi NeoTreeDirectoryIcon guifg=#434C5E guibg=NONE gui=NONE cterm=NONE
  hi NeoTreeGitModified guifg=#4C566A guibg=NONE gui=NONE cterm=NONE
  hi NeoTreeGitAdded guifg=#5E6B8B guibg=NONE gui=NONE cterm=NONE
  hi NeoTreeGitDeleted guifg=#617C8E guibg=NONE gui=NONE cterm=NONE
  hi NeoTreeGitUntracked guifg=#7A8C99 guibg=NONE gui=NONE cterm=NONE
  hi NeoTreeIndentMarker guifg=#5E6B8B guibg=NONE gui=NONE cterm=NONE
  hi NeoTreeSymbolicLinkTarget guifg=#4C566A guibg=NONE gui=NONE cterm=NONE

  " File explorer cursor highlights with strong contrast
  " hi NeoTreeCursorLine guibg=#434C5E guifg=#FFFFFF gui=bold cterm=bold
  " hi! link NeoTreeCursor NeoTreeCursorLine
  " hi! link NeoTreeCursorLineSign NeoTreeCursorLine

  " Use wallbash colors for explorer snack in light mode
  hi WinBar guifg=#2E3440 guibg=#E6E5E5 gui=bold cterm=bold
  hi WinBarNC guifg=#4C566A guibg=#FFFFFF gui=NONE cterm=NONE
  hi ExplorerSnack guibg=#3B4252 guifg=#FFFFFF gui=bold cterm=bold
  hi BufferTabpageFill guibg=#FFFFFF guifg=#5E81AC gui=NONE cterm=NONE
  hi BufferCurrent guifg=#FFFFFF guibg=#3B4252 gui=bold cterm=bold
  hi BufferCurrentMod guifg=#FFFFFF guibg=#4C566A gui=bold cterm=bold
  hi BufferCurrentSign guifg=#3B4252 guibg=#FFFFFF gui=NONE cterm=NONE
  hi BufferVisible guifg=#2E3440 guibg=#E6E5E5 gui=NONE cterm=NONE
  hi BufferVisibleMod guifg=#4C566A guibg=#E6E5E5 gui=NONE cterm=NONE
  hi BufferVisibleSign guifg=#4C566A guibg=#FFFFFF gui=NONE cterm=NONE
  hi BufferInactive guifg=#5E81AC guibg=#FFFFFF gui=NONE cterm=NONE
  hi BufferInactiveMod guifg=#617C8E guibg=#FFFFFF gui=NONE cterm=NONE
  hi BufferInactiveSign guifg=#617C8E guibg=#FFFFFF gui=NONE cterm=NONE

  " Fix link colors to make them more visible
  hi link Hyperlink NONE
  hi link markdownLinkText NONE
  hi Underlined guifg=#FF00FF guibg=NONE gui=bold,underline cterm=bold,underline
  hi Special guifg=#FF00FF guibg=NONE gui=bold cterm=bold
  hi markdownUrl guifg=#FF00FF guibg=NONE gui=underline cterm=underline
  hi markdownLinkText guifg=#FF00FF guibg=NONE gui=bold cterm=bold
  hi htmlLink guifg=#FF00FF guibg=NONE gui=bold,underline cterm=bold,underline

  " Add more direct highlights for badges in markdown
  hi markdownH1 guifg=#FF00FF guibg=NONE gui=bold cterm=bold
  hi markdownLinkDelimiter guifg=#FF00FF guibg=NONE gui=bold cterm=bold
  hi markdownLinkTextDelimiter guifg=#FF00FF guibg=NONE gui=bold cterm=bold
  hi markdownIdDeclaration guifg=#FF00FF guibg=NONE gui=bold cterm=bold

  " === Syntax Highlight Groups (light theme) ===
  hi Comment      guifg=#4C566A guibg=NONE gui=italic cterm=italic
  hi Constant     guifg=#3B4252 guibg=NONE gui=NONE cterm=NONE
  hi String       guifg=#4C566A guibg=NONE gui=NONE cterm=NONE
  hi Character    guifg=#4C566A guibg=NONE gui=NONE cterm=NONE
  hi Number       guifg=#617C8E guibg=NONE gui=NONE cterm=NONE
  hi Float        guifg=#617C8E guibg=NONE gui=NONE cterm=NONE
  hi Boolean      guifg=#3B4252 guibg=NONE gui=NONE cterm=NONE
  hi Identifier   guifg=#2E3440 guibg=NONE gui=NONE cterm=NONE
  hi Function     guifg=#434C5E guibg=NONE gui=NONE cterm=NONE
  hi Statement    guifg=#3B4252 guibg=NONE gui=NONE cterm=NONE
  hi Keyword      guifg=#3B4252 guibg=NONE gui=bold cterm=bold
  hi Conditional  guifg=#3B4252 guibg=NONE gui=NONE cterm=NONE
  hi Repeat       guifg=#3B4252 guibg=NONE gui=NONE cterm=NONE
  hi Label        guifg=#434C5E guibg=NONE gui=NONE cterm=NONE
  hi Operator     guifg=#4C566A guibg=NONE gui=NONE cterm=NONE
  hi Exception    guifg=#617C8E guibg=NONE gui=bold cterm=bold
  hi PreProc      guifg=#434C5E guibg=NONE gui=NONE cterm=NONE
  hi Include      guifg=#4C566A guibg=NONE gui=NONE cterm=NONE
  hi Define       guifg=#3B4252 guibg=NONE gui=NONE cterm=NONE
  hi Macro        guifg=#434C5E guibg=NONE gui=NONE cterm=NONE
  hi PreCondit    guifg=#3B4252 guibg=NONE gui=NONE cterm=NONE
  hi Type         guifg=#4C566A guibg=NONE gui=NONE cterm=NONE
  hi StorageClass guifg=#3B4252 guibg=NONE gui=NONE cterm=NONE
  hi Structure    guifg=#4C566A guibg=NONE gui=NONE cterm=NONE
  hi Typedef      guifg=#4C566A guibg=NONE gui=NONE cterm=NONE
  hi Todo         guifg=#FFFFFF guibg=#4C566A gui=bold cterm=bold
  hi Error        guifg=#FFFFFF guibg=#617C8E gui=NONE cterm=NONE
  hi SpellBad     guifg=#617C8E guibg=NONE gui=undercurl cterm=undercurl
  hi SpellCap     guifg=#4C566A guibg=NONE gui=undercurl cterm=undercurl
endif

" === Treesitter Highlight Groups ===
hi link @comment Comment
hi link @comment.documentation Comment
hi link @keyword Keyword
hi link @keyword.function Keyword
hi link @keyword.return Keyword
hi link @keyword.operator Operator
hi link @keyword.import Include
hi link @keyword.export Include
hi link @keyword.coroutine Keyword
hi link @function Function
hi link @function.builtin Function
hi link @function.call Function
hi link @function.macro Macro
hi link @function.method Function
hi link @function.method.call Function
hi link @constructor Function
hi link @string String
hi link @string.escape Special
hi link @string.special Special
hi link @string.regexp Special
hi link @character Character
hi link @number Number
hi link @number.float Float
hi link @float Float
hi link @boolean Boolean
hi link @constant Constant
hi link @constant.builtin Boolean
hi link @constant.macro Macro
hi link @type Type
hi link @type.builtin Type
hi link @type.definition Typedef
hi link @type.qualifier Keyword
hi link @variable Identifier
hi link @variable.builtin Special
hi link @variable.parameter Identifier
hi link @variable.member Identifier
hi link @property Identifier
hi link @field Identifier
hi link @namespace Identifier
hi link @module Identifier
hi link @label Label
hi link @operator Operator
hi link @punctuation.delimiter Operator
hi link @punctuation.bracket Operator
hi link @punctuation.special Special
hi link @attribute PreProc
hi link @attribute.builtin PreProc
hi link @tag Statement
hi link @tag.attribute Identifier
hi link @tag.delimiter Operator
hi link @error Error
hi link @exception Exception

" === LSP Semantic Token Groups ===
hi link @lsp.type.class Type
hi link @lsp.type.comment Comment
hi link @lsp.type.decorator Function
hi link @lsp.type.enum Type
hi link @lsp.type.enumMember Constant
hi link @lsp.type.function Function
hi link @lsp.type.interface Type
hi link @lsp.type.keyword Keyword
hi link @lsp.type.macro Macro
hi link @lsp.type.method Function
hi link @lsp.type.modifier Keyword
hi link @lsp.type.namespace Identifier
hi link @lsp.type.number Number
hi link @lsp.type.operator Operator
hi link @lsp.type.parameter Identifier
hi link @lsp.type.property Identifier
hi link @lsp.type.string String
hi link @lsp.type.struct Type
hi link @lsp.type.type Type
hi link @lsp.type.typeParameter Type
hi link @lsp.type.variable Identifier
hi link @lsp.mod.readonly Constant
hi link @lsp.mod.static StorageClass
hi link @lsp.mod.deprecated DiagnosticDeprecated

" === Diagnostic Groups ===
hi DiagnosticError            guifg=#7A8C99 guibg=NONE gui=NONE cterm=NONE
hi DiagnosticWarn             guifg=#7A8C99 guibg=NONE gui=NONE cterm=NONE
hi DiagnosticInfo             guifg=#7A8C99 guibg=NONE gui=NONE cterm=NONE
hi DiagnosticHint             guifg=#7A8C99 guibg=NONE gui=NONE cterm=NONE
hi DiagnosticVirtualTextError guifg=#7A8C99 guibg=NONE gui=italic cterm=italic
hi DiagnosticVirtualTextWarn  guifg=#7A8C99 guibg=NONE gui=italic cterm=italic
hi DiagnosticVirtualTextInfo  guifg=#7A8C99 guibg=NONE gui=italic cterm=italic
hi DiagnosticVirtualTextHint  guifg=#7A8C99 guibg=NONE gui=italic cterm=italic
hi DiagnosticUnderlineError   guifg=NONE guibg=NONE gui=undercurl cterm=undercurl
hi DiagnosticUnderlineWarn    guifg=NONE guibg=NONE gui=undercurl cterm=undercurl
hi DiagnosticUnderlineInfo    guifg=NONE guibg=NONE gui=undercurl cterm=undercurl
hi DiagnosticUnderlineHint    guifg=NONE guibg=NONE gui=undercurl cterm=undercurl

" UI elements that are the same in both themes with transparent backgrounds
hi NormalFloat guibg=NONE guifg=NONE gui=NONE cterm=NONE
hi FloatBorder guifg=#4C566A guibg=NONE gui=NONE cterm=NONE
hi SignColumn guifg=NONE guibg=NONE gui=NONE cterm=NONE
hi DiffAdd guifg=#FFFFFF guibg=#7A8C99 gui=NONE cterm=NONE
hi DiffChange guifg=#FFFFFF guibg=#617C8E gui=NONE cterm=NONE
hi DiffDelete guifg=#FFFFFF guibg=#617C8E gui=NONE cterm=NONE
hi TabLineFill guifg=NONE guibg=NONE gui=NONE cterm=NONE

" Fix selection highlighting with proper color derivatives
hi TelescopeSelection guibg=#D8E0E9 guifg=#2E3440 gui=bold cterm=bold
hi TelescopeSelectionCaret guifg=#FFFFFF guibg=#D8E0E9 gui=bold cterm=bold
hi TelescopeMultiSelection guibg=#A1B2C2 guifg=#2E3440 gui=bold cterm=bold
hi TelescopeMatching guifg=#7A8C99 guibg=NONE gui=bold cterm=bold

" Minimal fix for explorer selection highlighting
hi NeoTreeCursorLine guibg=#D8E0E9 guifg=#2E3440 gui=bold

" Fix for LazyVim menu selection highlighting
hi Visual guibg=#D8E0E9 guifg=#2E3440 gui=bold
hi CursorLine guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi PmenuSel guibg=#D8E0E9 guifg=#2E3440 gui=bold
hi WildMenu guibg=#D8E0E9 guifg=#2E3440 gui=bold

" Create improved autocommands to ensure highlighting persists with NeoTree focus fixes
augroup WallbashSelectionFix
  autocmd!
  " Force these persistent highlights with transparent backgrounds where possible
  autocmd ColorScheme * if &background == 'dark' |
    \ hi Normal guibg=NONE |
    \ hi NeoTreeNormal guibg=NONE |
    \ hi SignColumn guibg=NONE |
    \ hi NormalFloat guibg=NONE |
    \ hi FloatBorder guibg=NONE |
    \ hi TabLineFill guibg=NONE |
    \ else |
    \ hi Normal guibg=NONE |
    \ hi NeoTreeNormal guibg=NONE |
    \ hi SignColumn guibg=NONE |
    \ hi NormalFloat guibg=NONE |
    \ hi FloatBorder guibg=NONE |
    \ hi TabLineFill guibg=NONE |
    \ endif

  " Force NeoTree background to be transparent even when unfocused
  autocmd WinEnter,WinLeave,BufEnter,BufLeave * if &ft == 'neo-tree' || &ft == 'NvimTree' |
    \ hi NeoTreeNormal guibg=NONE |
    \ hi NeoTreeEndOfBuffer guibg=NONE |
    \ endif

  " Fix NeoTree unfocus issue specifically in LazyVim
  autocmd VimEnter,ColorScheme * hi link NeoTreeNormalNC NeoTreeNormal

  autocmd ColorScheme * hi CursorLine guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

  " Make links visible across modes
  autocmd ColorScheme * if &background == 'dark' |
    \ hi Underlined guifg=#FF00FF guibg=NONE gui=bold,underline cterm=bold,underline |
    \ hi Special guifg=#FF00FF guibg=NONE gui=bold cterm=bold |
    \ else |
    \ hi Underlined guifg=#FF00FF guibg=NONE gui=bold,underline cterm=bold,underline |
    \ hi Special guifg=#FF00FF guibg=NONE gui=bold cterm=bold |
    \ endif

  " Fix markdown links specifically
  autocmd FileType markdown hi markdownUrl guifg=#FF00FF guibg=NONE gui=underline,bold
  autocmd FileType markdown hi markdownLinkText guifg=#FF00FF guibg=NONE gui=bold
  autocmd FileType markdown hi markdownIdDeclaration guifg=#FF00FF guibg=NONE gui=bold
  autocmd FileType markdown hi htmlLink guifg=#FF00FF guibg=NONE gui=bold,underline
augroup END

" Create a more aggressive fix for NeoTree background in LazyVim
augroup FixNeoTreeBackground
  autocmd!
  " Force NONE background for NeoTree at various points to override tokyonight fallback
  autocmd ColorScheme,VimEnter,WinEnter,BufEnter * hi NeoTreeNormal guibg=NONE guifg=#FFFFFF ctermbg=NONE
  autocmd ColorScheme,VimEnter,WinEnter,BufEnter * hi NeoTreeNormalNC guibg=NONE guifg=#FFFFFF ctermbg=NONE
  autocmd ColorScheme,VimEnter,WinEnter,BufEnter * hi NeoTreeEndOfBuffer guibg=NONE guifg=#FFFFFF ctermbg=NONE

  " Also fix NvimTree for NvChad
  autocmd ColorScheme,VimEnter,WinEnter,BufEnter * hi NvimTreeNormal guibg=NONE guifg=#FFFFFF ctermbg=NONE
  autocmd ColorScheme,VimEnter,WinEnter,BufEnter * hi NvimTreeNormalNC guibg=NONE guifg=#FFFFFF ctermbg=NONE
  autocmd ColorScheme,VimEnter,WinEnter,BufEnter * hi NvimTreeEndOfBuffer guibg=NONE guifg=#FFFFFF ctermbg=NONE

  " Apply highlight based on current theme
  autocmd ColorScheme,VimEnter * if &background == 'dark' |
    \ hi NeoTreeCursorLine guibg=#D8E0E9 guifg=#2E3440 gui=bold cterm=bold |
    \ hi NvimTreeCursorLine guibg=#D8E0E9 guifg=#2E3440 gui=bold cterm=bold |
    \ else |
    \ hi NeoTreeCursorLine guibg=#3B4252 guifg=#FFFFFF gui=bold cterm=bold |
    \ hi NvimTreeCursorLine guibg=#3B4252 guifg=#FFFFFF gui=bold cterm=bold |
    \ endif

  " Force execution after other plugins have loaded
  autocmd VimEnter * doautocmd ColorScheme
augroup END

" Add custom autocommand specifically for LazyVim markdown links
augroup LazyVimMarkdownFix
  autocmd!
  " Force link visibility in LazyVim with stronger override
  autocmd FileType markdown,markdown.mdx,markdown.gfm hi! def link markdownUrl MagentaLink
  autocmd FileType markdown,markdown.mdx,markdown.gfm hi! def link markdownLinkText MagentaLink
  autocmd FileType markdown,markdown.mdx,markdown.gfm hi! def link markdownLink MagentaLink
  autocmd FileType markdown,markdown.mdx,markdown.gfm hi! def link markdownLinkDelimiter MagentaLink
  autocmd FileType markdown,markdown.mdx,markdown.gfm hi! MagentaLink guifg=#FF00FF gui=bold,underline

  " Apply when LazyVim is detected
  autocmd User LazyVimStarted doautocmd FileType markdown
  autocmd VimEnter * if exists('g:loaded_lazy') | doautocmd FileType markdown | endif
augroup END

" Add custom autocommand specifically for markdown files with links
augroup MarkdownLinkFix
  autocmd!
  " Use bright hardcoded magenta that will definitely be visible
  autocmd FileType markdown hi markdownUrl guifg=#FF00FF guibg=NONE gui=underline,bold
  autocmd FileType markdown hi markdownLinkText guifg=#FF00FF guibg=NONE gui=bold
  autocmd FileType markdown hi markdownIdDeclaration guifg=#FF00FF guibg=NONE gui=bold
  autocmd FileType markdown hi htmlLink guifg=#FF00FF guibg=NONE gui=bold,underline

  " Force these highlights right after vim loads
  autocmd VimEnter * if &ft == 'markdown' | doautocmd FileType markdown | endif
augroup END

" Remove possibly conflicting previous autocommands
augroup LazyVimFix
  autocmd!
augroup END

augroup MinimalExplorerFix
  autocmd!
augroup END
