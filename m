From: kbuild test robot <lkp@intel.com>
Date: Sun, 22 Dec 2019 04:06:09 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue] BUILD REGRESSION
 324f7271ac30968fb1e3dad6198b382943da39aa
Message-ID: <5dfe7b31.5a6nSOMTrNO+pPEm%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  dev-queue
branch HEAD: 324f7271ac30968fb1e3dad6198b382943da39aa  e1000e: Revert "e1000e: Make watchdog use delayed work"

Regressions in current branch:

drivers/net/ethernet/intel/e1000e/netdev.c:7604:6: warning: the address of 'down' will always evaluate as 'true' [-Waddress]

Error ids grouped by kconfigs:

recent_errors
|-- s390-allmodconfig
|   `-- drivers-net-ethernet-intel-e1000e-netdev.c:warning:the-address-of-down-will-always-evaluate-as-true
|-- s390-allyesconfig
|   `-- drivers-net-ethernet-intel-e1000e-netdev.c:warning:the-address-of-down-will-always-evaluate-as-true
|-- x86_64-defconfig
|   `-- drivers-net-ethernet-intel-e1000e-netdev.c:warning:the-address-of-down-will-always-evaluate-as-true
|-- x86_64-fedora-25
|   `-- drivers-net-ethernet-intel-e1000e-netdev.c:warning:the-address-of-down-will-always-evaluate-as-true
|-- x86_64-kexec
|   `-- drivers-net-ethernet-intel-e1000e-netdev.c:warning:the-address-of-down-will-always-evaluate-as-true
|-- x86_64-lkp
|   `-- drivers-net-ethernet-intel-e1000e-netdev.c:warning:the-address-of-down-will-always-evaluate-as-true
|-- x86_64-rhel
|   `-- drivers-net-ethernet-intel-e1000e-netdev.c:warning:the-address-of-down-will-always-evaluate-as-true
`-- x86_64-rhel-7.6
    `-- drivers-net-ethernet-intel-e1000e-netdev.c:warning:the-address-of-down-will-always-evaluate-as-true

TIMEOUT after 2880m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 40

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig

configs tested: 58

parisc                            allnoconfig
parisc                            allyesonfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
s390                              allnoconfig
s390                             alldefconfig
s390                          debug_defconfig
s390                             allmodconfig
s390                                defconfig
s390                       zfcpdump_defconfig
s390                             allyesconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
xtensa                       common_defconfig
openrisc                    or1ksim_defconfig
nios2                         3c120_defconfig
xtensa                          iss_defconfig
c6x                        evmc6678_defconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
openrisc                 simple_smp_defconfig
arm64                randconfig-a001-20191220
arm                  randconfig-a001-20191220
powerpc              randconfig-a001-20191220
arc                  randconfig-a001-20191220
ia64                 randconfig-a001-20191220
sparc                randconfig-a001-20191220

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org Intel Corporation
