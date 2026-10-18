class Atp < Formula
  desc "One command for all the platforms: read, search, post, chat and download"
  homepage "https://github.com/WindustH/atp"
  version "0.2.0"
  license "MIT"

  head do
    url "https://github.com/WindustH/atp.git", branch: "main"
    depends_on "cmake" => :build
    depends_on "rust" => :build
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/WindustH/atp/releases/download/v0.2.0/atp-0.2.0-aarch64-apple-darwin.tar.gz"
    sha256 "c78265e23c347a544c7271228c943417e7aee9986b8618b4765d3973a03e7ab9"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/atp/releases/download/v0.2.0/atp-0.2.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "bd38424085dfbb4c53dc7602bc199aec140644c5eb681140ddd461f9a6ee5437"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/WindustH/atp/releases/download/v0.2.0/atp-0.2.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "79e23fe44d6a62b9bc6403b106bd75ef6269ca71164c3b419006b1ba688a26e1"
  end

  def install
    if build.head?
      system "cargo", "install", *std_cargo_args
    else
      bin.install "atp"
      doc.install "README.md", "README.zh-CN.md"
    end
  end

  def caveats
    <<~EOS
      ffmpeg is optional: ATP uses it to merge video and audio downloads.
        brew install ffmpeg
    EOS
  end

  test do
    assert_match "atp #{version}", shell_output("#{bin}/atp --version")
  end
end
