class Cryptode < Formula
  desc "Cryptode: macOS VPN connection manager"
  homepage "https://github.com/riboseinc/cryptode"
  url "https://github.com/riboseinc/cryptode/archive/v1.3.1.tar.gz"
  sha256 "06ff10c6300b7edd44248c3929b8821b2d9b4426c314d10d0a946e07d3cfb1d4"
  head "https://github.com/riboseinc/cryptode.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "riboseinc/libnereon/libnereon"
  depends_on "json-c"
  depends_on "openssl"
  depends_on "openvpn"

  devel do
    version '1.3.1'
  end

  def install
    system './autogen.sh'
    system "./configure", "--prefix=#{prefix}",
            "--with-openssl=#{Formula["openssl"].opt_prefix}"
    system "make", "install"
  end

  plist_options startup: false

  def caveats; <<-EOS
    cryptoded and cryptode requires to be installed in `/opt`
    run:
      sudo /usr/local/bin/cryptode_install.sh

    Ensure that `/opt/cryptode/bin` is in your PATH and is set before `/usr/local/bin`. E.g.:
      PATH=/opt/cryptode/bin:/usr/local/bin:$PATH

    If this is an upgrade and you already have the plist loaded:
      sudo /usr/local/bin/cryptode_uninstall.sh
      sudo /usr/local/bin/cryptode_install.sh
    EOS
  end

  test do
    system "cryptode", "--version"
  end
end
