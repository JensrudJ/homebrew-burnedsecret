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
#   1.0.0        -> release version without the cli-v prefix, e.g. 1.0.0
#   https://github.com/JensrudJ/burnedsecret-releases/releases/download/cli-v1.0.0/bs-macos-arm64.tar.gz      -> https://github.com/JensrudJ/burnedsecret-releases/releases/download/cli-vX/bs-macos-arm64.tar.gz
#   121b9a75334cea06e70339d2a9bb22f3cf9b3d6f69dd37e4130d37d50408f15c   -> sha256 of the arm64 tarball
#   https://github.com/JensrudJ/burnedsecret-releases/releases/download/cli-v1.0.0/bs-macos-x86_64.tar.gz     -> https://github.com/JensrudJ/burnedsecret-releases/releases/download/cli-vX/bs-macos-x86_64.tar.gz
#   3b4d91b0bd6ebd8a6dba6f2a8e82e6b455b9e87a9cd11ed8582e046dd57a7d98  -> sha256 of the x86_64 tarball

class Bs < Formula
  desc "Command-line interface for the burnedsecret.com zero-knowledge secrets API"
  homepage "https://burnedsecret.com"
  version "1.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/JensrudJ/burnedsecret-releases/releases/download/cli-v1.0.0/bs-macos-arm64.tar.gz"
      sha256 "121b9a75334cea06e70339d2a9bb22f3cf9b3d6f69dd37e4130d37d50408f15c"
    end
    on_intel do
      url "https://github.com/JensrudJ/burnedsecret-releases/releases/download/cli-v1.0.0/bs-macos-x86_64.tar.gz"
      sha256 "3b4d91b0bd6ebd8a6dba6f2a8e82e6b455b9e87a9cd11ed8582e046dd57a7d98"
    end
  end

  def install
    bin.install "bs"
  end

  test do
    assert_match "burnedsecret", shell_output("#{bin}/bs --version")
  end
end
