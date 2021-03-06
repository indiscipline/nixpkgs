{ stdenv, fetchpatch, python, cmake, llvm, ocaml, findlib, ctypes }:

let version = stdenv.lib.getVersion llvm; in

stdenv.mkDerivation {
  name = "ocaml-llvm-${version}";

  inherit (llvm) src;

  buildInputs = [ python cmake llvm ocaml findlib ctypes ];

  patches = [ (fetchpatch {
    url = https://raw.githubusercontent.com/ocaml/opam-repository/master/packages/llvm/llvm.3.9/files/cmake.patch;
    sha256 = "0vjap0xifgm59rwhjc48wi7jpbbif4dllsy4xs45sg95qq5qanp6";
  })];

  cmakeFlags = [ "-DLLVM_OCAML_OUT_OF_TREE=TRUE" ];

  buildFlags = "ocaml_all";

  installFlags = "-C bindings/ocaml";

  postInstall = ''
    mv $out/lib/ocaml $out/ocaml
    mkdir -p $OCAMLFIND_DESTDIR/
    mv $out/ocaml $OCAMLFIND_DESTDIR/llvm
    mv $OCAMLFIND_DESTDIR/llvm/META{.llvm,}
  '';

  meta = {
    inherit (llvm.meta) license homepage;
    platforms = ocaml.meta.platforms or [];
    description = "OCaml bindings distributed with LLVM";
    maintainers = with stdenv.lib.maintainers; [ vbgl ];
  };

}
