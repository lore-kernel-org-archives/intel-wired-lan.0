From: kbuild test robot <lkp@intel.com>
Date: Fri, 08 Jun 2018 02:22:09 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 5d74b2e4f75d0c1a8be2a395a8b5ddba661ecccf
Message-ID: <5b1977d1.51E1S5dnZxkXmM8W%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 5d74b2e4f75d0c1a8be2a395a8b5ddba661ecccf  i40e: implement AF_XDP zero-copy support for Rx

Regressions in current branch:

drivers/net/ethernet/intel/i40e/i40e_xsk.c:330:20: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
drivers/net/ethernet/intel/i40e/i40e_xsk.c:330:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:496:56: sparse: restricted __be32 degrades to integer
drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:543:12: error: redefinition of 'ixgbe_ipsec_check_mgmt_ip'

Error ids grouped by kconfigs:

recent_errors
??? alpha-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? arm64-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? arm-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_xsk.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_xsk.c:warning:cast-to-pointer-from-integer-of-different-size
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_xsk.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_xsk.c:warning:cast-to-pointer-from-integer-of-different-size
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? i386-randconfig-i1-201822
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? i386-randconfig-s1-201822
??? ??? drivers-net-ethernet-intel-i40e-i40e_xsk.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_xsk.c:warning:cast-to-pointer-from-integer-of-different-size
??? i386-randconfig-x006-201822
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? i386-randconfig-x009-201822
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? i386-randconfig-x072-201822
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? i386-randconfig-x073-201822
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? i386-randconfig-x076-201822
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? ia64-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? ia64-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? mips-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? mips-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? parisc-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? powerpc-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? powerpc-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? s390-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? s390-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? sparc64-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? sparc64-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? sparc-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? sparc-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:sparse:restricted-__be32-degrades-to-integer
??? x86_64-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? x86_64-randconfig-x001-201822
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? x86_64-randconfig-x006-201822
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? xtensa-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
??? xtensa-allyesconfig
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip

elapsed time: 255m

configs tested: 139

x86_64                           allmodconfig
i386                               tinyconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201822
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
i386                     randconfig-i0-201822
i386                     randconfig-i1-201822
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
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                             allmodconfig
arm                       omap2plus_defconfig
arm                                    sa1100
arm                              allmodconfig
arm                                   samsung
arm                        mvebu_v7_defconfig
arm                          ixp4xx_defconfig
arm                       imx_v6_v7_defconfig
arm64                            allmodconfig
arm                           tegra_defconfig
arm                                      arm5
arm64                            alldefconfig
arm                                        sh
arm                                     arm67
i386                     randconfig-a0-201822
i386                     randconfig-a1-201822
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                              allnoconfig
arm                         axm55xx_defconfig
arm                           corgi_defconfig
arm                          moxart_defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201822
i386                     randconfig-s1-201822
x86_64                 randconfig-s3-06080047
x86_64                 randconfig-s4-06080047
x86_64                 randconfig-s5-06080047
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
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64                              fedora-25
i386                   randconfig-x078-201822
i386                   randconfig-x079-201822
i386                   randconfig-x070-201822
i386                   randconfig-x074-201822
i386                   randconfig-x076-201822
i386                   randconfig-x075-201822
i386                   randconfig-x071-201822
i386                   randconfig-x073-201822
i386                   randconfig-x077-201822
i386                   randconfig-x072-201822
i386                                defconfig
i386                             alldefconfig
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

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
