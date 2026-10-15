class Atp < Formula
  desc "One command for all the platforms: read, search, post, chat and download"
  homepage "https://github.com/WindustH/atp"
  version "0.1.0"
  license "MIT"

  head do
    url "https://github.com/WindustH/atp.git", branch: "main"
    depends_on "cmake" => :build
    depends_on "rust" => :build
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/WindustH/atp/releases/download/v0.1.0/atp-0.1.0-aarch64-apple-darwin.tar.gz"
    sha256 "b3cd3aaf1b44f8a4cdf6342a0a2b85aca9e2dd44eaaa6e15a902a6b9e9789962"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/WindustH/atp/releases/download/v0.1.0/atp-0.1.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "39b613ebbd0b9caa3a942f3aaecbe2c8d654ecd528fb81e4715a7fe2407ecd26"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/WindustH/atp/releases/download/v0.1.0/atp-0.1.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "86b15fe90bce278efb41ba1967e4601825ea0770ad4315028ba36c9ccf02377e"
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
