function mkcd
    if test (count $argv) -eq 1
        mkdir -p $argv[1] && cd $argv[1]
    else
        echo "Usage: mkcd <directory>"
        return 1
    end
end
