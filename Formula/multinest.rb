class Multinest < Formula
  desc "Efficient Bayesian inference with nested sampling"
  homepage "https://github.com/Astro-Lee/MultiNest"
  url "https://github.com/Astro-Lee/MultiNest/archive/refs/tags/v3.12.tar.gz"
  sha256 "2c7246ba50486b6a38f0eb885cf6abf5a8191dcfe531ad3166e458f2329813fa"

  depends_on "cmake"  => :build
  depends_on "gcc"    # gfortran
  depends_on "lapack"
  depends_on "open-mpi"

  def install
    cd "MultiNest_v3.12_CMake/multinest" do
      system "cmake", "-B", "build", *std_cmake_args
      system "cmake", "--build", "build"
      system "cmake", "--install", "build"
    end
  end

  def caveats
    <<~EOS
      Run this to add library path to your shell profile:
        echo 'export DYLD_LIBRARY_PATH="#{lib}:$DYLD_LIBRARY_PATH"' >> ~/.zshrc
    EOS
  end

  test do
    assert_predicate lib/"libmultinest.dylib", :exist?
    assert_predicate include/"multinest.h", :exist?
  end
end
