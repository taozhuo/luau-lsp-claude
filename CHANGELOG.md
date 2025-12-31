# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-12-30

### Added
- Initial release of Luau LSP plugin for Claude Code
- Full Roblox API type definitions (`globalTypes.d.luau`)
- API documentation for hover info (`api-docs.json`)
- Support for all Claude Code LSP operations:
  - `hover` - Documentation and type info
  - `goToDefinition` - Jump to definitions
  - `findReferences` - Find all usages
  - `documentSymbol` - List file symbols
  - `workspaceSymbol` - Search project symbols
  - `prepareCallHierarchy` - Call hierarchy support
  - `incomingCalls` - Find callers
  - `outgoingCalls` - Find callees
- Diagnostic support for:
  - Type errors
  - Deprecated API warnings with replacement suggestions
  - Unused variable warnings
  - Invalid class name detection
- Utility scripts:
  - `scripts/update-types.sh` - Update Roblox API definitions
  - `scripts/check-version.sh` - Check for updates
  - `scripts/api` - Quick API lookup tool
  - `scripts/lookup-api.py` - Detailed API search

### Dependencies
- Requires [luau-lsp](https://github.com/JohnnyMorganz/luau-lsp) v1.59.0 or later
