# Homebrew formula TEMPLATE for the `bs` CLI (Phase 11, D-03).
#
# This is a TEMPLATE, not a working formula. The `cli` Codemagic release job
# fills the {{PLACEHOLDERS}} from the just-built GitHub release assets and
# pushes the rendered formula to the tap repo:
#
#     JensrudJ/homebrew-burnedsecret   (Formula/bs.rb)
#
# After the tap repo exists (user_setup item), users install with:
#
#     brew install JensrudJ/burnedsecret/bs
#
# This is a BINARY formula: it downloads the per-arch PyInstaller `bs` binary
# attached to the GitHub release rather than building from source, so no Python
# toolchain is required on the user's machine (D-05).
#
# Placeholders filled by CI:
#   1.0.2        -> release version without the cli-v prefix, e.g. 1.0.0
#   https://github.com/JensrudJ/burnedsecret-releases/releases/download/cli-v1.0.2/bs-macos-arm64.tar.gz      -> https://github.com/JensrudJ/burnedsecret-releases/releases/download/cli-vX/bs-macos-arm64.tar.gz
#   59f73bd1f41eb9a36aa1c703daba8626f4cf3fd6f9416507516b5d6aef50a55c   -> sha256 of the arm64 tarball
#
# Apple Silicon only for now: there is no x86_64 build (see codemagic.yaml,
# cli-binary-macos). Intel Macs get a clear message pointing at pip.

class Bs < Formula
  desc "Command-line interface for the burnedsecret.com zero-knowledge secrets API"
  homepage "https://burnedsecret.com"
  version "1.0.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/JensrudJ/burnedsecret-releases/releases/download/cli-v1.0.2/bs-macos-arm64.tar.gz"
      sha256 "59f73bd1f41eb9a36aa1c703daba8626f4cf3fd6f9416507516b5d6aef50a55c"
    end
    on_intel do
      odie "bs: no Intel (x86_64) macOS binary is published yet. " \
           "Install with pip instead: pip install burnedsecret-cli"
    end
  end

  def install
    bin.install "bs"
  end

  test do
    assert_match "burnedsecret", shell_output("#{bin}/bs --version")
  end
end
