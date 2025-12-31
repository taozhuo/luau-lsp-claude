#!/bin/bash
# Update all Roblox type definitions and documentation for luau-lsp
# Run this periodically to get the latest Roblox API

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "=== Updating Luau LSP Roblox API Files ==="
echo ""

echo "Fetching latest Roblox version..."
ROBLOX_VERSION=$(curl -s "https://raw.githubusercontent.com/MaximumADHD/Roblox-Client-Tracker/roblox/version.txt")
echo "Current Roblox version: $ROBLOX_VERSION"
echo ""

echo "Downloading type definitions..."
curl -sL "https://raw.githubusercontent.com/JohnnyMorganz/luau-lsp/main/scripts/globalTypes.d.luau" \
    -o "$PROJECT_DIR/globalTypes.d.luau"
echo "  ✓ globalTypes.d.luau"

echo "Downloading API documentation..."
curl -sL "https://raw.githubusercontent.com/JohnnyMorganz/luau-lsp/main/scripts/api-docs/en-us.json" \
    -o "$PROJECT_DIR/api-docs.json"
echo "  ✓ api-docs.json"

echo "Downloading DataTypes..."
curl -sL "https://raw.githubusercontent.com/JohnnyMorganz/luau-lsp/main/scripts/DataTypes.json" \
    -o "$PROJECT_DIR/DataTypes.json"
echo "  ✓ DataTypes.json"

echo "Downloading Corrections..."
curl -sL "https://raw.githubusercontent.com/JohnnyMorganz/luau-lsp/main/scripts/Corrections.json" \
    -o "$PROJECT_DIR/Corrections.json"
echo "  ✓ Corrections.json"

echo "Downloading API dump from Roblox Client Tracker..."
curl -sL "https://raw.githubusercontent.com/MaximumADHD/Roblox-Client-Tracker/roblox/Mini-API-Dump.json" \
    -o "$PROJECT_DIR/api-dump.json"
echo "  ✓ api-dump.json"

echo ""
echo "=== Update Complete ==="
echo ""
ls -lh "$PROJECT_DIR"/*.json "$PROJECT_DIR"/*.d.luau 2>/dev/null
