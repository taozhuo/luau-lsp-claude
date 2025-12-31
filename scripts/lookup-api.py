#!/usr/bin/env python3
"""
Lookup Roblox API documentation from luau-lsp docs.

Usage:
    python3 lookup-api.py Raycast
    python3 lookup-api.py TweenService
    python3 lookup-api.py "Vector3.new"
"""
import json
import sys
import os

DOCS_PATH = os.path.join(os.path.dirname(os.path.dirname(__file__)), "api-docs.json")
TYPES_PATH = os.path.join(os.path.dirname(os.path.dirname(__file__)), "globalTypes.d.luau")

def load_docs():
    with open(DOCS_PATH) as f:
        return json.load(f)

def search_docs(query: str):
    docs = load_docs()
    query_lower = query.lower()
    results = []

    for key, value in docs.items():
        if query_lower in key.lower():
            if isinstance(value, dict) and 'documentation' in value:
                results.append((key, value))

    return results

def format_result(key: str, value: dict) -> str:
    output = []
    output.append(f"\n{'='*60}")
    output.append(f"📘 {key}")
    output.append('='*60)

    if 'documentation' in value:
        doc = value['documentation']
        # Clean up HTML tags
        doc = doc.replace('<code>', '`').replace('</code>', '`')
        doc = doc.replace('<br>', '\n')
        doc = doc.replace('<strong>', '**').replace('</strong>', '**')
        output.append(f"\n{doc}")

    if 'params' in value and value['params']:
        output.append("\n📥 Parameters:")
        for p in value['params']:
            name = p.get('name', '?')
            if name != 'self':
                output.append(f"   • {name}")

    if 'returns' in value and value['returns']:
        output.append("\n📤 Returns:")
        for r in value['returns']:
            output.append(f"   • {r}")

    if 'learn_more_link' in value:
        output.append(f"\n🔗 {value['learn_more_link']}")

    return '\n'.join(output)

def get_type_signature(query: str) -> str:
    """Get function signature from type definitions"""
    with open(TYPES_PATH) as f:
        content = f.read()

    lines = content.split('\n')
    results = []
    query_lower = query.lower()

    for i, line in enumerate(lines):
        if query_lower in line.lower() and ('function' in line or 'declare' in line):
            # Get a few lines of context
            start = max(0, i)
            end = min(len(lines), i + 3)
            snippet = '\n'.join(lines[start:end])
            if snippet.strip():
                results.append(snippet)

    return '\n\n'.join(results[:5]) if results else None

def main():
    if len(sys.argv) < 2:
        print("Usage: python3 lookup-api.py <API_NAME>")
        print("\nExamples:")
        print("  python3 lookup-api.py Raycast")
        print("  python3 lookup-api.py TweenService")
        print("  python3 lookup-api.py Vector3.new")
        print("  python3 lookup-api.py Players.PlayerAdded")
        sys.exit(1)

    query = sys.argv[1]
    print(f"\n🔍 Searching for: {query}")

    # Search documentation
    results = search_docs(query)

    if results:
        # Sort by relevance (exact matches first, shorter keys first)
        results.sort(key=lambda x: (query.lower() not in x[0].lower().split('/')[-1], len(x[0])))

        # Show top results
        shown = 0
        for key, value in results[:10]:
            print(format_result(key, value))
            shown += 1

        print(f"\n📊 Found {len(results)} results (showing {shown})")
    else:
        print("❌ No documentation found")

    # Also show type signature
    sig = get_type_signature(query)
    if sig:
        print(f"\n{'='*60}")
        print("📝 Type Signature:")
        print('='*60)
        print(sig)

if __name__ == "__main__":
    main()
