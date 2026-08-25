# scoop-be

Personal Scoop bucket.

## Add bucket

```powershell
scoop bucket add scoop-be https://github.com/buzlet/scoop-be
```

## ffmpeg-nvenc-legacy

Current FFmpeg rebuilt with `nv-codec-headers n13.0.19.1` / NVENC API 13.0 for NVIDIA systems that must remain on legacy driver branches.

```powershell
scoop update
scoop install scoop-be/ffmpeg-nvenc-legacy
```

The manifest tracks the highest semantic `ffmpeg-nvenc-legacy` release and verifies the immutable release asset with SHA-256.

The package exposes `ffmpeg`, `ffprobe` and `ffplay` shims, so avoid keeping another FFmpeg package active with the same shim names.

Manifests are stored in `bucket/`.
