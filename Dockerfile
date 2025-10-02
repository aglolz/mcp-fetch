# Use a Python image with uv pre-installed
FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim AS uv

# Install the project into `/app`
WORKDIR /app

# Enable bytecode compilation
ENV UV_COMPILE_BYTECODE=1

# Copy lockfile and project settings
COPY uv.lock pyproject.toml /app/

# Install dependencies (no cache mounts)
RUN uv sync --frozen --no-install-project --no-dev --no-editable

# Add the rest of the source code and install
COPY . /app
RUN uv sync --frozen --no-dev --no-editable

# Start the MCP Fetch server when container runs
CMD ["mcp-server-fetch"]

