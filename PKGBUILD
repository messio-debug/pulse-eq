pkgname=pulse-eq
pkgver=0.1.0
pkgrel=4
pkgdesc='Lightweight GTK equalizer for PipeWire'
arch=('any')
url='https://github.com/messio-debug/pulse-eq'
license=('MIT')
depends=('python' 'python-gobject' 'python-cairo' 'gtk4' 'libadwaita' 'pipewire' 'wireplumber')
source=('pulse-eq.py' 'pulse-eq.desktop' 'LICENSE' 'uninstall.sh' 'select-output.sh')
sha256sums=('6d4573fca39b6c84d25bf3c55448675403529dee0bfba85e0494c9ad7ea69ed2'
            'e7aa7ed94f470f6a30b7dc9879581d09c5004a911762676507c05fef80f0458e'
            'f2e20c02969e59f9d2f90bb21a3cc527d1c64b2582650ff7f5163d6a46eae580'
            'e3f0d874d9683c408b2cf0472de219fc7077db8352c224031988717ef3cfb2f3'
            '3c0ae77747a8370cb3013809cb38b8ecd614caf4bbba790921b12de2790ab0af')

package() {
  install -Dm755 "$srcdir/pulse-eq.py" "$pkgdir/usr/bin/pulse-eq"
  install -Dm644 "$srcdir/pulse-eq.desktop" "$pkgdir/usr/share/applications/pulse-eq.desktop"
  install -Dm644 "$srcdir/LICENSE" "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
  install -Dm755 "$srcdir/uninstall.sh" "$pkgdir/usr/share/pulse-eq/uninstall.sh"
  install -Dm755 "$srcdir/select-output.sh" "$pkgdir/usr/bin/pulse-eq-output"
}
