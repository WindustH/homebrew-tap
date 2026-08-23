class MusicTui < Formula
  desc "Terminal music player backed by MPD, with covers, synced lyrics and a visualizer"
  homepage "https://github.com/WindustH/music-tui"
  version "0.1.3"
  license "MIT"
  head "https://github.com/WindustH/music-tui.git", branch: "main"

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/WindustH/music-tui/releases/download/v0.1.3/music-tui-0.1.3-aarch64-apple-darwin.tar.gz"
    sha256 "c2e5eec52b489dae49d5e6a10b9c69802c609e9a945758a5e21ca347fc520256"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/music-tui/releases/download/v0.1.3/music-tui-0.1.3-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "37c683f8108f5a5a5a0d1d1cab9f61df8cd17660b9a953243324dfd7f1e6ff04"
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
