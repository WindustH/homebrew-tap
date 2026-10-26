class WishAgent < Formula
  desc "Self-hosted AI agent server and web app with shell tools and many model providers"
  homepage "https://github.com/WindustH/wish-core"
  version "0.2.4"
  license "MIT"

  conflicts_with "tcl-tk", because: "both install a `wish` binary"

  on_macos do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.4/wish-agent-0.2.4-aarch64-apple-darwin.tar.gz"
      sha256 "88ea811fd2847b7c9fec018f53e99225e273419330c0bf98f5467b7daa819d21"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.4/wish-agent-0.2.4-x86_64-apple-darwin.tar.gz"
      sha256 "d0b2e8b0a12b24ae218f56f9e7e21bd21ebb433216ef697d2d4c8cf63b4a60e4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.4/wish-agent-0.2.4-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c524679cd2aef9b8b476e440542160b1aa7c90114c98f5751848e743e45c89ee"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.4/wish-agent-0.2.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fe8083f68c4db493bb463b91bba60a7f08569ded0de478b083d4e072948e5296"
    end
  end

  def install
    # The program finds its web app beside it; bin holds a link.
    libexec.install "wish", "web"
    bin.install_symlink libexec/"wish"
    doc.install "README.md"
  end

  service do
    run [opt_bin/"wish"]
    keep_alive true
    working_dir Dir.home
    environment_variables PATH: std_service_path_env
    log_path var/"log/wish-agent.log"
    error_log_path var/"log/wish-agent.log"
  end

  test do
    assert_match "wish #{version}", shell_output("#{bin}/wish --version")
  end
end
