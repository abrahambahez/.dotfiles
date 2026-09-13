" Have j and k navigate visual lines rather than logical ones
nmap j gj
nmap k gk

" Go to beginning/end of line
nmap gh ^
nmap gl $

" Cycle between tabs
exmap tabprev obcommand workspace:previous-tab
nmap H :tabprev<CR>
exmap tabnext obcommand workspace:next-tab
nmap L :tabnext<CR>

" Yank to system clipboard
set clipboard=unnamed

" Focus on splits
exmap ftop obcommand editor:focus-top
nmap <C-k> :ftop<CR>
exmap fbottom obcommand editor:focus-bottom
nmap <C-j> :fbottom<CR>
exmap fleft obcommand editor:focus-left
nmap <C-h> :fleft<CR>
exmap fright obcommand editor:focus-right
nmap <C-l> :fright<CR>

" Have to unmap space to use it
unmap <Space>

" Save file
exmap save obcommand editor:save-file
nmap <Space>w :save<CR>

" Go to link
exmap follow obcommand editor:follow-link
nmap gd :follow<CR>

" Rename title
exmap rename obcommand workspace:edit-file-title
nmap <Space>r :rename<CR>

" Insert templates
exmap ins_temp obcommand insert-template
nmap <Space>t :ins_temp<CR>

" Insert templates
exmap toggleBacklinks obcommand backlink:toggle-backlinks-in-document
nmap <Space>b :toggleBacklinks<CR>

" Insert templates
exmap backlinks obcommand backlink:open
nmap <Space>B :backlinks<CR>

" Toggle file explorer
exmap tleftbar obcommand app:toggle-left-sidebar
nmap <Space>e :tleftbar<CR>

" Toggle Right Sidebar
exmap trightbar obcommand app:toggle-right-sidebar
nmap <Space>E :trightbar<CR>

" Open today's note
exmap daily obcommand daily-notes
nmap <Space>d :daily<CR>

" Open cmd palette
exmap cmd obcommand command-palette:open
nmap <Space>sp :cmd<CR>

" Open file search
exmap fileSearch obcommand switcher:open
nmap <Space>sf :fileSearch<CR>

" Toggle focus mode
" REQUIRES STILLE PLUGIN
exmap focus obcommand obsidian-stille:toggleStille
nmap <Space>z :focus<CR>

" Focus on global search input
exmap globalSearch obcommand global-search:open
nmap <Space>sg :globalSearch<CR>

" Open citation Search
" REQUIRES CITATIONS PLUGIN
exmap insertMarkdownCitation obcommand obsidian-citation-plugin:insert-markdown-citation
nmap <Space>sc :insertMarkdownCitation<CR>

" Open citattion Search
" REQUIRES CITATION PLUGIN
exmap openLitNote obcommand obsidian-citation-plugin:open-literature-note
nmap <Space>sC :openLitNote<CR>

" Open tab Quickswitcher
" REQUIRES TAB NAVIGATOR PLUGIN
exmap searchTabs obcommand tab-navigator:search-tabs
nmap <Space><Space> :searchTabs<CR>

" Navigate outline of the document
" REQUIRES GO TO HEADING PLUGIN
exmap outline obcommand oin-gotoheading:gotoheading-switcher
nmap <Space>st :outline<CR>

" Go to next Heading
" REQUIRES GO TO HEADING PLUGIN
exmap goNextHeading obcommand oin-gotoheading:gotoheading-next
nmap ] :goNextHeading<CR>

" Go to previous Heading
" REQUIRES GO TO HEADING PLUGIN
exmap goPrevHeading obcommand oin-gotoheading:gotoheading-previous
nmap [ :goPrevHeading<CR>

" Close current tab
exmap close obcommand workspace:close
nmap <Space>c :close<CR>

" Paste into selection (for creating links)
map <Space>p :pasteinto<CR>

" Quickly remove search highlights
nmap <Space>h :nohl<CR>

" Splits
exmap vsplit obcommand workspace:split-vertical
nmap <Space>v :vsplit<CR>
exmap hsplit obcommand workspace:split-horizontal
nmap <Space>V :hsplit<CR>

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
map sk :surround_wiki<CR>
map s" :surround_double_quotes<CR>
map s' :surround_single_quotes<CR>
map s` :surround_backticks<CR>
map sb :surround_brackets<CR>
map s( :surround_brackets<CR>
map s) :surround_brackets<CR>
map s[ :surround_square_brackets<CR>
map s] :surround_square_brackets<CR>
map s{ :surround_curly_brackets<CR>
map s} :surround_curly_brackets<CR>
