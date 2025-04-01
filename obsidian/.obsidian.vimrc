" Have j and k navigate visual lines rather than logical ones
nmap j gj
nmap k gk

" Go to beginning/end of line
nmap gh ^
nmap gl $

" Cycle between tabs
exmap tabprev obcommand workspace:previous-tab
nmap H :tabprev
exmap tabnext obcommand workspace:next-tab
nmap L :tabnext

" Yank to system clipboard
set clipboard=unnamed

" Focus on splits
exmap ftop obcommand editor:focus-top
nmap <C-k> :ftop
exmap fbottom obcommand editor:focus-bottom
nmap <C-j> :fbottom
exmap fleft obcommand editor:focus-left
nmap <C-h> :fleft
exmap fright obcommand editor:focus-right
nmap <C-l> :fright

" Have to unmap space to use it
unmap <Space>

" Save file
exmap save obcommand editor:save-file
nmap <Space>w :save

" Go to link
exmap follow obcommand editor:follow-link
nmap gd :follow

" Rename title
exmap rename obcommand workspace:edit-file-title
nmap <Space>r :rename

" Insert templates
exmap ins_temp obcommand insert-template
nmap <Space>t :ins_temp

" Toogle backlonks in document
exmap toggleBacklinks obcommand backlink:toggle-backlinks-in-document
nmap <Space>zB :toggleBacklinks

" Open backlinks pane
exmap openBacklinks obcommand backlink:open
nmap <Space>zb :openBacklinks

" Open tag pane
exmap openTagPane obcommand tag-pane:open
nmap <Space>zt :openTagPane

" Insert templates
exmap backlinks obcommand backlink:open
nmap <Space>B :backlinks

" Toggle file explorer
exmap tleftbar obcommand app:toggle-left-sidebar
nmap <Space>e :tleftbar

" Toggle Right Sidebar
exmap trightbar obcommand app:toggle-right-sidebar
nmap <Space>E :trightbar

" Open today's note
exmap daily obcommand daily-notes
nmap <Space>zd :daily

" Open cmd palette
exmap cmd obcommand command-palette:open
nmap <Space>sp :cmd

" Open file search
exmap fileSearch obcommand switcher:open
nmap <Space>sf :fileSearch

" Toggle focus mode
" REQUIRES STILLE PLUGIN
exmap focus obcommand obsidian-stille:toggleStille
nmap <Space>zf :focus

" Focus on global search input
exmap globalSearch obcommand global-search:open
nmap <Space>sg :globalSearch

" Open citation Search
" REQUIRES CITATIONS PLUGIN
exmap insertMarkdownCitation obcommand obsidian-citation-plugin:insert-markdown-citation
nmap <Space>sc :insertMarkdownCitation

" Open citattion Search
" REQUIRES CITATION PLUGIN
exmap openLitNote obcommand obsidian-citation-plugin:open-literature-note
nmap <Space>sC :openLitNote

" Open tab Quickswitcher
" REQUIRES TAB NAVIGATOR PLUGIN
exmap searchTabs obcommand tab-navigator:search-tabs
nmap <Space><Space> :searchTabs

" Navigate outline of the document
" REQUIRES GO TO HEADING PLUGIN
exmap outline obcommand oin-gotoheading:gotoheading-switcher
nmap <Space>st :outline

" Go to next Heading
" REQUIRES GO TO HEADING PLUGIN
exmap goNextHeading obcommand oin-gotoheading:gotoheading-next
nmap ] :goNextHeading

" Go to previous Heading
" REQUIRES GO TO HEADING PLUGIN
exmap goPrevHeading obcommand oin-gotoheading:gotoheading-previous
nmap [ :goPrevHeading

" Close current tab
exmap close obcommand workspace:close
nmap <Space>c :close

" Paste into selection (for creating links)
map <Space>p :pasteinto

" Quickly remove search highlights
nmap <Space>h :nohl

" Splits
exmap vsplit obcommand workspace:split-vertical
nmap <Space>v :vsplit
exmap hsplit obcommand workspace:split-horizontal
nmap <Space>V :hsplit

" Surround
exmap surround_wiki surround [[ ]]
exmap surround_double_quotes surround " "
exmap surround_single_quotes surround ' '
exmap surround_backticks surround ` `
exmap surround_brackets surround ( )
exmap surround_square_brackets surround [ ]
exmap surround_curly_brackets surround { }

nunmap s
vunmap s
map sk :surround_wiki
map s" :surround_double_quotes
map s' :surround_single_quotes
map s` :surround_backticks
map sb :surround_brackets
map s( :surround_brackets
map s) :surround_brackets
map s[ :surround_square_brackets
map s] :surround_square_brackets
map s{ :surround_curly_brackets
map s} :surround_curly_brackets
