# Configure podman

## Configure podman on Windows 11

**Switch to rootful mode**

To switch to root mode:

```
podman machine stop
podman machine set --rootful
podman machine start
```


**Switch WSL2 to Mirrored Networking Mode (Recommended for Win 11)**
If you are on Windows 11 (version 22H2+), switching WSL from default NAT mode to `mirrored` mode shares the host's network stack directly, fixing all loopback and port-forwarding issues.

1. Open Notepad in Windows:
```cmd
notepad %USERPROFILE%\.wslconfig

```


2. Add the following lines and save:
```ini
[wsl2]
networkingMode=mirrored

```


3. Shut down WSL in PowerShell:
```powershell
wsl --shutdown

```


4. Relaunch WSL. Windows and WSL will now share the exact same network interfaces and `localhost` mapping.

## Browsing the setups

**Folder layout**

Each container setup lives in its own folder under `services/`:

```text
services/<service>/<file>        e.g. services/kafka/kafka, services/camunda/operate/application.yaml
services/index.json              the list of setup files the browser page shows
```

**Launch the page**

From the repo root run:

```sh
python3 -m http.server
```

then open http://localhost:8000/.

**Use the page**

The page lists the setups grouped by service, with each file's last-modified date. Pick a file to view its contents as read-only text.

**Add a new setup**

1. Create `services/<service>/<file>`.
2. Add its path, relative to `services/` (for example `"kafka/kafka"`), to the `"files"` array in `services/index.json`, keeping the list sorted.

**Caveats**

- Opening `index.html` directly from disk (`file://`) does not work, because browsers block reading local files that way. Serve the repo over HTTP as shown above.
- The date shown is the file's modification time on disk (usually when it was checked out or last edited locally), not its git commit date.
