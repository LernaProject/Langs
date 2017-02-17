FROM lerna/comp/gcc

RUN set -ux                                                         && \
    readonly PYTHON_VERSION=3.6.0                                   && \
    readonly PREFIX=/trusted/python3                                && \
    readonly OJ_MODULE=online_judge                                 && \
    readonly ONLINE_JUDGE=ONLINE_JUDGE                              && \
    CC=/trusted/gcc/bin/gcc                                         && \
    CXX=/trusted/gcc/bin/g++                                        && \
    NM=/trusted/gcc/bin/gcc-nm                                      && \
    AR=/trusted/gcc/bin/gcc-ar                                      && \
    RANLIB=/trusted/gcc/bin/gcc-ranlib                              && \
    CFLAGS='-march=native -mfpmath=sse -fomit-frame-pointer -pipe'  && \
    LDFLAGS='-B/trusted/gcc/bin -Wl,-rpath=/trusted/gcc/lib64'      && \
    mkdir -p /usr/src/python3 "/usr/src/online_judge/$OJ_MODULE"    && \
    cd /usr/src/python3                                             && \
    curl -fSL https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tar.xz | \
        tar xJ --strip-components=1                                 && \
    ./configure                                                        \
        CC="$CC" CXX="$CXX" NM="$NM" AR="$AR" RANLIB="$RANLIB"         \
        CFLAGS="$CFLAGS" CXXFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS"         \
        --prefix="$PREFIX"                                             \
        --enable-optimizations                                         \
        --with-lto                                                  && \
    make -j`nproc` profile-opt                                      && \
    make install                                                    && \
    cd /usr/src/online_judge                                        && \
    rm -rf /usr/src/python3                                         && \
    echo "$ONLINE_JUDGE = True" > "$OJ_MODULE/__init__.py"          && \
    echo 'from setuptools import setup, find_packages' >setup.py    && \
    echo 'setup(name="online-judge", version="1.0", packages=find_packages())' >>setup.py && \
    "$PREFIX/bin/pip3" install .                                    && \
    cd /                                                            && \
    rm -rf /usr/src/online_judge

RUN ["/trusted/python3/bin/pip3", "install", "Cython==0.25.2", "nuitka==0.5.25"]
