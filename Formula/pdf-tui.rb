class PdfTui < Formula
  desc "Terminal PDF reader built with Ratatui and terminal graphics protocols"
  homepage "https://github.com/WindustH/pdf-tui"
  version "0.1.7"
  license "MIT"

  head do
    url "https://github.com/WindustH/pdf-tui.git", branch: "master"
    depends_on "rust" => :build
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/WindustH/pdf-tui/releases/download/v0.1.7/pdf-tui-0.1.7-aarch64-apple-darwin.tar.gz"
    sha256 "3d0ec4c6026f433d6c83b14e3ca571c24fe90a14f324e07d7339adac37c56ab8"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/pdf-tui/releases/download/v0.1.7/pdf-tui-0.1.7-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "3cc134392b724fc5da8d8a7ad514fc1f01a557a38e4b0378760cc032f0ece929"
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
