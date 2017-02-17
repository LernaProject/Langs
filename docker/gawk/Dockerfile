FROM lerna/comp/gcc

RUN set -ux                                                                  && \
    readonly GAWK_VERSION=4.1.4                                              && \
    readonly PREFIX=/trusted/gawk                                            && \
    readonly GMP_MPFR_PREFIX=/trusted/gcc                                    && \
    CC=/trusted/gcc/bin/gcc                                                  && \
    NM=/trusted/gcc/bin/gcc-nm                                               && \
    AR=/trusted/gcc/bin/gcc-ar                                               && \
    RANLIB=/trusted/gcc/bin/gcc-ranlib                                       && \
    CFLAGS='-O2 -march=native -mfpmath=sse -flto -fomit-frame-pointer -pipe' && \
    LDFLAGS="-B/trusted/gcc/bin -Wl,-rpath=$GMP_MPFR_PREFIX/lib"             && \
    mkdir /usr/src/gawk                                                      && \
    cd /usr/src/gawk                                                         && \
    curl -fSL ftp://ftp.gnu.org/gnu/gawk/gawk-$GAWK_VERSION.tar.xz |            \
        tar xJ --strip-components=1                                          && \
    ./configure                                                                 \
        CC="$CC" NM="$NM" AR="$AR" RANLIB="$RANLIB"                             \
        CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS"                                     \
        --prefix="$PREFIX"                                                      \
        --disable-nls                                                           \
        --disable-dependency-tracking                                           \
        --with-mpfr="$GMP_MPFR_PREFIX"                                       && \
    make -j`nproc`                                                           && \
    make install                                                             && \
    cd /                                                                     && \
    rm -rf /usr/src/gawk
