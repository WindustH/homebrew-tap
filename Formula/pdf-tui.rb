class PdfTui < Formula
  desc "Terminal PDF reader built with Ratatui and terminal graphics protocols"
  homepage "https://github.com/WindustH/pdf-tui"
  version "0.1.2"
  license "MIT"

  head do
    url "https://github.com/WindustH/pdf-tui.git", branch: "master"
    depends_on "rust" => :build
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/WindustH/pdf-tui/releases/download/v0.1.2/pdf-tui-0.1.2-aarch64-apple-darwin.tar.gz"
    sha256 "b1a304e8e1f6aba8b45097583bc7709c1ef5ab1d4cc18d0470a734c1ec8d1d7b"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/pdf-tui/releases/download/v0.1.2/pdf-tui-0.1.2-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "959775cbf2ff0cb7fb4205420b7c1f893840d77725c61c244474f116181a25c1"
  end

  depends_on "rust" => :build if build.head?
  depends_on "chafa"
  depends_on "exiftool"
  depends_on "pdftk-java"
  depends_on "poppler"

  def install
    if build.head?
      system Formula["rust"].opt_bin/"cargo", "install", *std_cargo_args
    else
      bin.install "pdf-tui"
      doc.install "README.md"
      doc.install "doc"
    end
  end

  test do
    assert_match "pdf-tui", shell_output("#{bin}/pdf-tui --help")
  end
end
