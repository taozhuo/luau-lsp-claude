# Luau LSP Plugin for Claude Code

A Language Server Protocol (LSP) plugin that brings full Luau/Roblox code intelligence to [Claude Code](https://claude.ai/code).

## Features

- **Real-time Diagnostics** - Type errors, deprecated API warnings, unused variables
- **Hover Documentation** - View API docs, type signatures, and parameter info
- **Go to Definition** - Jump to where functions and variables are defined
- **Find References** - Find all usages of any symbol
- **Document Symbols** - List all functions and variables in a file
- **Call Hierarchy** - See what calls a function and what it calls
- **Full Roblox API Support** - Complete type definitions for all Roblox classes and services
- **Deprecation Warnings** - Alerts for deprecated APIs with suggested replacements

## Installation

### Prerequisites

1. **Claude Code** - Install from [claude.ai/code](https://claude.ai/code)
2. **luau-lsp binary** - The language server

#### Installing luau-lsp

**macOS:**
```bash
# Download latest release
curl -sL https://github.com/JohnnyMorganz/luau-lsp/releases/latest/download/luau-lsp-macos.zip -o /tmp/luau-lsp.zip
unzip /tmp/luau-lsp.zip -d /tmp
chmod +x /tmp/luau-lsp
mv /tmp/luau-lsp /usr/local/bin/  # or ~/bin/
```

**Linux:**
```bash
# For x86_64
curl -sL https://github.com/JohnnyMorganz/luau-lsp/releases/latest/download/luau-lsp-linux-x86_64.zip -o /tmp/luau-lsp.zip
unzip /tmp/luau-lsp.zip -d /tmp
chmod +x /tmp/luau-lsp
sudo mv /tmp/luau-lsp /usr/local/bin/
```

**Windows:**
Download from [GitHub Releases](https://github.com/JohnnyMorganz/luau-lsp/releases) and add to PATH.

### Installing the Plugin

#### Option 1: Test locally (development)
```bash
git clone https://github.com/anthropics/luau-lsp-plugin.git
cd luau-lsp-plugin
claude --plugin-dir .
```

#### Option 2: Install permanently
```bash
git clone https://github.com/anthropics/luau-lsp-plugin.git ~/.claude/plugins/cache/local/luau-lsp

# Add to installed_plugins.json and settings.json (see Configuration section)
```

## Configuration

### Plugin Structure

```
luau-lsp/
├── .claude-plugin/
│   └── plugin.json          # Plugin manifest
├── .lsp.json                 # LSP server configuration
├── globalTypes.d.luau        # Roblox type definitions
├── api-docs.json             # API documentation
├── scripts/
│   ├── update-types.sh       # Update Roblox API definitions
│   ├── check-version.sh      # Check for updates
│   └── api                   # Quick API lookup tool
└── README.md
```

### .lsp.json Configuration

```json
{
  "luau": {
    "command": "/path/to/luau-lsp",
    "args": [
      "lsp",
      "--definitions=/path/to/globalTypes.d.luau",
      "--docs=/path/to/api-docs.json"
    ],
    "extensionToLanguage": {
      ".lua": "luau",
      ".luau": "luau"
    },
    "initializationOptions": {
      "platform": {
        "type": "roblox"
      },
      "types": {
        "roblox": true,
        "robloxSecurityLevel": "PluginSecurity"
      }
    }
  }
}
```

## Usage

Once installed and Claude Code is restarted, the LSP provides automatic code intelligence for `.lua` and `.luau` files.

### Available LSP Operations

| Operation | Description | Example Use |
|-----------|-------------|-------------|
| `hover` | Get documentation at cursor | "What does Raycast return?" |
| `goToDefinition` | Jump to definition | "Go to where this function is defined" |
| `findReferences` | Find all usages | "Where is this variable used?" |
| `documentSymbol` | List file symbols | "Show all functions in this file" |
| `workspaceSymbol` | Search project symbols | "Find the PlayerService module" |
| `incomingCalls` | What calls this | "What functions call this?" |
| `outgoingCalls` | What this calls | "What does this function call?" |

### Checking for Errors

Run diagnostics on any Luau file:
```bash
luau-lsp analyze --definitions=globalTypes.d.luau your-file.luau
```

### Looking Up APIs

Use the included lookup tool:
```bash
./scripts/api Raycast
./scripts/api TweenService
./scripts/api "Humanoid.MoveTo"
```

## Keeping Types Up to Date

Roblox updates their API frequently. Update your type definitions:

```bash
# Check current versions
./scripts/check-version.sh

# Update all type definitions
./scripts/update-types.sh
```

This downloads:
- `globalTypes.d.luau` - Type definitions for all Roblox classes
- `api-docs.json` - Documentation for hover info
- `api-dump.json` - Full API dump from Roblox

## What Gets Detected

### Type Errors
```lua
local x: number = "string"  -- Error: Expected 'number', got 'string'
```

### Deprecated APIs
```lua
wait(1)  -- Warning: Function 'wait' is deprecated, use 'task.wait' instead
spawn(fn)  -- Warning: Function 'spawn' is deprecated, use 'task.spawn' instead
workspace:FindPartOnRay(ray)  -- Warning: Use 'WorldRoot:Raycast' instead
```

### Invalid API Usage
```lua
Instance.new("NotARealClass")  -- Error: Invalid class name
workspace:Raycast("wrong", 123)  -- Error: Expected 'Vector3', got 'string'
```

## Troubleshooting

### "No LSP server available for file type: .luau"

1. Make sure luau-lsp is installed: `luau-lsp --version`
2. Check the path in `.lsp.json` is correct
3. Restart Claude Code after installing the plugin

### Type definitions are outdated

Run `./scripts/update-types.sh` to download the latest definitions.

### LSP not starting

Enable debug logging:
```bash
claude --enable-lsp-logging
```
Check logs in `~/.claude/debug/`

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

MIT License - see [LICENSE](LICENSE) for details.

## Credits

- [luau-lsp](https://github.com/JohnnyMorganz/luau-lsp) by JohnnyMorganz - The language server
- [Roblox](https://www.roblox.com) - Luau language and API definitions
- [Claude Code](https://claude.ai/code) - The AI coding assistant

## Related Projects

- [luau-lsp](https://github.com/JohnnyMorganz/luau-lsp) - The underlying language server
- [Rojo](https://github.com/rojo-rbx/rojo) - Roblox project management
- [Selene](https://github.com/Kampfkarren/selene) - Luau linter
