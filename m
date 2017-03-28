From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 28 Mar 2017 18:32:28 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 945bf0239e8b38390aefb51addeec01d7be9f51b
Message-ID: <58da3bbc.Jp5DoZTdg9q2zRCO%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
945bf0239e8b38390aefb51addeec01d7be9f51b  i40e: fix for queue timing delays

drivers/net/ethernet/intel/i40e/i40e_ethtool.c:3125:32-37: ERROR: invalid reference to the index variable of the iterator on line 3079
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2171:36: error: 'size' undeclared (first use in this function)
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2171:5: error: 'size' undeclared (first use in this function)

Error ids grouped by kconfigs:

recent_errors
??? alpha-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:ERROR:invalid-reference-to-the-index-variable-of-the-iterator-on-line
??? ia64-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? ia64-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? sparc64-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? sparc64-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? sparc-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? sparc-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? tile-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? tile-allyesconfig
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)

elapsed time: 124m

configs tested: 176

arm                          moxart_defconfig
mips                                defconfig
powerpc                  mpc885_ads_defconfig
i386                     randconfig-a0-201713
x86_64                 randconfig-a0-03281632
arm                        cerfcube_defconfig
m68k                          atari_defconfig
mips                       rbtx49xx_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
arm                           viper_defconfig
h8300                    h8300h-sim_defconfig
powerpc                 mpc836x_mds_defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
mips                          rm200_defconfig
powerpc                         wii_defconfig
xtensa                  cadence_csp_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                 randconfig-g0-03281636
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
m32r                    m32700ut.up_defconfig
mips                      maltasmvp_defconfig
powerpc64                           defconfig
s390                             allmodconfig
sh                        sh7785lcr_defconfig
x86_64                 randconfig-x015-201713
x86_64                 randconfig-x012-201713
x86_64                 randconfig-x017-201713
x86_64                 randconfig-x010-201713
x86_64                 randconfig-x018-201713
x86_64                 randconfig-x011-201713
x86_64                 randconfig-x019-201713
x86_64                 randconfig-x016-201713
x86_64                 randconfig-x014-201713
x86_64                 randconfig-x013-201713
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201713
i386                     randconfig-s1-201713
x86_64                 randconfig-s0-03281712
x86_64                 randconfig-s1-03281712
x86_64                 randconfig-s2-03281712
x86_64                 randconfig-s3-03281714
x86_64                 randconfig-s4-03281714
x86_64                 randconfig-s5-03281714
i386                             allmodconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201713
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                 randconfig-b0-03281327
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                           allmodconfig
c6x                        evmc6678_defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
nios2                         10m50_defconfig
score                      spct6600_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
m32r                             allyesconfig
sh                        sh7763rdp_defconfig
x86_64                 randconfig-u0-03281329
arm                          ep93xx_defconfig
x86_64                randconfig-ne0-03281707
i386                               tinyconfig
arm                           h3600_defconfig
c6x                         dsk6455_defconfig
cris                             alldefconfig
powerpc                      ppc64e_defconfig
i386                   randconfig-x014-201713
i386                   randconfig-x010-201713
i386                   randconfig-x016-201713
i386                   randconfig-x017-201713
i386                   randconfig-x013-201713
i386                   randconfig-x019-201713
i386                   randconfig-x015-201713
i386                   randconfig-x012-201713
i386                   randconfig-x011-201713
i386                   randconfig-x018-201713
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
arm                       versatile_defconfig
blackfin                   CM-BF533_defconfig
sparc64                          allyesconfig
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
m68k                         apollo_defconfig
x86_64                 randconfig-n0-03281601
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
powerpc                      ppc6xx_defconfig
s390                             alldefconfig
x86_64                randconfig-ws0-03281634
i386                   randconfig-x077-201713
i386                   randconfig-x070-201713
i386                   randconfig-x073-201713
i386                   randconfig-x076-201713
i386                   randconfig-x072-201713
i386                   randconfig-x078-201713
i386                   randconfig-x074-201713
i386                   randconfig-x075-201713
i386                   randconfig-x079-201713
i386                   randconfig-x071-201713
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                                  kexec
ia64                        generic_defconfig
x86_64                 randconfig-x009-201713
x86_64                 randconfig-x004-201713
x86_64                 randconfig-x003-201713
x86_64                 randconfig-x008-201713
x86_64                 randconfig-x002-201713
x86_64                 randconfig-x005-201713
x86_64                 randconfig-x007-201713
x86_64                 randconfig-x000-201713
x86_64                 randconfig-x006-201713
x86_64                 randconfig-x001-201713
i386                     randconfig-r0-201713
i386                   randconfig-x002-201713
i386                   randconfig-x005-201713
i386                   randconfig-x006-201713
i386                   randconfig-x003-201713
i386                   randconfig-x007-201713
i386                   randconfig-x008-201713
i386                   randconfig-x001-201713
i386                   randconfig-x000-201713
i386                   randconfig-x004-201713
i386                   randconfig-x009-201713
i386                   randconfig-x0-03281347

Thanks,
Fengguang
