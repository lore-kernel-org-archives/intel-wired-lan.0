From: kbuild test robot <lkp@intel.com>
Date: Sat, 09 Jun 2018 02:16:13 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 6cd2b63cfd3691341837740646bd762cd9ee2fc9
Message-ID: <5b1ac7ed.9rcyUf/5HkzdNUgE%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 6cd2b63cfd3691341837740646bd762cd9ee2fc9  i40e: implement AF_XDP zero-copy support for Rx

Regressions in current branch:

drivers/net/ethernet/intel/i40e/i40e_xsk.c:330:20: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
drivers/net/ethernet/intel/i40e/i40e_xsk.c:330:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:496:56: sparse: restricted __be32 degrades to integer

Error ids grouped by kconfigs:

recent_errors
??? arm-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_xsk.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_xsk.c:warning:cast-to-pointer-from-integer-of-different-size
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_xsk.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_xsk.c:warning:cast-to-pointer-from-integer-of-different-size
??? i386-randconfig-s1-201822
??? ??? drivers-net-ethernet-intel-i40e-i40e_xsk.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_xsk.c:warning:cast-to-pointer-from-integer-of-different-size
??? x86_64-allmodconfig
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:sparse:restricted-__be32-degrades-to-integer

elapsed time: 105m

configs tested: 154

x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                              fedora-25
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201822
x86_64                 randconfig-x003-201822
x86_64                 randconfig-x007-201822
x86_64                 randconfig-x000-201822
x86_64                 randconfig-x004-201822
x86_64                 randconfig-x005-201822
x86_64                 randconfig-x001-201822
x86_64                 randconfig-x008-201822
x86_64                 randconfig-x002-201822
x86_64                 randconfig-x006-201822
x86_64                 randconfig-x009-201822
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
i386                     randconfig-i0-201822
i386                     randconfig-i1-201822
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                             allmodconfig
x86_64                 randconfig-x011-201822
x86_64                 randconfig-x015-201822
x86_64                 randconfig-x018-201822
x86_64                 randconfig-x010-201822
x86_64                 randconfig-x014-201822
x86_64                 randconfig-x019-201822
x86_64                 randconfig-x013-201822
x86_64                 randconfig-x017-201822
x86_64                 randconfig-x016-201822
x86_64                 randconfig-x012-201822
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
i386                   randconfig-a0-06082326
i386                   randconfig-a1-06082326
x86_64                 randconfig-s0-06082326
x86_64                 randconfig-s1-06082326
x86_64                 randconfig-s2-06082326
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
arm                        mvebu_v5_defconfig
mips                        bcm63xx_defconfig
powerpc                        cell_defconfig
powerpc                 mpc832x_mds_defconfig
arm                         s3c2410_defconfig
m68k                        mvme147_defconfig
parisc                generic-64bit_defconfig
sh                               allyesconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201822
i386                     randconfig-s1-201822
x86_64                           allmodconfig
x86_64                 randconfig-s3-06090059
x86_64                 randconfig-s4-06090059
x86_64                 randconfig-s5-06090059
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201822
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                 randconfig-b0-06082341
ia64                      gensparse_defconfig
m68k                        m5272c3_defconfig
x86_64                 randconfig-u0-06090036
i386                               tinyconfig
i386                   randconfig-x012-201822
i386                   randconfig-x016-201822
i386                   randconfig-x014-201822
i386                   randconfig-x017-201822
i386                   randconfig-x018-201822
i386                   randconfig-x013-201822
i386                   randconfig-x011-201822
i386                   randconfig-x015-201822
i386                   randconfig-x019-201822
i386                   randconfig-x010-201822
i386                   randconfig-x009-201822
i386                   randconfig-x008-201822
i386                   randconfig-x005-201822
i386                   randconfig-x001-201822
i386                   randconfig-x003-201822
i386                   randconfig-x000-201822
i386                   randconfig-x004-201822
i386                   randconfig-x006-201822
i386                   randconfig-x002-201822
i386                   randconfig-x007-201822
i386                   randconfig-x070-201822
i386                   randconfig-x071-201822
i386                   randconfig-x072-201822
i386                   randconfig-x073-201822
i386                   randconfig-x074-201822
i386                   randconfig-x075-201822
i386                   randconfig-x076-201822
i386                   randconfig-x077-201822
i386                   randconfig-x078-201822
i386                   randconfig-x079-201822
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
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
x86_64                                  kexec
x86_64                 randconfig-r0-06082233
i386                   randconfig-x0-06082311

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
