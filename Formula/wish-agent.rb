class WishAgent < Formula
  desc "Self-hosted AI agent server and web app with shell tools and many model providers"
  homepage "https://github.com/WindustH/wish-core"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.1.2/wish-agent-0.1.2-aarch64-apple-darwin.tar.gz"
      sha256 "68aafef293019ff55656f709c863a64a87aa823f200cfa102afd37e50035cec3"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.1.2/wish-agent-0.1.2-x86_64-apple-darwin.tar.gz"
      sha256 "68732337e8c69179b0faea5ec2706cd6f77167715e19effe948339f749a6d69e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.1.2/wish-agent-0.1.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5a863940cc97ca8ce7d670c4a6376a30117eee62658aaab24fb7c9c41367f408"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.1.2/wish-agent-0.1.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "25fcd73b1d576a4cec23a79983493f55f55a5676fccfbcb3be3ca8fca88c59df"
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
