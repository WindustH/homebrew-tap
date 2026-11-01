class WishAgent < Formula
  desc "Self-hosted AI agent server and web app with shell tools and many model providers"
  homepage "https://github.com/WindustH/wish-core"
  version "0.2.6"
  license "MIT"

  conflicts_with "tcl-tk", because: "both install a `wish` binary"

  on_macos do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.6/wish-agent-0.2.6-aarch64-apple-darwin.tar.gz"
      sha256 "17500482a0592a56f43ac413389eec68cf30d37f650949ffacd19033019de91e"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.6/wish-agent-0.2.6-x86_64-apple-darwin.tar.gz"
      sha256 "b2fa4b6448eb60ee67e3d215acffdf2ae2b2e63c27725ebb39647f309acf67ac"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.6/wish-agent-0.2.6-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "58f94d96e9894f1760eb4804fc6271ca4a952d603dbda913fbf23926ed1aaa7a"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.6/wish-agent-0.2.6-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2c8431da449d2a9fba0664cf5d477cfc56d52cd275e2a5d76e743020e6573dad"
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
