# Small, reproducible Python image; installs the Rerun CLI via pip
FROM python:3.11-slim

# System basics (optional, but handy)
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates && rm -rf /var/lib/apt/lists/*

# Install rerun (CLI gets installed as `rerun`)
RUN pip install --no-cache-dir rerun-sdk

# Listen on 8080 for the web viewer
EXPOSE 8080

# # Healthcheck: simple GET of the root
# HEALTHCHECK --interval=30s --timeout=3s --retries=3 CMD python - <<'PY'
# import sys, urllib.request
# try:
#     urllib.request.urlopen("http://127.0.0.1:8080/", timeout=2).read()
# except Exception:
#     sys.exit(1)
# PY

# Start the viewer’s built-in web server
CMD ["rerun", "--serve-web", "0.0.0.0:8080"]
