From: kbuild test robot <fengguang.wu@intel.com>
Date: Mon, 03 Aug 2015 20:12:21 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 26694a0da059f51d2c2423014227173c6c4075ae BUILD DONE
Message-ID: <55bf5aa5.i7H8z3CMfW7a4wyb%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
26694a0da059f51d2c2423014227173c6c4075ae  ixgbe: Limit lowest interrupt rate for adaptive interrupt moderation to 12K

drivers/net/ethernet/intel/i40e/i40e_debugfs.c:1499:4: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'u32' [-Wformat=]
drivers/net/ethernet/intel/igb/igb_main.c:2651:2: error: implicit declaration of function 'igb_disable_sriov' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:153:1-7: WARNING: end returns can be simpified

Error ids grouped by kconfigs:

recent_errors
??? arm-tegra_defconfig
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? frv-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u32
??? frv-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u32
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u32
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_x550.c:WARNING:end-returns-can-be-simpified
??? i386-randconfig-b0-08031818
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? i386-randconfig-x000-201531
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? ia64-defconfig
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u32
??? x86_64-acpi-redef
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? x86_64-nfsroot
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? x86_64-randconfig-a0-08031840
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? x86_64-randconfig-b0-08031739
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? x86_64-randconfig-n0-08031758
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? x86_64-randconfig-r0-08031841
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? x86_64-randconfig-x001-201531
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? x86_64-randconfig-x009-201531
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? xtensa-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u32
??? xtensa-allyesconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u32

elapsed time: 193m

configs tested: 180

mips                          lasat_defconfig
powerpc                      bamboo_defconfig
um                           x86_64_defconfig
arm                       imx_v6_v7_defconfig
avr32        atngw100mkii_evklcd100_defconfig
powerpc                    adder875_defconfig
i386                     randconfig-a0-201531
x86_64                 randconfig-a0-08031807
x86_64                 randconfig-a0-08031840
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
arm                     am200epdkit_defconfig
arm                          nuc960_defconfig
s390                    performance_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                   randconfig-c0-08031803
i386                   randconfig-c0-08031827
arm                                    sa1100
arm                          prima2_defconfig
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                                   samsung
arm                       spear13xx_defconfig
arm                                  iop-adma
arm                          marzen_defconfig
arm                                  at_hdmac
arm                                    ep93xx
arm                                        sh
arm                         s5pv210_defconfig
sh                          rsk7203_defconfig
arm                       omap2plus_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                      obs600_defconfig
x86_64                 randconfig-v0-08031815
x86_64                 randconfig-v0-08031842
x86_64                            allnoconfig
arm                            qcom_defconfig
powerpc                        icon_defconfig
powerpc                     ppa8548_defconfig
um                             i386_defconfig
x86_64                              defconfig
ia64                          tiger_defconfig
m68k                          hp300_defconfig
powerpc                     mpc512x_defconfig
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                   randconfig-i0-201531
i386                   randconfig-b0-08031818
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                        mvebu_v7_defconfig
powerpc                     sequoia_defconfig
s390                           gcov_defconfig
arm                         ebsa110_defconfig
arm                      footbridge_defconfig
m32r                       m32104ut_defconfig
xtensa                           allmodconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i1-201531
i386                     randconfig-i0-201531
x86_64                 randconfig-b0-08031739
x86_64                 randconfig-b0-08031844
x86_64                           allmodconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
frv                              allyesconfig
powerpc                    sam440ep_defconfig
sh                        edosk7705_defconfig
i386                     randconfig-n1-201531
i386                     randconfig-n0-201531
arm                                      arm5
arm                                     arm67
arm                                       mmp
arm                         s3c2410_defconfig
arm                           tegra_defconfig
i386                   randconfig-h0-08031659
i386                   randconfig-h1-08031659
i386                   randconfig-h0-08031843
i386                   randconfig-h1-08031843
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
arm                        magician_defconfig
m32r                    mappi2.opsp_defconfig
blackfin               BF518F-EZBRD_defconfig
powerpc                 mpc8315_rdb_defconfig
sh                        sh7763rdp_defconfig
x86_64                                   rhel
x86_64                 randconfig-h0-08031756
x86_64                 randconfig-h0-08031832
x86_64                                    lkp
x86_64                 randconfig-n0-08031758
x86_64                 randconfig-n0-08031834
arm                         lubbock_defconfig
powerpc                mpc8610_hpcd_defconfig
xtensa                            allnoconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
m68k                          amiga_defconfig
i386                  randconfig-sb0-08031806
i386                  randconfig-sb0-08031847
arm                           acs5k_defconfig
powerpc                      cm5200_defconfig
powerpc                      ppc40x_defconfig
blackfin                BF527-EZKIT_defconfig
mips                        nlm_xlp_defconfig
x86_64                 randconfig-x001-201531
x86_64                 randconfig-x004-201531
x86_64                 randconfig-x000-201531
x86_64                 randconfig-x006-201531
x86_64                 randconfig-x003-201531
x86_64                 randconfig-x009-201531
x86_64                 randconfig-x005-201531
x86_64                 randconfig-x002-201531
x86_64                 randconfig-x008-201531
x86_64                 randconfig-x007-201531
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
i386                     randconfig-r0-201531
x86_64                 randconfig-r0-08031810
x86_64                 randconfig-r0-08031841
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
arm                        shmobile_defconfig
arm                        spear3xx_defconfig
powerpc                     redwood_defconfig
arm                          pxa168_defconfig
arm64                               defconfig
powerpc                       maple_defconfig
x86_64                 randconfig-s0-08031810
x86_64                 randconfig-s0-08031845
i386                              allnoconfig
i386                                defconfig
i386                             allmodconfig
i386                             alldefconfig
arm                         mv78xx0_defconfig
m68k                           sun3_defconfig
mips                        workpad_defconfig
microblaze                          defconfig
powerpc                      acadia_defconfig
sh                          sdk7786_defconfig
i386                   randconfig-x000-201531
i386                   randconfig-x004-201531
i386                   randconfig-x001-201531
i386                   randconfig-x008-201531
i386                   randconfig-x005-201531
i386                   randconfig-x003-201531
i386                   randconfig-x007-201531
i386                   randconfig-x002-201531
i386                   randconfig-x006-201531
i386                   randconfig-x009-201531
i386                   randconfig-x0-08031754
i386                   randconfig-x0-08031839

Thanks,
Fengguang
