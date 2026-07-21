class PdfTui < Formula
  desc "Terminal PDF reader built with Ratatui and terminal graphics protocols"
  homepage "https://github.com/WindustH/pdf-tui"
  version "0.1.8"
  license "MIT"

  head do
    url "https://github.com/WindustH/pdf-tui.git", branch: "master"
    depends_on "rust" => :build
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/WindustH/pdf-tui/releases/download/v0.1.8/pdf-tui-0.1.8-aarch64-apple-darwin.tar.gz"
    sha256 "c983f73762b3d6e884e1f0873994447dc19b284a9a6e6a11eb91ffb307a06d59"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/pdf-tui/releases/download/v0.1.8/pdf-tui-0.1.8-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "c01c1e2da09869b38c936e6c7d1aa6cd5bf0a1fd72e4781f358e31576b58af63"
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
