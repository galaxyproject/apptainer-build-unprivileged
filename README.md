apptainer-build-unprivileged
============================

A fully relocatable copy of [Apptainer][apptainer] can be installed as an unprivileged user via [the
`install-unprivileged.sh` script][install-unprivileged-sh], which is provided as [an official installation
method][apptainer-install-doc]. This script can be used to generate an installation of Apptainer that should be valid on
any modern Linux system, but it does so by packaging up libraries from a sufficiently old version of Enterprise Linux,
even for Debian, Ubuntu, and other non-EL distributions. It must run on a system with `curl`, `rpm2cpio`, and `cpio`
installed, but `rpm2cpio` is rarely installed on non-EL distributions.

In order to provide an Apptainer installation for [Galaxy][galaxy], this repository is used to prebuild installation
packages (tarballs) for the platforms supported by the installation script. We use the upstream script to ensure
packages are built as per the official method. Please note that libraries included in the package are current as of the
version of EL used at the time of packaging, and they are not automatically checked and rebuilt should any bugs or
security vulnerabilities be found in those libraries.

Using packages
--------------

Packages are available under [Releases][releases].

Packages are built for the currently supported versions of Enterprise Linux. If your distribution is in the list below,
you can use the corresponding EL package:

| Distribution | Package |
| --- | --- |
| RedHat / Rocky Linux / AlmaLinux 8 | `el8` |
| RedHat / Rocky Linux / AlmaLinux 9 | `el9` |
| Debian 10 | `el8` |
| Debian 11 | `el8` |
| Debian 12 | `el9` |
| Ubuntu 20.04 | `el8` |
| Ubuntu 22.04 | `el9` |
| Ubuntu 24.04 | `el9` |
| SUSE 15 | `el8` |

Packages are built for both AMD64/x86_64, and ARM64/aarch64.

Building packages
-----------------

Releases are automatically created and packages are automatically built and uploaded on tag creation. Tags should match
Apptainer repo tags, e.g. `v1.4.0`. Force pushing a tag will cause a rebuild, but be aware that force pushing an older
tag will cause out-of-order releases.

To build locally, run the `apptainer-build-unprivileged.sh` script with the same arguments as `install-unprivileged.sh`,
excluding the `DEST` positional argument, which is automatically generated under the `work` subdirectory. The `-d`
option (distribution) is required. Building requires Docker and, if `-v` (version) is not specified, `curl` and `jq`.

[apptainer-install-doc]: https://apptainer.org/docs/admin/1.4/installation.html#install-unprivileged-from-pre-built-binaries
[apptainer]: https://apptainer.org/
[install-unprivileged-sh]: https://github.com/apptainer/apptainer/blob/main/tools/install-unprivileged.sh
[galaxy]: https://galaxyproject.org/
[releases]: https://github.com/galaxyproject/apptainer-build-unprivileged/releases
