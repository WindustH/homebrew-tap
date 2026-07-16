class PdfTui < Formula
  desc "Terminal PDF reader built with Ratatui and terminal graphics protocols"
  homepage "https://github.com/WindustH/pdf-tui"
  version "0.1.4"
  license "MIT"

  head do
    url "https://github.com/WindustH/pdf-tui.git", branch: "master"
    depends_on "rust" => :build
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/WindustH/pdf-tui/releases/download/v0.1.4/pdf-tui-0.1.4-aarch64-apple-darwin.tar.gz"
    sha256 "07d3acc4b10f8677bed5fb0716e0365236ebbce14ab2f44053fef8a46dbfbe09"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/pdf-tui/releases/download/v0.1.4/pdf-tui-0.1.4-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "68ca3fc710f05eb7a993d784c93821e3231726fd112cc809fe42b0ab12551d54"
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
