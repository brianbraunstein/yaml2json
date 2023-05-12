
package main

import (
  "encoding/json"
  "fmt"
  "io"
  "os"
  yaml "gopkg.in/yaml.v3"
)

func main() {
  stdinData, err := io.ReadAll(os.Stdin)
  if err != nil {
    fmt.Println("io.ReadAll error: %v", err)
    os.Exit(10)
    return
  }
  //golangData := make(map[string]any)
  var golangData any
  err = yaml.Unmarshal(stdinData, &golangData)
  if err != nil {
    fmt.Println("yaml.Unmarshal error: %v", err)
    os.Exit(20)
    return
  }

  jsonData, err := json.Marshal(golangData)
  if err != nil {
    fmt.Println("json.Marshal error: %v", err)
    os.Exit(30)
    return
  }

  fmt.Println(string(jsonData))
}

