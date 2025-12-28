if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_prompt_pwd_dir_length 0

abbr "g" "git"
abbr "gga" "gg amend"
abbr "ggc" "gg commit"
abbr "gl" "git log"
abbr "gp" "git push"
abbr "gpf" "git push --force-with-lease"
abbr "gs" "git status"
abbr "gup" "git pull --rebase"
abbr "sw" "gg switch"
abbr "swr" "gg switch --remote"
abbr "swd" "git switch --detach"
