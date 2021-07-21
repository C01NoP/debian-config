alias upd="sudo apt update"
function check
    apt list --upgradable | column -t \
    | while read -la line
        echo (set_color green --bold)"$line[1]"(set_color normal)\t"$line[2]"\t"$line[6]"
    end | column -t | tr -d "]"
end
alias up="upd ; check ; sudo apt upgrade"
alias clean="sudo apt clean all"
alias arm="clean ; sudo apt autoremove"
alias tes4="cd ~/.wine/drive_c/Program\ Files\ \(x86\)/Bethesda\ Softworks/Oblivion/ ; wine Oblivion.exe"
alias r6="cd ~/.wine/drive_c/Program\ Files\ \(x86\)/Ubisoft/r6v/Binaries/ ; wine R6Vegas_Game.exe"
set -g theme_display_git no
set -g theme_display_git_dirty no
set -g theme_display_git_untracked no
set -g theme_display_git_ahead_verbose yes
set -g theme_display_git_dirty_verbose yes
set -g theme_display_git_stashed_verbose yes
set -g theme_display_git_default_branch yes
set -g theme_git_default_branches master main
set -g theme_git_worktree_support yes
set -g theme_use_abbreviated_branch_name yes
set -g theme_display_vagrant yes
set -g theme_display_docker_machine no
set -g theme_display_k8s_context yes
set -g theme_display_hg yes
set -g theme_display_virtualenv no
set -g theme_display_nix no
set -g theme_display_ruby no
set -g theme_display_node yes
set -g theme_display_user ssh
set -g theme_display_hostname ssh
set -g theme_display_vi no
set -g theme_display_date no
set -g theme_display_cmd_duration yes
set -g theme_title_display_process yes
set -g theme_title_display_path no
set -g theme_title_display_user yes
set -g theme_title_use_abbreviated_path no
set -g theme_date_format "+%a %H:%M"
set -g theme_date_timezone America/Chicago
set -g theme_avoid_ambiguous_glyphs yes
set -g theme_powerline_fonts no
set -g theme_nerd_fonts yes
set -g theme_show_exit_status yes
set -g theme_display_jobs_verbose yes
set -g default_user your_normal_user
set -g theme_color_scheme dark
set -g fish_prompt_pwd_dir_length 0
set -g theme_project_dir_length 1
set -g theme_newline_cursor yes
set -g theme_newline_prompt '$ '
