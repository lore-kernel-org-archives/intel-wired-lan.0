From: kbuild test robot <lkp@intel.com>
Date: Fri, 24 May 2019 12:08:17 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:100GbE] BUILD SUCCESS
 feee3cb3064ac1a67349a524a5d541cc73b4fe32
Message-ID: <5ce76e31.pp5y2rqpqGYmaWk4%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  100GbE
branch HEAD: feee3cb3064ac1a67349a524a5d541cc73b4fe32  ice: Silence semantic parser warnings

elapsed time: 333m

configs tested: 165

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm64                            allmodconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
i386                   randconfig-k1-05231733
x86_64                 randconfig-k3-05231733
x86_64                 randconfig-k2-05231733
x86_64                 randconfig-k1-05231733
i386                   randconfig-k2-05231733
i386                   randconfig-k3-05231733
i386                   randconfig-k0-05231733
x86_64                 randconfig-k0-05231733
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
nds32                             allnoconfig
nds32                               defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
i386                   randconfig-m2-05231733
x86_64                 randconfig-m1-05231733
x86_64                 randconfig-m0-05231733
x86_64                 randconfig-m3-05231733
i386                   randconfig-m3-05231733
i386                   randconfig-m0-05231733
x86_64                 randconfig-m2-05231733
i386                   randconfig-m1-05231733
riscv                             allnoconfig
riscv                               defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
i386                   randconfig-l2-05231733
i386                   randconfig-l1-05231733
x86_64                 randconfig-l1-05231733
i386                   randconfig-l0-05231733
i386                   randconfig-l3-05231733
x86_64                 randconfig-l2-05231733
x86_64                 randconfig-l3-05231733
x86_64                 randconfig-l0-05231733
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
um                                  defconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                           allmodconfig
i386                             alldefconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
s390                             allmodconfig
i386                              allnoconfig
i386                                defconfig
i386                   randconfig-x011-201920
i386                   randconfig-x013-201920
i386                   randconfig-x018-201920
i386                   randconfig-x012-201920
i386                   randconfig-x016-201920
i386                   randconfig-x017-201920
i386                   randconfig-x010-201920
i386                   randconfig-x014-201920
i386                   randconfig-x015-201920
i386                   randconfig-x019-201920
x86_64                           allyesconfig
i386                             allmodconfig
i386                   randconfig-x009-201920
i386                   randconfig-x008-201920
i386                   randconfig-x006-201920
i386                   randconfig-x004-201920
i386                   randconfig-x005-201920
i386                   randconfig-x001-201920
i386                   randconfig-x000-201920
i386                   randconfig-x007-201920
i386                   randconfig-x003-201920
i386                   randconfig-x002-201920
x86_64               randconfig-x011-05232035
x86_64               randconfig-x013-05232035
x86_64               randconfig-x012-05232035
x86_64               randconfig-x015-05232035
x86_64               randconfig-x010-05232035
x86_64               randconfig-x018-05232035
x86_64               randconfig-x014-05232035
x86_64               randconfig-x016-05232035
x86_64               randconfig-x019-05232035
x86_64               randconfig-x017-05232035
i386                   randconfig-a3-05232035
i386                   randconfig-a1-05232035
i386                   randconfig-a0-05232035
i386                   randconfig-a2-05232035
riscv                              tinyconfig
i386                               tinyconfig
i386                   randconfig-n1-05232030
i386                   randconfig-n3-05232030
i386                   randconfig-n2-05232030
i386                   randconfig-n0-05232030
x86_64               randconfig-x001-05232029
x86_64               randconfig-x008-05232029
x86_64               randconfig-x004-05232029
x86_64               randconfig-x003-05232029
x86_64               randconfig-x009-05232029
x86_64               randconfig-x007-05232029
x86_64               randconfig-x006-05232029
x86_64               randconfig-x002-05232029
x86_64               randconfig-x000-05232029
x86_64               randconfig-x005-05232029
s390                          debug_defconfig
i386                   randconfig-i1-05232029
i386                   randconfig-i0-05232029
i386                   randconfig-i2-05232029
i386                   randconfig-i3-05232029
i386                   randconfig-x073-201920
i386                   randconfig-x071-201920
i386                   randconfig-x070-201920
i386                   randconfig-x074-201920
i386                   randconfig-x078-201920
i386                   randconfig-x075-201920
i386                   randconfig-x072-201920
i386                   randconfig-x076-201920
i386                   randconfig-x077-201920
i386                   randconfig-x079-201920

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
