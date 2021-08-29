" Custom syntax highlighting for git log graph display using the format,
"
"     :Git log --graph --pretty=format:'%h -%d %s (%cr) <%an>' --abbrev-commit
"
syn match gitLgLine     /^[_\*|\/\\ ]\+\(\<\x\{4,40\}\>.*\)\?$/
syn match gitLgHead     /^[_\*|\/\\ ]\+\(\<\x\{4,40\}\> - \(([^)]\+)\)\? \)\?/ contained containedin=gitLgLine
syn match gitLgRefs     /([^)]*)/ contained containedin=gitLgHead
syn match gitLgGraph    /^[_\*|\/\\ ]\+/ contained containedin=gitLgHead,gitLgCommit nextgroup=gitHashAbbrev skipwhite
syn match gitLgCommit   /^[^-]\+- / contained containedin=gitLgHead nextgroup=gitLgRefs skipwhite
syn match gitLgDate     /(\d\+ \l\+ ago)/ contained containedin=gitLgLine nextgroup=gitLgIdentity skipwhite
syn match gitLgIdentity /<[^>]*>$/ contained containedin=gitLgLine

hi def link gitLgGraph    Comment
hi def link gitLgDate     gitDate
hi def link gitLgRefs     gitReference
hi def link gitLgIdentity gitIdentity
