final: prev: {
  bun = prev.bun.overrideAttrs (finalAttrs: oldAttrs:
    # let bunVersion = "1.2.23";
    let
      bunVersion = "1.3.2";
    in {
      src =
        finalAttrs.passthru.sources.${
          prev.stdenvNoCC.hostPlatform.system
        } or (throw
          "Unsupported system: ${prev.stdenvNoCC.hostPlatform.system}");

      passthru.sources =
        oldAttrs.passthru.sources
        // {
          "x86_64-linux" = prev.fetchurl {
            url = "https://github.com/oven-sh/bun/releases/download/bun-v${bunVersion}/bun-linux-x64-baseline.zip";
            sha256 = "sha256-f/CaSlGeggbWDXt2MHLL82Qvg3BpAWVYbTA/ryFpIXI=";
          };
        };
    });
}
