#!/usr/bin/env python3

import csv
import os
import requests
from urllib.parse import urlparse, unquote

# === Configuration ===
CSV_FILE = 'dc_db_07_abril_2025.csv'           # Name of the input CSV
OUTPUT_DIR = 'files'                 # Where files will be saved
ID_FIELD = 'ID'                      # Name of the column for unique ID
URL_FIELD = 'identifier'            # Name of the column with the URL to download
ALLOWED_DOMAIN = 'https://siucam.com'

# Create output directory if it doesn't exist
os.makedirs(OUTPUT_DIR, exist_ok=True)

def clean_extension(url):
    """Extract and sanitize the file extension from a URL."""
    parsed = urlparse(url)
    path = unquote(parsed.path)
    extension = os.path.splitext(path)[-1]
    return extension

with open(CSV_FILE, newline='', encoding='utf-8') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        # Normalize keys to avoid issues with spaces/casing
        row = {k.strip().lower(): v for k, v in row.items()}

        file_id = row.get(ID_FIELD.lower())
        url = row.get(URL_FIELD.lower())

        if not file_id or not url:
            print("⏭️ Skipping row with missing ID or URL")
            continue

        if not url.startswith(ALLOWED_DOMAIN):
            print(f"⏭️ Skipping URL not from allowed domain: {url}")
            continue

        extension = clean_extension(url)
        filename = f"{file_id}{extension}"
        output_path = os.path.join(OUTPUT_DIR, filename)

        try:
            print(f"⬇️ Downloading {url}...")
            response = requests.get(url, stream=True, timeout=30)
            response.raise_for_status()
            with open(output_path, 'wb') as f:
                for chunk in response.iter_content(chunk_size=8192):
                    f.write(chunk)
            print(f"✅ Saved as {output_path}")
        except Exception as e:
            print(f"❌ Failed to download {url}: {e}")

