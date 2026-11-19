class WishAgent < Formula
  desc "Self-hosted AI agent server and web app with shell tools and many model providers"
  homepage "https://github.com/WindustH/wish-core"
  version "0.2.9"
  license "MIT"

  conflicts_with "tcl-tk", because: "both install a `wish` binary"

  on_macos do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.9/wish-agent-0.2.9-aarch64-apple-darwin.tar.gz"
      sha256 "e594714f83c7c9b061461fd11709ff7845c3a4ea1fd5df19e9177e5d9a2a748f"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.9/wish-agent-0.2.9-x86_64-apple-darwin.tar.gz"
      sha256 "27dbdca12288a83125340d3cc2ae1d74486960ac2674c2aa427f3c0146201491"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.9/wish-agent-0.2.9-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b5a94aaef975744415e3544f92c45a81ed41761bc7de7dbcd1acaf36a71a1248"
    end
    on_intel do
      url "https://github.com/WindustH/wish-core/releases/download/v0.2.9/wish-agent-0.2.9-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ba4647c53d1a223c86269e42e274ff5b8a5bf09f0ad1be210169acde4a06bc64"
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
