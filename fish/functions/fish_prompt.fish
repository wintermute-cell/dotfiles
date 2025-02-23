function fish_prompt
    # This prompt shows:
    # - green lines if the last return command is OK, red otherwise
    # - your user name, in red if root or yellow otherwise
    # - your hostname, in cyan if ssh or blue otherwise
    # - the current path (with prompt_pwd)
    # - date +%X
    # - the current virtual environment, if any
    # - the current git status, if any, with fish_git_prompt
    # - the current battery state, if any, and if your power cable is unplugged, and if you have "acpi"
    # - current background jobs, if any

    set -l retc red
    test $status = 0; and set retc green

    set -q __fish_git_prompt_showupstream
    or set -g __fish_git_prompt_showupstream auto

    function _nim_prompt_wrapper
        set retc $argv[1]
        set -l field_name $argv[2]
        set -l field_value $argv[3]

        set_color normal
        set_color $retc
        echo -n '─'
        set_color -o green
        echo -n '['
        set_color normal
        test -n $field_name
        and echo -n $field_name:
        set_color $retc
        echo -n $field_value
        set_color -o green
        echo -n ']'
    end

    # [user@host] my_current/working_dir
    #   nix, V, git:dev= 𑦪

    # start with bright black
    set_color brblack

    # if we show ssh or path, break to new line before each prompt
    if test -n "$SSH_CLIENT" -o "$PWD" != "$HOME"
        echo ''  # newline
    end

    # conditionally print user and host for ssh sessions :: "[user@host]"
    if test -z "$SSH_CLIENT"
    else
        echo -n '['
        echo -n $USER
        echo -n @
        echo -n (prompt_hostname)
        echo -n '] '
    end

    # print the current working directory :: "[user@host] my_current/working_dir"
    set -g fish_prompt_pwd_full_dirs 2  # 2 full size path components
    set -g fish_prompt_pwd_dir_length 4  # shortened components are 4 characters long
    echo -n (prompt_pwd)

    # continue with normal black
    set_color black

    # break to new line and indent if ssh session or non "~" working dir
    if test -n "$SSH_CLIENT" -o "$PWD" != "$HOME"
        echo ''  # newline
        echo -n '  '  # indent
    else
        echo -n ' '  # space
    end

    # conditionally print nix-shell info :: "  nix"
    set -l nix_shell_info (
        if test -n "$IN_NIX_SHELL"
            echo -n "nix"
        end
    )
    echo -n -s $nix_shell_info

    # conditionally print virtual environment info :: "my_current/working_dir :: nix, V"
    set -xg VIRTUAL_ENV_DISABLE_PROMPT 1
    if set -q VIRTUAL_ENV 
        if test -n "$nix_shell_info"
            echo -n ', '
        end
        echo -n "V:"
        echo -n (basename "$VIRTUAL_ENV")
    end

    # conditionally print git info :: "my_current/working_dir :: nix, git:dev= "
    set -l prompt_git (fish_git_prompt '%s')
    if test -n "$prompt_git"
        if test -n "$VIRTUAL_ENV" -o -n "$nix_shell_info"
            echo -n ', '
        end
        echo -n "git:$prompt_git"
    end

    # print prompt symbol and a spacer :: "my_current/working_dir :: nix, git:dev= 𑦪 "
    set_color $retc
        if test -n "$nix_shell_info" -o -n "$prompt_git" -o -n "$VIRTUAL_ENV"
            echo -n ' '
        end
    echo -n '𑦪'
    set_color normal
    echo -n ' '

    # NOTE: maybe use this?
    #
    # if functions -q fish_is_root_user; and fish_is_root_user
    #     set_color -o red
    # else
    #     set_color -o yellow
    # end


    # Vi-mode
    # The default mode prompt would be prefixed, which ruins our alignment.
    # function fish_mode_prompt
    # end
    #
    # if test "$fish_key_bindings" = fish_vi_key_bindings
    #     or test "$fish_key_bindings" = fish_hybrid_key_bindings
    #     set -l mode
    #     switch $fish_bind_mode
    #         case default
    #             set mode (set_color --bold red)N
    #         case insert
    #             set mode (set_color --bold green)I
    #         case replace_one
    #             set mode (set_color --bold green)R
    #             echo '[R]'
    #         case replace
    #             set mode (set_color --bold cyan)R
    #         case visual
    #             set mode (set_color --bold magenta)V
    #     end
    #     set mode $mode(set_color normal)
    #     _nim_prompt_wrapper $retc '' $mode
    # end

    # Background jobs
    # set_color normal
    #
    # for job in (jobs)
    #     set_color $retc
    #     echo -n '│ '
    #     set_color brown
    #     echo $job
    # end
end
