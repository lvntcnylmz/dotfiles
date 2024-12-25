function packages --wraps=pacman\ -Qq\ \|\ fzf\ --preview\ \'pacman\ -Qil\ \{\}\'\ --layout=reverse\ --bind\ \'enter:execute\(pacman\ -Qil\ \{\}\ \|\ less\)\' --wraps=paru\ -Qq\ \|\ fzf\ --preview\ \'paru\ -Qil\ \{\}\'\ --layout=reverse\ --bind\ \'enter:execute\(pacman\ -Qil\ \{\}\ \|\ less\)\' --wraps=paru\ -Qq\ \|\ fzf\ --preview\ \'paru\ -Qil\ \{\}\'\ --layout=reverse\ --bind\ \'enter:execute\(paru\ -Qil\ \{\}\ \|\ less\)\' --description alias\ packages=paru\ -Qq\ \|\ fzf\ --preview\ \'paru\ -Qil\ \{\}\'\ --layout=reverse\ --bind\ \'enter:execute\(paru\ -Qil\ \{\}\ \|\ less\)\'
  paru -Qq | fzf --preview 'paru -Qil {}' --layout=reverse --bind 'enter:execute(paru -Qil {} | less)' $argv
        
end
