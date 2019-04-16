From: kbuild test robot <lkp@intel.com>
Date: Wed, 17 Apr 2019 06:15:48 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 f6282c6b37bf452a2ec63896a63aa9137376f885
Message-ID: <5cb65414.5Hwc3C0g1dixRMkc%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: f6282c6b37bf452a2ec63896a63aa9137376f885  i40e: Fix of memory leak and integer truncation in i40e_virtchnl.c

Regressions in current branch:

drivers/net/ethernet/intel/i40e/i40e_main.c:14842:2-8: ERROR: missing iounmap; ioremap on line 14700 and execution via conditional on line 14841

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:ERROR:missing-iounmap-ioremap-on-line-and-execution-via-conditional-on-line
??? x86_64-allyesconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:ERROR:missing-iounmap-ioremap-on-line-and-execution-via-conditional-on-line

elapsed time: 347m

configs tested: 169

i386                     randconfig-n2-201915
i386                     randconfig-n3-201915
i386                     randconfig-n0-201915
i386                     randconfig-n1-201915
i386                     randconfig-i1-201915
i386                     randconfig-i0-201915
i386                     randconfig-i3-201915
i386                     randconfig-i2-201915
x86_64                           allyesconfig
i386                             allmodconfig
x86_64                 randconfig-x015-201915
x86_64                 randconfig-x016-201915
x86_64                 randconfig-x012-201915
x86_64                 randconfig-x017-201915
x86_64                 randconfig-x013-201915
x86_64                 randconfig-x018-201915
x86_64                 randconfig-x010-201915
x86_64                 randconfig-x014-201915
x86_64                 randconfig-x019-201915
x86_64                 randconfig-x011-201915
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
i386                     randconfig-a1-201915
i386                     randconfig-a2-201915
i386                     randconfig-a0-201915
i386                     randconfig-a3-201915
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                   randconfig-k2-201915
i386                     randconfig-k2-201915
i386                     randconfig-k3-201915
i386                     randconfig-k0-201915
x86_64                   randconfig-k1-201915
x86_64                   randconfig-k3-201915
i386                     randconfig-k1-201915
x86_64                   randconfig-k0-201915
x86_64                                    lkp
x86_64                                   rhel
arm                              allmodconfig
arm                               allnoconfig
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
riscv                              tinyconfig
i386                               tinyconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
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
x86_64                              fedora-25
x86_64                                  kexec
x86_64                               rhel-7.6
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                   randconfig-m2-201915
i386                     randconfig-m0-201915
i386                     randconfig-m3-201915
i386                     randconfig-m2-201915
x86_64                   randconfig-m1-201915
x86_64                   randconfig-m0-201915
x86_64                   randconfig-m3-201915
i386                     randconfig-m1-201915
riscv                             allnoconfig
riscv                               defconfig
x86_64                 randconfig-l3-04160016
x86_64                 randconfig-l0-04160016
i386                   randconfig-l3-04160016
i386                   randconfig-l2-04160016
x86_64                 randconfig-l1-04160016
i386                   randconfig-l0-04160016
i386                   randconfig-l1-04160016
x86_64                 randconfig-l2-04160016
x86_64                           allmodconfig
i386                             alldefconfig
x86_64                   randconfig-i1-201915
x86_64                   randconfig-i2-201915
x86_64                   randconfig-i3-201915
x86_64                   randconfig-i0-201915
i386                   randconfig-x010-201915
i386                   randconfig-x018-201915
i386                   randconfig-x017-201915
i386                   randconfig-x013-201915
i386                   randconfig-x011-201915
i386                   randconfig-x014-201915
i386                   randconfig-x019-201915
i386                   randconfig-x015-201915
i386                   randconfig-x016-201915
i386                   randconfig-x012-201915
i386                              allnoconfig
i386                                defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
um                                  defconfig
i386                   randconfig-x077-201915
i386                   randconfig-x074-201915
i386                   randconfig-x070-201915
i386                   randconfig-x072-201915
i386                   randconfig-x075-201915
i386                   randconfig-x071-201915
i386                   randconfig-x079-201915
i386                   randconfig-x078-201915
i386                   randconfig-x073-201915
i386                   randconfig-x076-201915
x86_64                 randconfig-g2-04141729
x86_64                 randconfig-g3-04141729
x86_64                 randconfig-g0-04141729
x86_64                 randconfig-g1-04141729
i386                   randconfig-x002-201915
i386                   randconfig-x001-201915
i386                   randconfig-x005-201915
i386                   randconfig-x007-201915
i386                   randconfig-x000-201915
i386                   randconfig-x004-201915
i386                   randconfig-x008-201915
i386                   randconfig-x009-201915
i386                   randconfig-x006-201915
i386                   randconfig-x003-201915
x86_64                 randconfig-x001-201915
x86_64                 randconfig-x004-201915
x86_64                 randconfig-x000-201915
x86_64                 randconfig-x003-201915
x86_64                 randconfig-x007-201915
x86_64                 randconfig-x008-201915
x86_64                 randconfig-x002-201915
x86_64                 randconfig-x006-201915
x86_64                 randconfig-x009-201915
x86_64                 randconfig-x005-201915
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
