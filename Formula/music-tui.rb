class MusicTui < Formula
  desc "Terminal music player backed by MPD, with covers, synced lyrics and a visualizer"
  homepage "https://github.com/WindustH/music-tui"
  version "0.1.4"
  license "MIT"
  head "https://github.com/WindustH/music-tui.git", branch: "main"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/WindustH/music-tui/releases/download/v0.1.4/music-tui-0.1.4-aarch64-apple-darwin.tar.gz"
    sha256 "34f193b149c199ca7c1f2bd37ade71d337bc5e78fb02ef836f41b40494417dde"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/music-tui/releases/download/v0.1.4/music-tui-0.1.4-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "2a13e2e97448609925cccab315ed10121c4a4d8d4f799c4a44c26e8f97591372"
  end

  depends_on "rust" => :build if build.head?
  depends_on "mpd"
  depends_on "chafa"
  depends_on "sqlite"

  def install
    if build.head?
      system "git", "submodule", "update", "--init", "--recursive"
      system "cargo", "install", *std_cargo_args
    else
      bin.install "music-tui"
      doc.install "README.md"
      doc.install "doc" if File.directory?("doc")
    end
  end

  test do
    assert_match "music-tui", shell_output("#{bin}/music-tui --help")
  end
end
