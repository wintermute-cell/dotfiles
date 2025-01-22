function shellmind
    # ===================
    # CONFIGURATION

    # [0.0 to 1.0], determines "creativity" of the model,
    # higher is more creative
    set TEMPERATURE 0.3

    # An addition to the base prompt, if desired
    set ADDITIONAL_PROMPT ""

    # The openai model name. Options: https://platform.openai.com/docs/models
    set MODEL "gpt-4o-mini"

    # END CONFIGURATION
    # ===================

    set current_cmd (commandline --current-buffer)
    if test -z "$current_cmd"
        return
    end

    echo -e "\033[2K\rThinking..."

    set openai_key $OPENAI_API_KEY
    if test -z "$openai_key"
        echo "OpenAI API key not set. Please set the OPENAI_API_KEY environment variable." 1>&2
        return
    end

    set base_prompt "You are a command line assistant. You have complete knowledge of linux command and cli tools. Your input is a pseudo code form of a command line job. Your output is the actual command line job, implemented and formatted as closely as makes sense to the pseudo code input. You might need to add additional flags or arguments, or even rewrite or implement some parts or all of it from scratch. Your number one priority is writing a command that achieves what the user INTENDS. Focus on small details and do not overlook anything. Only ever output the command, no explanation or additional information. Do not wrap the output in a markdown code block. The raw code is the only allowed response. If you are unsure of the correct command, output a message indicating that you are unable to process the input, giving a reason why."

    set base_prompt (string join "" $base_prompt " You are writing a command for the fish shell.")

    if test -n "$ADDITIONAL_PROMPT"
        set prompt (string join "\n" $base_prompt $ADDITIONAL_PROMPT)
    end

    set prompt (string join "\n\n" $base_prompt "Input: " $current_cmd)

    # escape the prompt for json
    set escaped_prompt (echo $prompt | jq -R -s '.')

    set json_data "{\"model\":\"$MODEL\",\"messages\":[{\"role\":\"user\",\"content\":$escaped_prompt}],\"temperature\":$TEMPERATURE}"

    set resp (curl -s "https://api.openai.com/v1/chat/completions" \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $OPENAI_API_KEY" \
        -d "$json_data"
    )

    set completion (echo $resp | jq -r '.choices[0].message.content')
    if test -z "$completion"
        echo "An error occurred while processing the input. Please try again." 1>&2
        return
    end

    commandline -r $completion
    commandline -f repaint
end
