class MusicTui < Formula
  desc "Terminal music player backed by MPD, with covers, synced lyrics and a visualizer"
  homepage "https://github.com/WindustH/music-tui"
  version "0.1.0"
  license "MIT"
  head "https://github.com/WindustH/music-tui.git", branch: "master"

  # TODO: after publishing the v0.1.0 GitHub release (the release workflow
  # uploads the .sha256 sidecars), replace the head-only build with bottles:
  #
  # if OS.mac? && Hardware::CPU.arm?
  #   url "https://github.com/WindustH/music-tui/releases/download/v0.1.0/music-tui-0.1.0-aarch64-apple-darwin.tar.gz"
  #   sha256 "<sha256 from the release asset>"
  # elsif OS.linux? && Hardware::CPU.intel?
  #   url "https://github.com/WindustH/music-tui/releases/download/v0.1.0/music-tui-0.1.0-x86_64-unknown-linux-gnu.tar.gz"
  #   sha256 "<sha256 from the release asset>"
  # end

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
