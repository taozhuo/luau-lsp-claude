# Contributing to Luau LSP Plugin for Claude Code

Thank you for your interest in contributing! This document provides guidelines for contributing to this project.

## How to Contribute

### Reporting Bugs

1. Check if the issue already exists in [GitHub Issues](https://github.com/taozhuo/luau-lsp-claude/issues)
2. If not, create a new issue with:
   - A clear, descriptive title
   - Steps to reproduce the bug
   - Expected vs actual behavior
   - Your environment (OS, Claude Code version, luau-lsp version)

### Suggesting Features

1. Open an issue with the `enhancement` label
2. Describe the feature and why it would be useful
3. Include examples of how it would work

### Pull Requests

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/my-feature`
3. Make your changes
4. Test your changes thoroughly
5. Commit with clear messages: `git commit -m "Add feature X"`
6. Push to your fork: `git push origin feature/my-feature`
7. Open a Pull Request

## Development Setup

### Prerequisites

- [luau-lsp](https://github.com/JohnnyMorganz/luau-lsp) installed
- [Claude Code](https://claude.ai/code) installed
- Git

### Local Development

```bash
# Clone your fork
git clone https://github.com/YOUR_USERNAME/luau-lsp-claude.git
cd luau-lsp-claude

# Update type definitions
./scripts/update-types.sh

# Test the plugin locally
claude --plugin-dir .
```

### Testing Changes

1. Make your changes to `.lsp.json` or other config files
2. Restart Claude Code with `--plugin-dir .`
3. Test LSP features on `.luau` files
4. Run diagnostics: `luau-lsp analyze --definitions=globalTypes.d.luau src/test.luau`

## Project Structure

```
luau-lsp/
├── .claude-plugin/
│   └── plugin.json          # Plugin manifest (name, version, etc.)
├── .lsp.json                 # LSP server configuration
├── globalTypes.d.luau        # Roblox type definitions (auto-generated)
├── api-docs.json             # API documentation (auto-generated)
├── scripts/
│   ├── update-types.sh       # Updates type definitions from upstream
│   ├── check-version.sh      # Checks for version updates
│   ├── api                   # Quick API lookup script
│   └── lookup-api.py         # Detailed API search
├── src/                      # Test files
├── README.md
├── LICENSE
├── CHANGELOG.md
└── CONTRIBUTING.md
```

## Code Style

- Use clear, descriptive names
- Comment complex logic
- Keep scripts POSIX-compatible where possible
- Test on both macOS and Linux if possible

## Updating Type Definitions

The type definitions (`globalTypes.d.luau`, `api-docs.json`) are fetched from:
- [luau-lsp repository](https://github.com/JohnnyMorganz/luau-lsp)
- [Roblox Client Tracker](https://github.com/MaximumADHD/Roblox-Client-Tracker)

To update:
```bash
./scripts/update-types.sh
```

**Do not manually edit** `globalTypes.d.luau` or `api-docs.json` - they are auto-generated.

## Questions?

Feel free to open an issue for any questions about contributing!
