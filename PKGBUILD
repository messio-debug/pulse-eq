pkgname=pulse-eq
pkgver=0.1.0
pkgrel=7
pkgdesc='Lightweight GTK equalizer for PipeWire'
arch=('any')
url='https://github.com/messio-debug/pulse-eq'
license=('MIT')
depends=('python' 'python-gobject' 'python-cairo' 'gtk4' 'libadwaita' 'pipewire' 'wireplumber')
source=('pulse-eq.py' 'pulse-eq.desktop' 'LICENSE' 'uninstall.sh' 'select-output.sh')
sha256sums=('87a0116e1b51b9309a9b209c75232848eae328a85d359118c7911b96c723aed2'
            'e7aa7ed94f470f6a30b7dc9879581d09c5004a911762676507c05fef80f0458e'
            'f2e20c02969e59f9d2f90bb21a3cc527d1c64b2582650ff7f5163d6a46eae580'
            '9a778be29924cd5fffc883986255d5c08c102e03c243719415a8fe44c9b0de60'
            '58df639b449ecbb3ac7fd8e0f064d5aecef5a4c4d2720f6befef1be2207069fb')

package() {
  install -Dm755 "$srcdir/pulse-eq.py" "$pkgdir/usr/bin/pulse-eq"
  install -Dm644 "$srcdir/pulse-eq.desktop" "$pkgdir/usr/share/applications/pulse-eq.desktop"
  install -Dm644 "$srcdir/LICENSE" "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
  install -Dm755 "$srcdir/uninstall.sh" "$pkgdir/usr/share/pulse-eq/uninstall.sh"
  install -Dm755 "$srcdir/select-output.sh" "$pkgdir/usr/bin/pulse-eq-output"
}
