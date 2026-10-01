class WishAgent < Formula
  desc "Self-hosted AI agent server and web app with shell tools and many model providers"
  homepage "https://github.com/WindustH/wish-core"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.1.0/wish-agent-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "29e3b5db542def83e362ed6a7fde415c961065bd414bf5c785fc71cec616cfaa"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.1.0/wish-agent-0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "3ad159f1b0a6d5f2d65f9c7c056a086fff6e3463256f897b830022ee11f488a2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.1.0/wish-agent-0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "03bcf8b2eca2bb671a664ba092e9b9dfd86285ccdf493d5f6d7b62e83de1b1f5"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.1.0/wish-agent-0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "978ee56851ac3fbc078aec1157319adb0886c03c098d22143cd5799ab218dbe2"
    end
  end

  def install
    # The program finds its web app beside it; bin holds a link under the package's name.
    libexec.install "wish", "web"
    bin.install_symlink libexec/"wish" => "wish-agent"
    doc.install "README.md"
  end

  service do
    run [opt_bin/"wish-agent"]
    keep_alive true
    working_dir Dir.home
    environment_variables PATH: std_service_path_env
    log_path var/"log/wish-agent.log"
    error_log_path var/"log/wish-agent.log"
  end

  test do
    assert_match "wish-agent #{version}", shell_output("#{bin}/wish-agent --version")
  end
end
