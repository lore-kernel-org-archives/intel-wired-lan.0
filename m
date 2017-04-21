From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 21 Apr 2017 17:45:33 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 e35fe0f8a39e9ec756635af278eb9eda6d1dd0d2
Message-ID: <58f9d4bd.2TW2BMEHVrktKgn5%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
e35fe0f8a39e9ec756635af278eb9eda6d1dd0d2  i40evf: hide unused variable

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2171:36: error: 'size' undeclared (first use in this function)
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2171:5: error: 'size' undeclared (first use in this function)

Error ids grouped by kconfigs:

recent_errors
??? alpha-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
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

TIMEOUT after 604m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 40

alpha                            allmodconfig
blackfin                         allmodconfig
blackfin                         allyesconfig
cris                             allmodconfig
cris                             allyesconfig
customconfig                                0
customconfig                                1
customconfig                                2
customconfig                                3
customconfig                                4
customconfig                                5
customconfig                                6
customconfig                                7
customconfig                                8
customconfig                                9
i386                               tinyconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
mips                             allmodconfig
mips                             allyesconfig
parisc                           allmodconfig
parisc                           allyesconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
s390                             allmodconfig
s390                             allyesconfig
sh                               allmodconfig
sh                               allyesconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
sparc                            allmodconfig
sparc                            allyesconfig
tile                             allmodconfig
tile                             allyesconfig
x86_64                           allyesconfig
x86_64                                    lkp
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 205

blackfin                BF526-EZBRD_defconfig
cris                          dev88_defconfig
mn10300                          allmodconfig
i386                     randconfig-a0-201716
x86_64                 randconfig-a0-04211236
x86_64                 randconfig-a0-04211546
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
avr32                       favr-32_defconfig
m68k                            mac_defconfig
nios2                         10m50_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-04211243
i386                   randconfig-c0-04211606
x86_64                randconfig-in0-04211413
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
blackfin                            defconfig
ia64                                defconfig
mips                                defconfig
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                             allmodconfig
arm                         cm_x300_defconfig
avr32                             allnoconfig
avr32                     atstk1002_defconfig
openrisc                         allmodconfig
powerpc                 mpc85xx_cds_defconfig
x86_64                 randconfig-x012-201716
x86_64                 randconfig-x015-201716
x86_64                 randconfig-x017-201716
x86_64                 randconfig-x010-201716
x86_64                 randconfig-x018-201716
x86_64                 randconfig-x011-201716
x86_64                 randconfig-x019-201716
x86_64                 randconfig-x016-201716
x86_64                 randconfig-x013-201716
x86_64                 randconfig-x014-201716
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
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
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201716
i386                     randconfig-s1-201716
x86_64                 randconfig-s0-04211550
x86_64                 randconfig-s1-04211550
x86_64                 randconfig-s2-04211550
x86_64                           allmodconfig
x86_64                 randconfig-s3-04211157
x86_64                 randconfig-s4-04211157
x86_64                 randconfig-s5-04211157
x86_64                 randconfig-s3-04211554
x86_64                 randconfig-s4-04211554
x86_64                 randconfig-s5-04211554
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
mips                     decstation_defconfig
powerpc                      pmac32_defconfig
sh                      rts7751r2d1_defconfig
sh                   sh7770_generic_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201716
i386                   randconfig-b0-04211208
i386                   randconfig-b0-04211601
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                     randconfig-i0-201716
i386                     randconfig-i1-201716
arm                      acs5k_tiny_defconfig
arm                          iop33x_defconfig
blackfin                BF527-EZKIT_defconfig
x86_64                 randconfig-u0-04211608
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
score                      spct6600_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
avr32                    hammerhead_defconfig
mips                  mips_paravirt_defconfig
x86_64                randconfig-ne0-04211622
i386                   randconfig-x010-201716
i386                   randconfig-x014-201716
i386                   randconfig-x016-201716
i386                   randconfig-x017-201716
i386                   randconfig-x013-201716
i386                   randconfig-x019-201716
i386                   randconfig-x011-201716
i386                   randconfig-x012-201716
i386                   randconfig-x015-201716
i386                   randconfig-x018-201716
i386                     randconfig-n0-201716
i386                   randconfig-h0-04211249
i386                   randconfig-h1-04211249
blackfin                   CM-BF548_defconfig
parisc                generic-64bit_defconfig
ia64                             alldefconfig
ia64                              allnoconfig
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64                 randconfig-h0-04211538
arm                          lpd270_defconfig
mips                           ip28_defconfig
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
powerpc                  iss476-smp_defconfig
sh                        apsh4ad0a_defconfig
xtensa                  nommu_kc705_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                                  kexec
alpha                            allyesconfig
mips                         bigsur_defconfig
powerpc                 mpc837x_rdb_defconfig
x86_64                randconfig-ws0-04211542
cris                              allnoconfig
mips                       lemote2f_defconfig
sh                ecovec24-romimage_defconfig
x86_64                randconfig-ws0-04211412
i386                   randconfig-x073-201716
i386                   randconfig-x070-201716
i386                   randconfig-x077-201716
i386                   randconfig-x072-201716
i386                   randconfig-x076-201716
i386                   randconfig-x074-201716
i386                   randconfig-x078-201716
i386                   randconfig-x075-201716
i386                   randconfig-x079-201716
i386                   randconfig-x071-201716
m32r                                defconfig
mips                          ath79_defconfig
mips                           ip32_defconfig
x86_64                 randconfig-x009-201716
x86_64                 randconfig-x004-201716
x86_64                 randconfig-x003-201716
x86_64                 randconfig-x008-201716
x86_64                 randconfig-x002-201716
x86_64                 randconfig-x005-201716
x86_64                 randconfig-x000-201716
x86_64                 randconfig-x007-201716
x86_64                 randconfig-x001-201716
x86_64                 randconfig-x006-201716
i386                     randconfig-r0-201716
i386                   randconfig-x006-201716
i386                   randconfig-x005-201716
i386                   randconfig-x002-201716
i386                   randconfig-x007-201716
i386                   randconfig-x003-201716
i386                   randconfig-x001-201716
i386                   randconfig-x008-201716
i386                   randconfig-x000-201716
i386                   randconfig-x004-201716
i386                   randconfig-x009-201716

Thanks,
Fengguang
