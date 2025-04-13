#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.13"
# dependencies = [
#     "rich",
# ]
# ///

import argparse
import json
import struct

from rich.console import Console
from rich.table import Table


def read_safetensors_metadata(filepath):
    with open(filepath, "rb") as f:
        # Read first 8 bytes for metadata length (u64, little endian)
        header_len_bytes = f.read(8)
        if len(header_len_bytes) != 8:
            raise ValueError("File too short to contain header length.")

        metadata_len = struct.unpack("<Q", header_len_bytes)[
            0
        ]  # '<Q' = little-endian unsigned long long (u64)

        # Read the next `metadata_len` bytes
        metadata_bytes = f.read(metadata_len)
        if len(metadata_bytes) != metadata_len:
            raise ValueError("File too short to contain full metadata.")

        # Decode and parse JSON
        metadata_json = metadata_bytes.decode("utf-8")
        metadata = json.loads(metadata_json)

        return metadata


def display_safetensors_metadata(metadata):
    metadata_info = metadata.get("__metadata__", {})
    for key, value in metadata_info.items():
        print(f"{key}: {value}")

    for name, info in metadata.items():
        if name == "__metadata__":
            continue
        dtype = info.get("dtype", "unknown")
        shape = info.get("shape", [])
        shape_str = "[" + ", ".join(map(str, shape)) + "]"
        print(f"{name} {dtype} {shape_str}")


def display_safetensors_metadata_pretty(metadata, force_terminal):
    console = Console(force_terminal=force_terminal)

    format_type = metadata.get("__metadata__", {}).get("format", "unknown")
    console.print(f"[bold green]format:[/] {format_type}")

    table = Table(show_lines=False)

    table.add_column("Tensor Name", style="cyan", no_wrap=True)
    table.add_column("DType", style="magenta")
    table.add_column("Shape", style="yellow")

    for name, info in metadata.items():
        if name == "__metadata__":
            continue
        dtype = info.get("dtype", "unknown")
        shape = "[" + ", ".join(map(str, info.get("shape", []))) + "]"
        table.add_row(name, dtype, shape)

    console.print(table)


def main():
    parser = argparse.ArgumentParser(
        description="Read metadata from a .safetensors file."
    )
    parser.add_argument("filepath", type=str, help="Path to the .safetensors file")
    parser.add_argument(
        "--format",
        type=str,
        choices=["pretty", "simple", "json"],
        default="pretty",
    )
    parser.add_argument(
        "--color",
        action="store_true",
        help="Force color output even if not in a terminal",
    )
    args = parser.parse_args()

    metadata = read_safetensors_metadata(args.filepath)
    match args.format:
        case "pretty":
            display_safetensors_metadata_pretty(metadata, force_terminal=args.color)
        case "simple":
            display_safetensors_metadata(metadata)
        case "json":
            print(json.dumps(metadata, indent=2))


if __name__ == "__main__":
    main()
