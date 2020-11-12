class Sasquatch < Formula
  homepage "https://github.com/devttys0/sasquatch"
  url "https://downloads.sourceforge.net/project/squashfs/squashfs/squashfs4.3/squashfs4.3.tar.gz"
  sha256 "0d605512437b1eb800b4736791559295ee5f60177e102e4d4ccd0ee241a5f3f6"

  depends_on "lzo"
  depends_on "xz"

  patch :p0 do
    url "https://raw.githubusercontent.com/devttys0/sasquatch/master/patches/patch0.txt"
    sha256 "931107010fc554cad36d334858a8b2f83b7cb87425883d016e8cb7a532859db1"
  end

  # Add compatibility with Mac OS X and the BSDs
  # https://github.com/plougher/squashfs-tools/pull/3
  patch :p1 do
    url "https://github.com/plougher/squashfs-tools/pull/3.diff"
    sha256 "5e20ee05adbf5ddbc231054203441c2c50dc895e010b29c24ae3515aa4ecdd17"
  end

  def install
    cd "squashfs-tools"
    inreplace "xz_wrapper.c", "<lzma.h>", "\"#{HOMEBREW_PREFIX}/include/lzma.h\""
    inreplace "unsquashfs.c", "#include <sys/sysmacros.h>", ""
    system "make"
    bin.install "sasquatch"
  end
end

