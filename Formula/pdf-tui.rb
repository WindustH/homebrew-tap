class PdfTui < Formula
  desc "Terminal PDF reader built with Ratatui and terminal graphics protocols"
  homepage "https://github.com/WindustH/pdf-tui"
  version "0.2.2"
  license "MIT"
  PDFIUM_RELEASE = "7961"

  head do
    url "https://github.com/WindustH/pdf-tui.git", branch: "master"
    depends_on "rust" => :build
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/WindustH/pdf-tui/releases/download/v0.2.2/pdf-tui-0.2.2-aarch64-apple-darwin.tar.gz"
    sha256 "4d191b86a47aa3b3dc13ffad858cfd38d962784ec6a2d308a6cf7ad9f7d00510"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/pdf-tui/releases/download/v0.2.2/pdf-tui-0.2.2-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "032c3eec9ab30d88c7c051e0d2a14724edab63055c50f47cc313e3ead8125b8a"
  end

  depends_on "rust" => :build if build.head?
  depends_on "chafa"
  depends_on "exiftool"
  depends_on "mupdf"
  depends_on "pdftk-java"
  depends_on "poppler"

  if OS.linux?
    depends_on "wl-clipboard"
    depends_on "xclip"
  end

  if OS.mac?
    resource "pdfium" do
      url "https://github.com/bblanchon/pdfium-binaries/releases/download/chromium%2F#{PDFIUM_RELEASE}/pdfium-mac-univ.tgz"
      sha256 "432ba1831a4581cb0d52550fdad977d0ebf4f31188223b5ddd99b9b89d7124fe"
    end
  elsif OS.linux? && Hardware::CPU.intel?
    resource "pdfium" do
      url "https://github.com/bblanchon/pdfium-binaries/releases/download/chromium%2F#{PDFIUM_RELEASE}/pdfium-linux-x64.tgz"
      sha256 "019665c8877d46fe65f625f80fd714ab07aac68554b0636acf2a2adf9288adb2"
    end
  end

  def install
    if build.head?
      system "git", "submodule", "update", "--init", "--recursive"
      system Formula["rust"].opt_bin/"cargo", "install", *std_cargo_args
      libexec.install bin/"pdf-tui" => "pdf-tui.real"
      rm bin/"pdf-tui"
    else
      libexec.install "pdf-tui" => "pdf-tui.real"
      doc.install "README.md"
      doc.install "doc"
    end
    install_pdfium_resource
    write_pdf_tui_wrapper
  end

  def install_pdfium_resource
    resource("pdfium").stage do
      (libexec/"pdfium").install "lib", "LICENSE", "VERSION", "licenses"
    end
  end

  def pdfium_library_path
    library = OS.mac? ? "libpdfium.dylib" : "libpdfium.so"
    libexec/"pdfium/lib/#{library}"
  end

  def write_pdf_tui_wrapper
    (bin/"pdf-tui").write <<~EOS
      #!/bin/bash
      export PDF_TUI_PDFIUM_LIBRARY_PATH="${PDF_TUI_PDFIUM_LIBRARY_PATH:-#{pdfium_library_path}}"
      exec "#{libexec}/pdf-tui.real" "$@"
    EOS
    chmod 0755, bin/"pdf-tui"
  end

  test do
    assert_match "pdf-tui", shell_output("#{bin}/pdf-tui --help")
  end
end
