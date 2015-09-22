From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 22 Sep 2015 10:39:54 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 8986ab49a8149fee3a58063ac35a81818ebef3e8 BUILD DONE
Message-ID: <5600bf7a.AJTnWxL9esZunVe7%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
8986ab49a8149fee3a58063ac35a81818ebef3e8  igb: add more checks for disconnected adapter

drivers/net/ethernet/intel/e1000e/netdev.c:6785:3: error: implicit declaration of function 'e1000e_disable_aspm_locked' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/i40e/i40e_main.c:8539:2: error: implicit declaration of function 'vxlan_features_check' [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
??? sparc64-defconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? x86_64-rhel
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:error:implicit-declaration-of-function-vxlan_features_check

elapsed time: 110m

configs tested: 138

blackfin                            defconfig
ia64                                defconfig
mips                                defconfig
i386                   randconfig-a0-09220931
x86_64                 randconfig-a0-09220931
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
x86_64                            allnoconfig
avr32            atngw100_evklcd100_defconfig
m32r                           usrv_defconfig
mips                         rt305x_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-09220923
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                                  at_hdmac
arm                                    ep93xx
arm                       imx_v6_v7_defconfig
arm                                  iop-adma
arm                          marzen_defconfig
arm                          prima2_defconfig
arm                                    sa1100
arm                                   samsung
arm                                        sh
arm                       spear13xx_defconfig
arm                           acs5k_defconfig
powerpc                mpc7448_hpc2_defconfig
s390                       zfcpdump_defconfig
powerpc                           allnoconfig
x86_64                 randconfig-v0-09212333
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                     mappi3.smp_defconfig
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
i386                             allmodconfig
arm                          pcm027_defconfig
avr32                    hammerhead_defconfig
mips                        nlm_xlr_defconfig
powerpc                      mgcoge_defconfig
powerpc                    mvme5100_defconfig
arm                      pxa255-idp_defconfig
blackfin                  TCM-BF518_defconfig
powerpc                       holly_defconfig
sh                          urquell_defconfig
tile                         tilegx_defconfig
x86_64               randconfig-x014-09211934
x86_64               randconfig-x011-09211934
x86_64               randconfig-x012-09211934
x86_64               randconfig-x010-09211934
x86_64               randconfig-x015-09211934
x86_64               randconfig-x016-09211934
x86_64               randconfig-x018-09211934
x86_64               randconfig-x017-09211934
x86_64               randconfig-x019-09211934
x86_64               randconfig-x013-09211934
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
mips                                   jz4740
mips                              allnoconfig
mips                                     txx9
mips                      fuloong2e_defconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
i386                     randconfig-s1-201538
i386                     randconfig-s0-201538
x86_64                 randconfig-s0-09220845
x86_64                 randconfig-s1-09220845
x86_64                 randconfig-s2-09220845
x86_64                 randconfig-s3-09220845
x86_64                 randconfig-s0-09221003
x86_64                 randconfig-s1-09221003
x86_64                 randconfig-s2-09221003
x86_64                 randconfig-s3-09221003
x86_64                           allmodconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
x86_64                 randconfig-i0-09220936
i386                   randconfig-b0-09220936
i386                   randconfig-b0-09221011
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                             ezx_defconfig
arm                            netx_defconfig
avr32            atngw100_evklcd101_defconfig
powerpc                          allmodconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i1-201538
i386                     randconfig-i0-201538
x86_64                 randconfig-b0-09211959
i386                     randconfig-n0-201538
i386                   randconfig-h0-09220926
i386                   randconfig-h1-09220926
arm                         socfpga_defconfig
blackfin                   CM-BF533_defconfig
powerpc                 linkstation_defconfig
ia64                             alldefconfig
ia64                              allnoconfig
x86_64                 randconfig-h0-09220937
x86_64                                    lkp
x86_64                                   rhel
x86_64                 randconfig-n0-09220948
x86_64                 randconfig-n0-09221022
arm                           tegra_defconfig
ia64                            sim_defconfig
arm                         orion5x_defconfig
powerpc64                         allnoconfig
i386                  randconfig-sb0-09220918
i386                   randconfig-r0-09220935
x86_64                 randconfig-r0-09220935
powerpc                      chrp32_defconfig
i386                   randconfig-x0-09220931

Thanks,
Fengguang
