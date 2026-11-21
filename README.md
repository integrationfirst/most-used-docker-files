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

The page lists the setups grouped by service, with each file's last-modified date. Pick a file to view its contents as read-only text. The `Theme` button in the header switches between light and dark; the default follows your OS setting, and your choice is remembered in the browser.

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
| White | `#FFFFFF` | Light: page background, the selected list entry and the code block. Dark: body, heading, file-content and error text, the selected entry's border and the keyboard focus outline |
| Orange | `#FF5308` | The only accent: the 4px bar on the selected list entry and the theme button fill. Dark: also the error banner border. Never used for text |
| Ink | `#1D1D1D` | Light: body and heading text, the selected entry's border and the keyboard focus outline. Dark: secondary surfaces (list entries and the viewer panel) |
| Black | `#000000` | The logo wordmark and the theme button text. Dark: page background, the selected list entry and the code block. Also allowed for focus outlines (the light theme uses ink) |
| Light grey | `#F4F4F4` | Light: secondary surfaces (list entries and the viewer panel). Dark: quiet text (subtitle, dates, meta, hints) and the hover border |
| Burnt orange | `#9A3205` | Light: error text and border (the HTTP banner and file load errors), in place of red. Not used in dark |
| Slate | `#343A40` | Group dividers and the code block border in both themes. Light: also quiet text (subtitle, dates, hints) and the hover border |

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

The theme button in the header is the page's one brand button, with black text. Any brand button uses an orange (`#FF5308`) fill, 5px corners, 42px height and 16px padding on either side.

**Assumptions**

- Orange marks the selected list entry and fills the theme button (and, in dark, the error banner border), as the list is the page's navigation and there are no links or calls to action. Orange text fails 4.5:1 contrast on white and grey, so orange is never used for text. The orange bar sits against white (3.2:1) or, in dark, black (6.5:1), and the selected entry also has a thicker border and a bold name, so it does not rely on colour alone.
- Burnt orange replaces red for errors: red is not a brand colour, and burnt orange is about 7.4:1 on white. Error messages keep their wording so they read as errors without colour.
- In the dark theme, error text is white instead of burnt orange, because burnt orange fails contrast on ink (about 2.3:1). The error banner keeps an orange border, and the messages' wording marks them as errors.
- The keyboard focus outline is ink (black is also allowed), or white in dark, at least 2px, because orange fails 3:1 against light grey.
- Font stacks end with the generic `sans-serif` after Inter, since CSS needs a terminal family. Self-hosted Inter is always available in practice.
- Static Inter Regular and Bold files are used rather than the variable font, as only weights 400 and 700 are needed.
- The logo is a separate SVG file shown with `<img>` rather than inlined, to keep the official file intact and give it simple alt text.
