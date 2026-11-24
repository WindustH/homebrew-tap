class WishAgent < Formula
  desc "Self-hosted AI agent server and web app with shell tools and many model providers"
  homepage "https://github.com/WindustH/wish-core"
  version "0.2.11"
  license "MIT"

  conflicts_with "tcl-tk", because: "both install a `wish` binary"

  on_macos do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.11/wish-agent-0.2.11-aarch64-apple-darwin.tar.gz"
      sha256 "474ecc77df260a41daf953858644c12c601a384a51533720ec999ea172f82988"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.11/wish-agent-0.2.11-x86_64-apple-darwin.tar.gz"
      sha256 "834427b507fa6c02436dc2b775818a93977a0aacd45924cd9f540e4828066192"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.11/wish-agent-0.2.11-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d430addf8ff9a7d72c92f823f14140ef2a53012ad4bb5c9f1c43d212780e389c"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.11/wish-agent-0.2.11-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0c212225c560af068d4bd59c1568428cfd26782374e7ec3fd931b05dd2b98728"
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
