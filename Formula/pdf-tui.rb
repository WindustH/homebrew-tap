class PdfTui < Formula
  desc "Terminal PDF reader built with Ratatui and terminal graphics protocols"
  homepage "https://github.com/WindustH/pdf-tui"
  version "0.1.5"
  license "MIT"

  head do
    url "https://github.com/WindustH/pdf-tui.git", branch: "master"
    depends_on "rust" => :build
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/WindustH/pdf-tui/releases/download/v0.1.5/pdf-tui-0.1.5-aarch64-apple-darwin.tar.gz"
    sha256 "823fde63fa18b35d8336722da405c1705cb727bb30c5df8d07657fec8821d685"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/pdf-tui/releases/download/v0.1.5/pdf-tui-0.1.5-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "3b596b3c66060297666e286bcd1cfee9786a88cf23e42218afc0700e9813ba0e"
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
