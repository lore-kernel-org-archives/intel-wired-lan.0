From: kbuild test robot <lkp@intel.com>
Date: Thu, 21 Feb 2019 07:01:05 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue] BUILD SUCCESS
 d995d1a01f3a910417bfced412ee337932733af8
Message-ID: <5c6ddc31.R61Qlb5pIin4WnJB%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  dev-queue
branch HEAD: d995d1a01f3a910417bfced412ee337932733af8  i40e: fix XDP_REDIRECT/XDP xmit ring cleanup race

elapsed time: 785m

configs tested: 141

The following configs have been built successfully.
More configs may be tested in the coming days.

parisc                        c3000_defconfig
um                                  defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
x86_64                                    lkp
x86_64          lkp-CONFIG_DEBUG_INFO_REDUCED
x86_64                                   rhel
x86_64                               rhel-7.2
riscv                              tinyconfig
i386                               tinyconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
nds32                               defconfig
nds32                             allnoconfig
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
riscv                             allnoconfig
riscv                               defconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
arm                       omap2plus_defconfig
arm                        mvebu_v7_defconfig
arm                          ixp4xx_defconfig
arm                       imx_v6_v7_defconfig
arm64                            allmodconfig
arm                           tegra_defconfig
arm64                            alldefconfig
i386                     randconfig-a2-201907
i386                     randconfig-a3-201907
i386                     randconfig-a0-201907
i386                     randconfig-a1-201907
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                 randconfig-x013-201907
x86_64                 randconfig-x017-201907
x86_64                 randconfig-x016-201907
x86_64                 randconfig-x019-201907
x86_64                 randconfig-x012-201907
x86_64                 randconfig-x011-201907
x86_64                 randconfig-x018-201907
x86_64                 randconfig-x010-201907
x86_64                 randconfig-x015-201907
x86_64                 randconfig-x014-201907
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
i386                     randconfig-s0-201907
i386                     randconfig-s1-201907
i386                     randconfig-s2-201907
i386                     randconfig-s3-201907
x86_64                           allmodconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
nios2                         10m50_defconfig
h8300                    h8300h-sim_defconfig
x86_64                                  kexec
x86_64                         rhel-7.2-clear
x86_64                              fedora-25
mips                             allmodconfig
mips                      malta_kvm_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
x86_64                 randconfig-l2-02201715
i386                   randconfig-l1-02201715
x86_64                 randconfig-l0-02201715
x86_64                 randconfig-l1-02201715
x86_64                 randconfig-l3-02201715
i386                   randconfig-l2-02201715
i386                   randconfig-l0-02201715
i386                   randconfig-l3-02201715
i386                   randconfig-x019-201907
i386                   randconfig-x015-201907
i386                   randconfig-x016-201907
i386                   randconfig-x014-201907
i386                   randconfig-x012-201907
i386                   randconfig-x013-201907
i386                   randconfig-x010-201907
i386                   randconfig-x018-201907
i386                   randconfig-x017-201907
i386                   randconfig-x011-201907
i386                             allmodconfig
i386                   randconfig-x072-201907
i386                   randconfig-x079-201907
i386                   randconfig-x075-201907
i386                   randconfig-x073-201907
i386                   randconfig-x077-201907
i386                   randconfig-x078-201907
i386                   randconfig-x074-201907
i386                   randconfig-x076-201907
i386                   randconfig-x070-201907
i386                   randconfig-x071-201907
i386                   randconfig-x007-201907
i386                   randconfig-x000-201907
i386                   randconfig-x006-201907
i386                   randconfig-x002-201907
i386                   randconfig-x001-201907
i386                   randconfig-x003-201907
i386                   randconfig-x009-201907
i386                   randconfig-x008-201907
i386                   randconfig-x005-201907
i386                   randconfig-x004-201907
sparc64                          allmodconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
x86_64                 randconfig-x005-201907
x86_64                 randconfig-x008-201907
x86_64                 randconfig-x009-201907
x86_64                 randconfig-x001-201907
x86_64                 randconfig-x002-201907
x86_64                 randconfig-x003-201907
x86_64                 randconfig-x006-201907
x86_64                 randconfig-x007-201907
x86_64                 randconfig-x000-201907
x86_64                 randconfig-x004-201907

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
