function packages-aur --wraps=paru\ -Qqm\ \|\ fzf\ --preview\ \'paru\ -Qil\ \{\}\'\ --layout=reverse\ --bind\ \'enter:execute\(paru\ -Qil\ \{\}\ \|\ less\)\' --description alias\ packages-aur=paru\ -Qqm\ \|\ fzf\ --preview\ \'paru\ -Qil\ \{\}\'\ --layout=reverse\ --bind\ \'enter:execute\(paru\ -Qil\ \{\}\ \|\ less\)\'
  paru -Qqm | fzf --preview 'paru -Qil {}' --layout=reverse --bind 'enter:execute(paru -Qil {} | less)' $argv
        
end
