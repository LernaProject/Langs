#include <stdio.h>
#include <string.h>
#include <mono/jit/jit.h>
#include <mono/metadata/assembly.h>
#include <mono/metadata/mono-config.h>

#ifndef MONO_PREFIX
#   define MONO_PREFIX ""
#endif

int main(int argc, char* argv[ ]) {
    if (argc < 2 || !strcmp(argv[1], "-h") || !strcmp(argv[1], "--help")) {
        fprintf(stderr, "Usage:\n  %s <exe> [<args>...]\n", argv[0]);
        return 2;
    }

    mono_set_dirs(MONO_PREFIX "/lib", MONO_PREFIX "/etc");
    mono_config_parse(MONO_PREFIX "/etc/mono/config");

    MonoDomain* domain = mono_jit_init("Lerna");
    if (!domain) {
        fputs("Cannot create a domain\n", stderr);
        return 1;
    }

    MonoAssembly* assembly = mono_domain_assembly_open(domain, argv[1]);
    if (!assembly) {
        fputs("Cannot open an assembly\n", stderr);
        return 1;
    }

    return mono_jit_exec(domain, assembly, argc - 1, argv + 1);
}
