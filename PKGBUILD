pkgname=pulse-eq
pkgver=0.1.0
pkgrel=1
pkgdesc='Lightweight GTK equalizer for PipeWire'
arch=('any')
license=('MIT')
depends=('python' 'python-gobject' 'python-cairo' 'gtk4' 'libadwaita' 'pipewire' 'wireplumber')
source=('pulse-eq.py' 'pulse-eq.desktop' 'LICENSE')
sha256sums=('6af6cb403990b4b29a2ca8ea1bc1976d9485cb9cf919bf496c252ce96582137c'
            'e7aa7ed94f470f6a30b7dc9879581d09c5004a911762676507c05fef80f0458e'
            'f2e20c02969e59f9d2f90bb21a3cc527d1c64b2582650ff7f5163d6a46eae580')

package() {
  install -Dm755 "$srcdir/pulse-eq.py" "$pkgdir/usr/bin/pulse-eq"
  install -Dm644 "$srcdir/pulse-eq.desktop" "$pkgdir/usr/share/applications/pulse-eq.desktop"
  install -Dm644 "$srcdir/LICENSE" "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
}
