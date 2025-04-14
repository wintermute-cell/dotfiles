FILEPATH="./Taskfile.yml"

if [ -f "$FILEPATH" ]; then
  echo "Taskfile.yml already exists!"
  exit 1
fi

CONTENT="version: '3'

tasks:
  hello:
    cmds:
      - echo 'Hello World from Task!'
    silent: true"

echo "$CONTENT" > "$FILEPATH"
