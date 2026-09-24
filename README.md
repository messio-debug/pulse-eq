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
After that, select **Pulse EQ** as your audio output in your desktop's sound
settings. Applications can then use the equalized virtual output. Select your
normal output again to bypass the equalizer.

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
