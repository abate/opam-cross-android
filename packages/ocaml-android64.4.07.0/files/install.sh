#!/bin/bash -e

set -x

PREFIX="$1"

for pkg in bigarray bytes compiler-libs dynlink findlib stdlib str threads unix; do
  cp -r "${PREFIX}/lib/${pkg}" "${PREFIX}/android-sysroot/lib/"
done

for bin in ocamlc ocamlopt ocamlcp ocamlmklib ocamlmktop ocamldoc ocamldep; do
  rm -rf ${PREFIX}/android-sysroot/bin/${bin}

cat << EOF > "${PREFIX}/android-sysroot/bin/${bin}"
#!/bin/sh
${PREFIX}/bin/ocamlrun "${PREFIX}/android-sysroot/bin/${bin}.byte" "\$@"
EOF

  chmod +x "${PREFIX}/android-sysroot/bin/${bin}"
done

mkdir -p "${PREFIX}/lib/findlib.conf.d"
cp android.conf "${PREFIX}/lib/findlib.conf.d"

#(cd "${PREFIX}/android-sysroot/bin/" && ln -sf ocamlc.byte ocamlc)
