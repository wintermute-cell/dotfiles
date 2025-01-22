function fish_user_key_bindings
    # Enable general vi bindings
    fish_vi_key_bindings

    # Inject emacs style bindings in insert mode
    fish_default_key_bindings -M insert

    # Then execute the vi-bindings so they take precedence when there's a conflict.
    # Without --no-erase fish_vi_key_bindings will default to
    # resetting all bindings.
    # The argument specifies the initial mode (insert, "default" or visual).
    fish_vi_key_bindings --no-erase insert

    bind -M insert \cx 'shellmind'
end
