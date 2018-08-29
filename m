From: kbuild test robot <lkp@intel.com>
Date: Thu, 30 Aug 2018 02:56:02 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 517f5c005edbff6226701f57adcd9c2b6a5c6921
Message-ID: <5b86ec42.nUnROhf4/BFL9quc%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 517f5c005edbff6226701f57adcd9c2b6a5c6921  Documentation: igbvf: Update kernel documentation

Regressions in current branch:

drivers/net/ethernet/intel/i40e/i40e_main.c:14272:2-8: ERROR: missing iounmap; ioremap on line 14143 and execution via conditional on line 14271

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:ERROR:missing-iounmap-ioremap-on-line-and-execution-via-conditional-on-line

elapsed time: 174m

configs tested: 172

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
m68k                                defconfig
s390                       zfcpdump_defconfig
arm                              zx_defconfig
sparc64                          allyesconfig
x86_64                 randconfig-a0-08300032
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                               tinyconfig
i386                   randconfig-x018-201834
i386                   randconfig-x017-201834
i386                   randconfig-x010-201834
i386                   randconfig-x013-201834
i386                   randconfig-x016-201834
i386                   randconfig-x011-201834
i386                   randconfig-x019-201834
i386                   randconfig-x015-201834
i386                   randconfig-x012-201834
i386                   randconfig-x014-201834
x86_64                              fedora-25
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201834
x86_64                 randconfig-x000-201834
x86_64                 randconfig-x009-201834
x86_64                 randconfig-x001-201834
x86_64                 randconfig-x004-201834
x86_64                 randconfig-x003-201834
x86_64                 randconfig-x008-201834
x86_64                 randconfig-x007-201834
x86_64                 randconfig-x006-201834
x86_64                 randconfig-x005-201834
x86_64                 randconfig-x002-201834
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
i386                     randconfig-i0-201834
i386                     randconfig-i1-201834
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                               defconfig
mips                           ip32_defconfig
mips                       lemote2f_defconfig
x86_64                 randconfig-g0-08300022
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                             allmodconfig
x86_64                 randconfig-x019-201834
x86_64                 randconfig-x013-201834
x86_64                 randconfig-x018-201834
x86_64                 randconfig-x012-201834
x86_64                 randconfig-x017-201834
x86_64                 randconfig-x010-201834
x86_64                 randconfig-x014-201834
x86_64                 randconfig-x015-201834
x86_64                 randconfig-x016-201834
x86_64                 randconfig-x011-201834
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
arm                              allmodconfig
arm                                      arm5
arm                                     arm67
arm                       imx_v6_v7_defconfig
arm                          ixp4xx_defconfig
arm                        mvebu_v7_defconfig
arm                       omap2plus_defconfig
arm                                    sa1100
arm                                   samsung
arm                                        sh
arm                           tegra_defconfig
arm64                            alldefconfig
arm64                            allmodconfig
i386                   randconfig-a0-08280857
i386                   randconfig-a1-08280857
x86_64                 randconfig-s0-08291511
x86_64                 randconfig-s1-08291511
x86_64                 randconfig-s2-08291511
x86_64                 randconfig-s0-08300050
x86_64                 randconfig-s1-08300050
x86_64                 randconfig-s2-08300050
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
arm                        keystone_defconfig
ia64                         bigsur_defconfig
mips                      bmips_stb_defconfig
powerpc               corenet_basic_defconfig
arm                          badge4_defconfig
powerpc64                        allmodconfig
sh                            hp6xx_defconfig
sh                          r7780mp_defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                   randconfig-s1-08280925
i386                   randconfig-s0-08280925
x86_64                           allmodconfig
x86_64                 randconfig-s3-08292342
x86_64                 randconfig-s4-08292342
x86_64                 randconfig-s5-08292342
x86_64                 randconfig-i0-08280848
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                         palmz72_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                     powernv_defconfig
microblaze                       allyesconfig
x86_64                 randconfig-u0-08292328
x86_64                 randconfig-u0-08300046
arm                          pxa3xx_defconfig
s390                             allmodconfig
x86_64                randconfig-ne0-08291617
i386                   randconfig-x077-201834
i386                   randconfig-x070-201834
i386                   randconfig-x076-201834
i386                   randconfig-x075-201834
i386                   randconfig-x072-201834
i386                   randconfig-x078-201834
i386                   randconfig-x071-201834
i386                   randconfig-x074-201834
i386                   randconfig-x073-201834
i386                   randconfig-x079-201834
i386                   randconfig-x000-201834
i386                   randconfig-x001-201834
i386                   randconfig-x002-201834
i386                   randconfig-x003-201834
i386                   randconfig-x004-201834
i386                   randconfig-x005-201834
i386                   randconfig-x006-201834
i386                   randconfig-x007-201834
i386                   randconfig-x008-201834
i386                   randconfig-x009-201834
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                                  kexec
x86_64                 randconfig-r0-08291101
mips                         db1xxx_defconfig
mips                      maltasmvp_defconfig
i386                   randconfig-x0-08291447

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
