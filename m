From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 22 Apr 2017 17:28:25 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 2964237651b62ccd05233bfafc5aa8efaa39ab15
Message-ID: <58fb2239.XMvsrMEAwr8SqFPb%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
2964237651b62ccd05233bfafc5aa8efaa39ab15  i40evf: hide unused variable

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2171:36: error: 'size' undeclared (first use in this function)
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2171:5: error: 'size' undeclared (first use in this function)

Error ids grouped by kconfigs:

recent_errors
??? alpha-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? frv-allyesconfig
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

TIMEOUT after 602m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs tested: 180

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
m32r                   mappi2.vdec2_defconfig
powerpc                      bamboo_defconfig
powerpc               corenet_basic_defconfig
i386                     randconfig-a0-201716
x86_64                 randconfig-a0-04221358
x86_64                             acpi-redef
x86_64       acpi-redef+CONFIG_DEBUG_INFO_REDUCED-CONFIG_DEBUG_INFO_REDUCED
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
arm                            hisi_defconfig
arm                         s3c2410_defconfig
sparc                             allnoconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-04221340
arm                            mmp2_defconfig
arm                         shannon_defconfig
h8300                       h8s-sim_defconfig
x86_64                randconfig-it0-04221303
arm                        mvebu_v7_defconfig
cris                             allyesconfig
sh                           se7780_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                 randconfig-v0-04221223
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
arm                         s3c6400_defconfig
cris                    etrax-100lx_defconfig
sh                           se7712_defconfig
x86_64                 randconfig-g0-04212257
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesdebian
x86_64                                nfsroot
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
nios2                         10m50_defconfig
score                      spct6600_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
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
i386                     randconfig-s0-201716
i386                     randconfig-s1-201716
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201716
arm                         cm_x300_defconfig
arm                          pcm027_defconfig
avr32                        merisc_defconfig
blackfin             BF527-TLL6527M_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                   randconfig-i0-04211433
i386                   randconfig-i1-04211433
x86_64                 randconfig-b0-04212207
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                           allmodconfig
blackfin                  TCM-BF518_defconfig
frv                              allyesconfig
sh                           sh2007_defconfig
x86_64                 randconfig-u0-04220600
x86_64                 randconfig-u0-04220952
arm                           sama5_defconfig
powerpc64                         allnoconfig
h8300                     edosk2674_defconfig
mips                        nlm_xlr_defconfig
x86_64                randconfig-ne0-04221209
x86_64                randconfig-ne0-04221447
arm                        keystone_defconfig
powerpc                         ps3_defconfig
tile                              allnoconfig
i386                   randconfig-x010-201716
i386                   randconfig-x011-201716
i386                   randconfig-x012-201716
i386                   randconfig-x013-201716
i386                   randconfig-x014-201716
i386                   randconfig-x015-201716
i386                   randconfig-x016-201716
i386                   randconfig-x017-201716
i386                   randconfig-x018-201716
i386                   randconfig-x019-201716
x86_64                                    lkp
x86_64                                   rhel
7.2                                      i386
randconfig-n0-04211433                             i386
randconfig-h0-04212308                             i386
randconfig-h1-04212308                         blackfin
defconfig                                ia64
defconfig                                mips
defconfig                                ia64
alldefconfig                             ia64
allnoconfig                            x86_64
randconfig-h0-04220007                             m68k
sun3_defconfig                             m68k
multi_defconfig                             m68k
m5475evb_defconfig                           x86_64
randconfig-x000-201716                           x86_64
randconfig-x001-201716                           x86_64
randconfig-x002-201716                           x86_64
randconfig-x003-201716                           x86_64
randconfig-x004-201716                           x86_64
randconfig-x005-201716                           x86_64
randconfig-x006-201716                           x86_64
randconfig-x007-201716                           x86_64
randconfig-x008-201716                           x86_64
randconfig-x009-201716                             i386
randconfig-x070-201716                             i386
randconfig-x071-201716                             i386
randconfig-x072-201716                             i386
randconfig-x074-201716                             i386
randconfig-x075-201716                             i386
randconfig-x076-201716                             i386
randconfig-x077-201716                             i386
randconfig-x078-201716                             i386
randconfig-x079-201716                             i386
alldefconfig                             i386
allnoconfig                              i386
defconfig                                i386
randconfig-r0-201716                              arm
assabet_defconfig                              arm
qcom_defconfig                             i386
randconfig-x006-201716                             i386
randconfig-x005-201716                             i386
randconfig-x002-201716                             i386
randconfig-x007-201716                             i386
randconfig-x003-201716                             i386
randconfig-x001-201716                             i386
randconfig-x008-201716                             i386
randconfig-x000-201716                             i386
randconfig-x004-201716                             i386
randconfig-x009-201716                             i386
randconfig-x0-04221329                                 

Thanks,
Fengguang
