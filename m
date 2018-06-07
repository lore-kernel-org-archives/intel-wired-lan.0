From: kbuild test robot <lkp@intel.com>
Date: Thu, 07 Jun 2018 18:55:17 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 a009a81ed3ae2334db24462b6d37286b8810049f
Message-ID: <5b190f15.YQMTdJEVr6vgrDEL%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: a009a81ed3ae2334db24462b6d37286b8810049f  i40e: added queue pair disable/enable functions

Regressions in current branch:

drivers/net//ethernet/intel/ixgbe/ixgbe_ipsec.c:534:12: error: redefinition of 'ixgbe_ipsec_check_mgmt_ip'
drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:496:56: sparse: restricted __be32 degrades to integer
drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:543:12: error: redefinition of 'ixgbe_ipsec_check_mgmt_ip'

Error ids grouped by kconfigs:

recent_errors
|-- alpha-allmodconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
|-- arm-allmodconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
|-- arm64-allmodconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
|-- i386-allmodconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
|-- i386-randconfig-i1-201822
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
|-- i386-randconfig-x009-201822
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
|-- ia64-allmodconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
|-- mips-allmodconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
|-- parisc-allmodconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
|-- powerpc-allmodconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
|-- s390-allmodconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
|-- sparc-allmodconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
|-- sparc-allyesconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
|-- sparc64-allmodconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
|-- sparc64-allyesconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
|-- x86_64-allmodconfig
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:sparse:restricted-__be32-degrades-to-integer
|-- x86_64-randconfig-ne0-06070824
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
|-- x86_64-randconfig-r0-06070833
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
|-- x86_64-randconfig-s0-06071000
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
|-- x86_64-randconfig-s1-06071000
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
|-- x86_64-randconfig-v0-06070849
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip
`-- xtensa-allmodconfig
    `-- drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:error:redefinition-of-ixgbe_ipsec_check_mgmt_ip

TIMEOUT after 600m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 34

alpha                            allmodconfig
alpha                            allyesconfig
arm                            customconfig-0
arm                            customconfig-1
arm                            customconfig-2
arm64                          customconfig-0
arm64                          customconfig-1
arm64                          customconfig-2
i386                           customconfig-0
i386                           customconfig-1
i386                           customconfig-2
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
mips                             allyesconfig
parisc                           allmodconfig
parisc                           allyesconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
s390                             allmodconfig
s390                             allyesconfig
sh                               allmodconfig
sparc                            allyesconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
x86_64                            allnoconfig
x86_64                           allyesconfig
x86_64                         customconfig-0
x86_64                         customconfig-1
x86_64                         customconfig-2
x86_64                              defconfig
x86_64                                    lkp
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 228

arm                     eseries_pxa_defconfig
powerpc                     stx_gp3_defconfig
arm                          pcm027_defconfig
mips                         tb0287_defconfig
powerpc                  mpc885_ads_defconfig
s390                              allnoconfig
x86_64                 randconfig-a0-06070918
x86_64                 randconfig-a0-06071215
x86_64                 randconfig-a0-06071342
x86_64                 randconfig-a0-06071734
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                             alldefconfig
powerpc                 xes_mpc85xx_defconfig
arm                         ebsa110_defconfig
ia64                            zx1_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-06070846
x86_64                           allmodconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201822
x86_64                 randconfig-x000-201822
x86_64                 randconfig-x001-201822
x86_64                 randconfig-x002-201822
x86_64                 randconfig-x003-201822
x86_64                 randconfig-x004-201822
x86_64                 randconfig-x005-201822
x86_64                 randconfig-x006-201822
x86_64                 randconfig-x007-201822
x86_64                 randconfig-x008-201822
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
x86_64                 randconfig-v0-06070849
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64                 randconfig-g0-06070934
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
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
x86_64                 randconfig-s0-06070842
x86_64                 randconfig-s1-06070842
x86_64                 randconfig-s2-06070842
x86_64                 randconfig-s0-06071000
x86_64                 randconfig-s1-06071000
x86_64                 randconfig-s2-06071000
x86_64                 randconfig-s0-06071304
x86_64                 randconfig-s1-06071304
x86_64                 randconfig-s2-06071304
m68k                        m5407c3_defconfig
mips                       bmips_be_defconfig
riscv                               defconfig
sh                         apsh4a3a_defconfig
mips                             allmodconfig
mips                              allnoconfig
powerpc                       ep405_defconfig
powerpc64                         allnoconfig
arm                         bcm2835_defconfig
mips                      maltaaprp_defconfig
mips                         tb0219_defconfig
powerpc                    mvme5100_defconfig
nios2                         3c120_defconfig
powerpc                     kilauea_defconfig
powerpc                 mpc8560_ads_defconfig
sh                          lboxre2_defconfig
m68k                          atari_defconfig
powerpc                 linkstation_defconfig
powerpc                      makalu_defconfig
sh                         microdev_defconfig
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
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201822
i386                     randconfig-s1-201822
x86_64                 randconfig-s3-06070846
x86_64                 randconfig-s4-06070846
x86_64                 randconfig-s5-06070846
x86_64                 randconfig-s3-06071306
x86_64                 randconfig-s4-06071306
x86_64                 randconfig-s5-06071306
sh                        dreamcast_defconfig
sh                         ecovec24_defconfig
microblaze                        allnoconfig
powerpc                      cm5200_defconfig
sparc                            allmodconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201822
i386                   randconfig-b0-06070839
i386                   randconfig-b0-06071245
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
mips                        qi_lb60_defconfig
parisc                      default_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      ppc44x_defconfig
x86_64                 randconfig-b0-06070847
x86_64                 randconfig-b0-06071244
m68k                         amcore_defconfig
sh                               allyesconfig
x86_64                 randconfig-u0-06070626
x86_64                 randconfig-u0-06071218
i386                               tinyconfig
arm                       spear13xx_defconfig
powerpc                    adder875_defconfig
xtensa                            allnoconfig
mips                       lemote2f_defconfig
sh                      rts7751r2d1_defconfig
m68k                              allnoconfig
sh                          polaris_defconfig
arm                            u300_defconfig
c6x                        evmc6457_defconfig
arm                          tango4_defconfig
s390                    performance_defconfig
x86_64                randconfig-ne0-06070824
x86_64                randconfig-ne0-06071147
x86_64                randconfig-ne0-06071329
arm                              allyesconfig
mips                     loongson1c_defconfig
x86_64                 randconfig-h0-06071015
x86_64                 randconfig-h0-06071247
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
x86_64                randconfig-ws0-06070848
powerpc                    sam440ep_defconfig
sh                     sh7710voipgw_defconfig
sh                         ap325rxa_defconfig
xtensa                              defconfig
x86_64                 randconfig-r0-06070833
ia64                             allmodconfig
powerpc                         ps3_defconfig
i386                   randconfig-x0-06070832
i386                   randconfig-x0-06071204

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
