# HuggingFace Upload Configuration

This guide explains how to configure HuggingFace uploads for your GitHub Actions workflows.

## Overview

All build workflows now automatically upload artifacts to HuggingFace datasets when tags are pushed. This supports both the official HuggingFace endpoint and mirror endpoints (like `https://hf-mirror.com` for China mainland).

## Required GitHub Secrets

You need to configure the following secrets in your GitHub repository:

1. **`HF_TOKEN`** (Required)

   - Your HuggingFace authentication token
   - Get it from: https://huggingface.co/settings/tokens
   - Needs `write` permission to upload files

2. **`HF_REPO_ID`** (Optional, defaults to `rwkv-app/ci-demo-releases`)

   - The HuggingFace dataset repository ID
   - Format: `username/dataset-name` or `org/dataset-name`
   - The repository must exist and you must have write access

3. **`HF_ENDPOINT`** (Optional, defaults to `https://huggingface.co`)
   - HuggingFace API endpoint URL
   - Defaults to official HuggingFace endpoint
   - **Note:** Upload to the official endpoint - mirrors (like hf-mirror.com) will automatically sync

## How to Set Up Secrets

1. Go to your GitHub repository
2. Navigate to **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Add each secret:

   - Name: `HF_TOKEN`
   - Value: Your HuggingFace token (starts with `hf_`)

   - Name: `HF_REPO_ID`
   - Value: Your repository ID (e.g., `rwkv-app/ci-demo-releases`)

   - Name: `HF_ENDPOINT`
   - Value: Leave empty (defaults to `https://huggingface.co`) - mirrors will sync automatically

## Repository Structure

Artifacts are uploaded to the following paths in your HF dataset:

- `linux-x64/` - Linux archives (.tar.gz)
- `windows-x64/` - Windows zip files (.zip)
- `windows-x64-installer/` - Windows installers (.exe)
- `macos-universal/` - macOS DMG files (.dmg)
- `android-arm64/` - Android APK files (.apk)

**Note:** iOS App Store, iOS TestFlight, and Android Play Store builds are NOT uploaded to HuggingFace (only to GitHub Releases).

## Manual Upload Script

You can also use the upload script manually:

```bash
python scripts/upload_to_hf.py \
  --repo-id "username/dataset-name" \
  --file "path/to/file.zip" \
  --path-in-repo "category/filename.zip" \
  --hf-token "hf_xxxxxxxxxxxx"
```

## Environment Variables

The script also supports environment variables:

- `HF_TOKEN` - HuggingFace token
- `HF_ENDPOINT` - HuggingFace endpoint URL

Example:

```bash
export HF_TOKEN="hf_xxxxxxxxxxxx"
python scripts/upload_to_hf.py --repo-id "username/dataset" --file "file.zip"
```

## Troubleshooting

### Upload fails with 401/403

- Check that your `HF_TOKEN` is valid and has write permissions
- Verify you have access to the repository specified in `HF_REPO_ID`

### Upload fails with connection errors

- Check network connectivity to HuggingFace
- If needed, you can set `HF_ENDPOINT` to use a mirror, but uploads should go to the official endpoint

### Repository doesn't exist

- Create the dataset repository on HuggingFace first
- Make sure the repository type is "dataset" (not "model")
