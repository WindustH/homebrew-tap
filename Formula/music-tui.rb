class MusicTui < Formula
  desc "Terminal music player backed by MPD, with covers, synced lyrics and a visualizer"
  homepage "https://github.com/WindustH/music-tui"
  version "0.1.2"
  license "MIT"
  head "https://github.com/WindustH/music-tui.git", branch: "main"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/WindustH/music-tui/releases/download/v0.1.2/music-tui-0.1.2-aarch64-apple-darwin.tar.gz"
    sha256 "0cf8f572c75e9955403bfb1250a1d726d055b1be4794314ef1d5a104a8148f4f"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/music-tui/releases/download/v0.1.2/music-tui-0.1.2-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "a95c039d2607df46c3000d979ad88a1d9c7e02248de45cd4b6781968c5b816cf"
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
