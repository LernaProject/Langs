FROM buildpack-deps:jessie

RUN set -ux                                                          && \
    readonly GCC_VERSION=6.3.0                                       && \
    readonly GDC_VERSION=v2.068.2_gcc6                               && \
    readonly BINUTILS_VERSION=2.27                                   && \
    readonly PREFIX=/trusted/gcc                                     && \
    CFLAGS='-march=native -mfpmath=sse -pipe'                        && \
    readonly DEPS='bison flex'                                       && \
    for key in \
        B215C1633BCA0477615F1B35A5B3A004745C015A B3C42148A44E6983B3E4CC0793FA9B1AB75C61B8  \
        90AA470469D3965A87A5DCB494D03953902C9419 80F98B2E0DAB6C8281BDF541A7C8C3B2F71EDF1C  \
        7F74F97C103468EE5D750B583AB00996FC26A641 33C235A34C46AA3FFB293709A328C3A2C3C45C06; \
    do gpg --keyserver ha.pool.sks-keyservers.net --recv-keys $key;     \
    done                                                             && \
    apt-get update                                                   && \
    apt-get install -y $DEPS                                         && \
    mkdir -p /usr/src/binutils/build /usr/src/gcc/build /usr/src/gdc && \
    curl -fSL ftp://ftp.gnu.org/gnu/binutils/binutils-$BINUTILS_VERSION.tar.bz2 | \
        tar xj -C/usr/src/binutils --strip-components=1              && \
    cd /usr/src/binutils/build                                       && \
    ../configure                                                        \
        CFLAGS="$CFLAGS -O2"                                            \
        CXXFLAGS="$CFLAGS -O2"                                          \
        --prefix="$PREFIX"                                              \
        --enable-gold=default                                           \
        --enable-ld=no                                                  \
        --enable-plugins                                                \
        --disable-werror                                                \
        --enable-lto                                                 && \
    make -j`nproc`                                                   && \
    make install                                                     && \
    curl -fSL "http://ftpmirror.gnu.org/gcc/gcc-$GCC_VERSION/gcc-$GCC_VERSION.tar.bz2{,.sig}" \
        -o 'gcc.tar.bz2#1'                                           && \
    gpg --batch --verify gcc.tar.bz2.sig gcc.tar.bz2                 && \
    tar xf gcc.tar.bz2 -C/usr/src/gcc --strip-components=1           && \
    rm -f gcc.tar.bz2*                                               && \
    cd /usr/src/gdc                                                  && \
    rm -rf /usr/src/binutils/build                                   && \
    curl -fSL https://github.com/D-Programming-GDC/GDC/archive/$GDC_VERSION.tar.gz | \
        tar xz --strip-components=1                                  && \
    ./setup-gcc.sh /usr/src/gcc                                      && \
    cd /usr/src/gcc                                                  && \
    contrib/download_prerequisites                                   && \
    rm -f -- *.tar.*z*                                               && \
    cd build                                                         && \
    ../configure                                                        \
        CFLAGS="$CFLAGS"                                                \
        --prefix="$PREFIX"                                              \
        --disable-multilib                                              \
        --enable-languages=c,c++,d,fortran,go                           \
        --enable-lto                                                 && \
    make -j`nproc` BOOT_CFLAGS="$CFLAGS -O2"                         && \
    make install                                                     && \
    mkdir /usr/src/binutils/build                                    && \
    cd /usr/src/binutils/build                                       && \
    rm -rf /usr/src/gcc /usr/src/gdc                                 && \
    ../configure                                                        \
        CC="$PREFIX/bin/gcc" CXX="$PREFIX/bin/g++"                      \
        CFLAGS="$CFLAGS -O2 -B$PREFIX/bin"                              \
        CXXFLAGS="$CFLAGS -O2 -B$PREFIX/bin"                            \
        --prefix="$PREFIX"                                              \
        --enable-gold=default                                           \
        --enable-ld=no                                                  \
        --enable-plugins                                                \
        --disable-werror                                                \
        --enable-lto                                                 && \
    make -j`nproc`                                                   && \
    make install                                                     && \
    cd /                                                             && \
    rm -rf /usr/src/binutils                                         && \
    apt-get purge -y --auto-remove $DEPS                             && \
    apt-get clean

# TODO: If there's no other compiler except GAwk that needs these libraries, move them there.
# GMP built with LTO (both with GCC and Clang) fails the `t-get_d_2exp` test.
RUN set -ux                                                            && \
    readonly GMP_VERSION=6.1.2                                         && \
    readonly PREFIX=/trusted/gcc                                       && \
    CC=/trusted/gcc/bin/gcc                                            && \
    NM=/trusted/gcc/bin/gcc-nm                                         && \
    AR=/trusted/gcc/bin/gcc-ar                                         && \
    RANLIB=/trusted/gcc/bin/gcc-ranlib                                 && \
    CFLAGS='-O2 -march=native -mfpmath=sse -fomit-frame-pointer -pipe' && \
    LDFLAGS=-B/trusted/gcc/bin                                         && \
    readonly DEPS=lzip                                                 && \
    apt-get update                                                     && \
    apt-get install -y $DEPS                                           && \
    mkdir /usr/src/gmp                                                 && \
    cd /usr/src/gmp                                                    && \
    curl -fSL https://gmplib.org/download/gmp/gmp-$GMP_VERSION.tar.lz |   \
        tar x --lzip --strip-components=1                              && \
    ./configure                                                           \
        CC="$CC" NM="$NM" AR="$AR" RANLIB="$RANLIB"                       \
        CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS"                               \
        --prefix="$PREFIX"                                             && \
    make -j`nproc`                                                     && \
    make -k check                                                      && \
    make install                                                       && \
    cd /                                                               && \
    rm -rf /usr/src/gmp                                                && \
    apt-get purge -y --auto-remove $DEPS                               && \
    apt-get clean

RUN set -ux                                                                   && \
    readonly MPFR_VERSION=3.1.5                                               && \
    readonly PREFIX=/trusted/gcc                                              && \
    CC=/trusted/gcc/bin/gcc                                                   && \
    NM=/trusted/gcc/bin/gcc-nm                                                && \
    AR=/trusted/gcc/bin/gcc-ar                                                && \
    RANLIB=/trusted/gcc/bin/gcc-ranlib                                        && \
    CFLAGS='-O2 -march=native -mfpmath=sse -flto -fomit-frame-pointer -pipe'  && \
    LDFLAGS=-B/trusted/gcc/bin                                                && \
    mkdir /usr/src/mpfr                                                       && \
    cd /usr/src/mpfr                                                          && \
    curl -fSL http://www.mpfr.org/mpfr-$MPFR_VERSION/mpfr-$MPFR_VERSION.tar.xz | \
        tar xJ --strip-components=1                                           && \
    ./configure                                                                  \
        CC="$CC" NM="$NM" AR="$AR" RANLIB="$RANLIB"                              \
        CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS"                                      \
        --prefix="$PREFIX"                                                       \
        --disable-dependency-tracking                                            \
        --with-gmp="$PREFIX"                                                  && \
    make -j`nproc`                                                            && \
    make -k check                                                             && \
    make install                                                              && \
    cd /                                                                      && \
    rm -rf /usr/src/mpfr
