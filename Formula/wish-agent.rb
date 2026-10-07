class WishAgent < Formula
  desc "Self-hosted AI agent server and web app with shell tools and many model providers"
  homepage "https://github.com/WindustH/wish-core"
  version "0.2.0"
  license "MIT"

  conflicts_with "tcl-tk", because: "both install a `wish` binary"

  on_macos do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.0/wish-agent-0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "2a92b34ccda67d7fcf439d94089507093b96747a5eddb16bb5f40044b6dfb6ef"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.0/wish-agent-0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "6ebe037a2090ce007801808e7e7cd39288c9dbef1e902e3c9f771a3eade35d49"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.0/wish-agent-0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2be02df3eaf4ab4bdc218253ddd63b8f215026a82f27f8887e49f99766c2a841"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.0/wish-agent-0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7758a8e4a0dfcabe34cc6fd0ea1b6236669ba67ee34b5d55fb6d31b0b76f3da1"
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
