class Multinest < Formula
  desc "Efficient Bayesian inference with nested sampling"
  homepage "https://github.com/Astro-Lee/MultiNest"
  url "https://github.com/Astro-Lee/MultiNest/archive/refs/tags/v3.12.tar.gz"
  sha256 "ce3f5183d9655f0960d3e788864e79fe489859fbf7c1218987fe9f7202ea3bb9"

  depends_on "cmake" => :build
  depends_on "gcc" # gfortran
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
    assert_path_exists lib/"libmultinest.dylib"
    assert_path_exists include/"multinest.h"
  end
end
