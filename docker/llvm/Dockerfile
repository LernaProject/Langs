FROM buildpack-deps:jessie

# http://llvm.org/docs/GettingStarted.html
# http://llvm.org/docs/CMake.html
# http://llvm.org/docs/GoldPlugin.html
# http://omniprog.info/cpp.html
# TODO: Remove Compiler-RT?
RUN set -ux                                                                    && \
    readonly LLVM_VERSION=3.9.1                                                && \
    readonly BINUTILS_VERSION=2.27                                             && \
    readonly CMAKE_VERSION=3.7.2                                               && \
    readonly PREFIX=/trusted/llvm                                              && \
    CFLAGS='-march=native -mfpmath=sse -pipe'                                  && \
    readonly DEPS=bison                                                        && \
    apt-get update                                                             && \
    apt-get install -y $DEPS                                                   && \
    mkdir -p /tmp/cmake /usr/src/binutils/build /usr/src/llvm/build            && \
    curl -fSL ftp://ftp.gnu.org/gnu/binutils/binutils-$BINUTILS_VERSION.tar.bz2 | \
        tar xj -C/usr/src/binutils --strip-components=1                        && \
    cd /usr/src/binutils/build                                                 && \
    ../configure                                                                  \
        CFLAGS="$CFLAGS -O2"                                                      \
        CXXFLAGS="$CFLAGS -O2"                                                    \
        --prefix="$PREFIX"                                                        \
        --enable-gold=default                                                     \
        --enable-ld=no                                                            \
        --enable-plugins                                                          \
        --disable-werror                                                          \
        --enable-lto                                                           && \
    make -j`nproc`                                                             && \
    make install                                                               && \
    cd /usr/src/llvm                                                           && \
    rm -rf /usr/src/binutils/build                                             && \
    curl https://cmake.org/files/v${CMAKE_VERSION%.*}/cmake-$CMAKE_VERSION-Linux-x86_64.tar.gz | \
        tar xz -C/tmp/cmake --strip-components=1                               && \
    curl -fSL http://releases.llvm.org/$LLVM_VERSION/llvm-$LLVM_VERSION.src.tar.xz | \
        tar xJ --strip-components=1                                            && \
    mkdir tools/clang projects/compiler-rt projects/libcxx projects/libcxxabi  && \
    curl -fSL http://releases.llvm.org/$LLVM_VERSION/cfe-$LLVM_VERSION.src.tar.xz | \
        tar xJ -C tools/clang --strip-components=1                             && \
    curl -fSL http://releases.llvm.org/$LLVM_VERSION/compiler-rt-$LLVM_VERSION.src.tar.xz | \
        tar xJ -C projects/compiler-rt --strip-components=1                    && \
    curl -fSL http://releases.llvm.org/$LLVM_VERSION/libcxx-$LLVM_VERSION.src.tar.xz | \
        tar xJ -C projects/libcxx --strip-components=1                         && \
    curl -fSL http://releases.llvm.org/$LLVM_VERSION/libcxxabi-$LLVM_VERSION.src.tar.xz | \
        tar xJ -C projects/libcxxabi --strip-components=1                      && \
    cd build                                                                   && \
    /tmp/cmake/bin/cmake .. -G'Unix Makefiles'                                    \
        -DCMAKE_C_FLAGS="$CFLAGS -B$PREFIX/bin"                                   \
        -DCMAKE_CXX_FLAGS="$CFLAGS -B$PREFIX/bin"                                 \
        -DCMAKE_INSTALL_PREFIX="$PREFIX"                                          \
        -DLLVM_BINUTILS_INCDIR="$PREFIX/include"                                  \
        -DCMAKE_BUILD_TYPE=Release                                                \
        -DLLVM_TARGETS_TO_BUILD=X86                                            && \
    make -j`nproc`                                                             && \
    make install                                                               && \
    echo '#!'"`which sh`" >/tmp/clang++w                                       && \
    echo 'echo "$@" | egrep -q "^-c | -c | -c$" &&'                               \
        "exec \"$PREFIX/bin/clang++\" -stdlib=libc++ \"\$@\" ||"                  \
        "exec \"$PREFIX/bin/clang++\" -stdlib=libc++ \"\$@\" -nodefaultlibs"      \
            "-lc++ -lc++abi -lm -lc -lgcc_s -lgcc -Wl,-rpath=\"$PREFIX/lib\"" >>/tmp/clang++w && \
    chmod +x /tmp/clang++w                                                     && \
    cd ..                                                                      && \
    rm -rf build                                                               && \
    mkdir build /usr/src/binutils/build                                        && \
    cd /usr/src/binutils/build                                                 && \
    ../configure                                                                  \
        CC="$PREFIX/bin/clang"                                                    \
        CXX=/tmp/clang++w                                                         \
        CFLAGS="$CFLAGS -O2 -B$PREFIX/bin"                                        \
        CXXFLAGS="$CFLAGS -O2 -B$PREFIX/bin"                                      \
        --prefix="$PREFIX"                                                        \
        --enable-gold=default                                                     \
        --enable-ld=no                                                            \
        --enable-plugins                                                          \
        --disable-werror                                                          \
        --enable-lto                                                           && \
    make -j`nproc`                                                             && \
    make install                                                               && \
    apt-get purge -y --auto-remove $DEPS                                       && \
    apt-get clean                                                              && \
    cd /usr/src/llvm/build                                                     && \
    rm -rf /usr/src/binutils                                                   && \
    /tmp/cmake/bin/cmake .. -G'Unix Makefiles'                                    \
        -DCMAKE_C_COMPILER="$PREFIX/bin/clang"                                    \
        -DCMAKE_CXX_COMPILER=/tmp/clang++w                                        \
        -DCMAKE_C_FLAGS="$CFLAGS -B$PREFIX/bin"                                   \
        -DCMAKE_CXX_FLAGS="$CFLAGS -B$PREFIX/bin"                                 \
        -DCMAKE_INSTALL_PREFIX="$PREFIX"                                          \
        -DLLVM_BINUTILS_INCDIR="$PREFIX/include"                                  \
        -DCMAKE_BUILD_TYPE=Release                                                \
        -DLLVM_TARGETS_TO_BUILD=X86                                            && \
    make -j`nproc`                                                             && \
    make install                                                               && \
    cd /                                                                       && \
    rm -rf /tmp/cmake /tmp/clang++w /usr/src/llvm
