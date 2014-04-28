{ cabal, shakespeare }:

cabal.mkDerivation (self: {
  pname = "shakespeare-js";
  version = "1.3.0";
  sha256 = "0hihcrgvzf4nsrgw6vqpkzbgskq01yc1mnvp7g2wy7vq0dv4pjp4";
  buildDepends = [ shakespeare ];
  meta = {
    homepage = "http://www.yesodweb.com/book/shakespearean-templates";
    description = "Stick your haskell variables into javascript/coffeescript at compile time. (deprecated)";
    license = self.stdenv.lib.licenses.mit;
    platforms = self.ghc.meta.platforms;
    maintainers = [ self.stdenv.lib.maintainers.andres ];
  };
})
