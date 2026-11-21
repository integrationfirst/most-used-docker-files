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

## Brand

`index.html` follows the Simpson Strong-Tie brand. Keep to these rules when changing the page.

**Colours**

Only these seven colours are used (plus `transparent`, `currentColor` and `inherit`). No other hex, `rgb()`, `hsl()` or named colours, and no blue, red, green or cyan.

| Colour | Hex | Use on the page |
| --- | --- | --- |
| White | `#FFFFFF` | Page background, the selected list entry and the code block |
| Orange | `#FF5308` | The only accent: the 4px bar on the selected list entry. Never used for text |
| Ink | `#1D1D1D` | Body and heading text, the selected entry's border and the keyboard focus outline |
| Black | `#000000` | The logo wordmark. Declared as `--black` in the page palette but not used by the page CSS yet; allowed for focus outlines (the page uses ink) |
| Light grey | `#F4F4F4` | Secondary surfaces: list entries and the viewer panel |
| Burnt orange | `#9A3205` | Error text and border (the HTTP banner and file load errors), in place of red |
| Slate | `#343A40` | Quiet text (subtitle, dates, hints), group dividers, the hover border and the code block border |

**Typography**

- Headings (`h1`, service group headings): `"Helvetica Neue Condensed", Inter, sans-serif`, weight 700.
- Body text: `"Helvetica Neue", Inter, sans-serif`, weight 400.
- The Helvetica Neue fonts are licensed, so they are referenced by name only and used when installed. They are never bundled, downloaded or loaded from a URL.
- Inter is the fallback. Its Regular and Bold `.woff2` files (v4.1, from the rsms/inter release) are self-hosted in `assets/fonts/` with their SIL Open Font License (`assets/fonts/LICENSE-Inter.txt`), so the page works offline and makes no requests to other hosts.
- Monospace exception: file paths, dates, file contents and error messages keep the `--mono` stack, because the brand names no monospace font and commands and YAML need fixed width.

**Layout**

- Cards and panels (list entries, the viewer, the code block, the banner) have 4px corners.
- Page content is at most 1472px wide and centred on wider screens.

**Logo**

- The official logo is `assets/brand/simpson-strong-tie-logo.svg`. It is shown in the header with `<img>` and `alt="Simpson Strong-Tie"`, 110px wide, or 61px wide on screens 760px or narrower, sized by width only with `height: auto`.
- Use the file as-is: do not redraw, retype, recolour, crop, optimise, stretch it or add effects (filters, shadows, opacity, transforms, borders or backgrounds).

**Buttons**

The page currently has no buttons of this kind. Any future brand button uses an orange (`#FF5308`) fill, 5px corners, 42px height and 16px padding on either side.

**Assumptions**

- Orange only marks the selected list entry, as the list is the page's navigation and there are no links or calls to action. Orange text fails 4.5:1 contrast on white and grey, so orange is never used for text. The orange bar sits against white (3.2:1), and the selected entry also has a thicker border and a bold name, so it does not rely on colour alone.
- Burnt orange replaces red for errors: red is not a brand colour, and burnt orange is about 7.4:1 on white. Error messages keep their wording so they read as errors without colour.
- The keyboard focus outline is ink (black is also allowed), at least 2px, because orange fails 3:1 against light grey.
- Font stacks end with the generic `sans-serif` after Inter, since CSS needs a terminal family. Self-hosted Inter is always available in practice.
- Static Inter Regular and Bold files are used rather than the variable font, as only weights 400 and 700 are needed.
- The logo is a separate SVG file shown with `<img>` rather than inlined, to keep the official file intact and give it simple alt text.
