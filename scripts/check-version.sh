#!/bin/bash
# Check if Roblox API types are up to date

echo "=== Luau LSP Version Check ==="
echo ""

# Check luau-lsp binary version
INSTALLED_VERSION=$(~/bin/luau-lsp --version 2>/dev/null || echo "not installed")
LATEST_VERSION=$(curl -s "https://api.github.com/repos/JohnnyMorganz/luau-lsp/releases/latest" | grep '"tag_name"' | cut -d'"' -f4)

echo "luau-lsp binary:"
echo "  Installed: $INSTALLED_VERSION"
echo "  Latest:    $LATEST_VERSION"

if [ "$INSTALLED_VERSION" != "$LATEST_VERSION" ]; then
    echo "  ⚠️  Update available!"
else
    echo "  ✓ Up to date"
fi

echo ""

# Check Roblox version
ROBLOX_VERSION=$(curl -s "https://raw.githubusercontent.com/MaximumADHD/Roblox-Client-Tracker/roblox/version.txt")
echo "Roblox Client version: $ROBLOX_VERSION"

echo ""

# Check type definitions last update
TYPES_LAST_UPDATE=$(curl -s "https://api.github.com/repos/JohnnyMorganz/luau-lsp/commits?path=scripts/globalTypes.d.luau&per_page=1" | grep '"date"' | head -1 | cut -d'"' -f4)
echo "Type definitions last updated: $TYPES_LAST_UPDATE"

echo ""
echo "To update types, run: ./scripts/update-types.sh"
