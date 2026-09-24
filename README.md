# Pulse EQ

A small, native GTK4 equalizer for PipeWire on Arch Linux. It uses PipeWire's
built-in parametric EQ, has no audio plugin dependency, and saves its state in
`~/.config/pulse-eq/`.

## Install on Arch

Clone the repository, install the runtime dependencies, and build the package:

```sh
git clone https://github.com/messio-debug/pulse-eq.git
cd pulse-eq
sudo pacman -S python-gobject python-cairo gtk4 libadwaita pipewire wireplumber
makepkg -si
```

Launch **Pulse EQ** from your app menu, choose a preset or move the ten bands,
then click **Apply to PipeWire**. PipeWire restarts briefly to load the filter.
After that, the app selects **Pulse EQ** as the default output and routes the
processed audio to the hardware output that was active before the restart.
The equalizer also adds automatic preamp headroom to prevent boosted bands
from clipping. Choose your normal output in sound settings to bypass the EQ.

You can also make it the default output from a terminal. First click **Apply
to PipeWire** in the app, then run:

```sh
pulse-eq-output
```

This finds the current PipeWire node ID automatically and selects Pulse EQ.
If you are running from a source checkout instead of the package, run
`bash select-output.sh`. To switch back, choose your normal speakers or
headphones in sound settings.

The generated PipeWire fragment lives at
`~/.config/pipewire/pipewire.conf.d/90-pulse-eq.conf`. Remove that file and
restart PipeWire to uninstall the filter. Presets and band values are stored
in `~/.config/pulse-eq/state.json`.

To remove Pulse EQ and disable its PipeWire filter, run:

```sh
bash /usr/share/pulse-eq/uninstall.sh
```

The uninstaller keeps your saved presets. To remove those too, delete
`~/.config/pulse-eq/` after uninstalling.

## Run from source

```sh
python3 pulse-eq.py
```

Requires GTK 4, libadwaita, PyGObject, PipeWire, WirePlumber, and a systemd user
session. PipeWire changes are only written when **Apply** is clicked.

## Planned features

More equalizer profiles, customization options, and additional AutoEQ choices
are planned.
