class WishAgent < Formula
  desc "Self-hosted AI agent server and web app with shell tools and many model providers"
  homepage "https://github.com/WindustH/wish-core"
  version "0.2.7"
  license "MIT"

  conflicts_with "tcl-tk", because: "both install a `wish` binary"

  on_macos do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.7/wish-agent-0.2.7-aarch64-apple-darwin.tar.gz"
      sha256 "be22107a3c2743102f88d8f8f23dda042454d102e5a7e79ed0856c9c14604fd3"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.7/wish-agent-0.2.7-x86_64-apple-darwin.tar.gz"
      sha256 "7be6c45ec2bc6033f6e80fc6acbed154e57c2f114c5d24c7abdca691bda3f92b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.7/wish-agent-0.2.7-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "834795f461a0fa26b6f56bd6e9d7392c4169e4b65a2f2ddc3dfff417d4db37c7"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.7/wish-agent-0.2.7-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f4f14847f2c920cc7e0c653db3aa999414fe33942df108698c7b546ef716097f"
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
