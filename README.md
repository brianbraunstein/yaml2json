# Command line YAML to JSON converter

Example:
```
yaml2json < in_file.yaml > out_file.json
```

Really meant for this purpose:
```
cat file.yaml | yaml2json | jq '.do.something'
```

