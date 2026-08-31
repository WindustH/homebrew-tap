class MusicTui < Formula
  desc "Terminal music player backed by MPD, with covers, synced lyrics and a visualizer"
  homepage "https://github.com/WindustH/music-tui"
  version "0.1.7"
  license "MIT"
  head do
    url "https://github.com/WindustH/music-tui.git", branch: "main"
    depends_on "rust" => :build
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/WindustH/music-tui/releases/download/v0.1.7/music-tui-0.1.7-aarch64-apple-darwin.tar.gz"
    sha256 "2a492f0af3156aca686ff4c88b2f9efaf68edfc2f30b18c6a4ec4caa067a460b"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/music-tui/releases/download/v0.1.7/music-tui-0.1.7-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "6411815ee8c7954002985f06446f5f3f7476f9b2a4242a36faf439e181fa3ae8"
  end

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
