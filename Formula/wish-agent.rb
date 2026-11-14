class WishAgent < Formula
  desc "Self-hosted AI agent server and web app with shell tools and many model providers"
  homepage "https://github.com/WindustH/wish-core"
  version "0.2.8"
  license "MIT"

  conflicts_with "tcl-tk", because: "both install a `wish` binary"

  on_macos do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.8/wish-agent-0.2.8-aarch64-apple-darwin.tar.gz"
      sha256 "9706c3cb205574d56e5cf2e86efcd6570ef4734161b75e3b0533c204f7eb21e1"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.8/wish-agent-0.2.8-x86_64-apple-darwin.tar.gz"
      sha256 "304e8e59183cd6e0f686c802880992c50499cecd652582eb4111ec66783e321e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.8/wish-agent-0.2.8-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "166fd47cce28c510c5ed79d1c684f474c1dd46082a291232d4fac190034826eb"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.8/wish-agent-0.2.8-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "60d2c30d41093135248f0886681a0b1af12784de8ecc9d840601db3b2ca7aed6"
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
