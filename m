From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 26 Apr 2017 20:33:59 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 54ed200478b6aebb7cb16284ed7f9b9ebc585164
Message-ID: <590093b7.k/FTApfd18rnKLkc%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
54ed200478b6aebb7cb16284ed7f9b9ebc585164  ixgbe: Correct thermal sensor event check

TIMEOUT after 600m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 47

alpha                            allmodconfig
alpha                            allyesconfig
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
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
mips                             allmodconfig
mips                             allyesconfig
parisc                           allmodconfig
parisc                           allyesconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
s390                             allmodconfig
s390                             allyesconfig
score                      spct6600_defconfig
sh                               allmodconfig
sh                               allyesconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
sparc                            allmodconfig
sparc                            allyesconfig
tile                             allmodconfig
tile                             allyesconfig
x86_64                             acpi-redef
x86_64                           allyesconfig
x86_64                           allyesdebian
x86_64                                  kexec
x86_64                                    lkp
x86_64                                nfsroot
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 140

i386                     randconfig-a0-201717
i386                               tinyconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
x86_64                           allmodconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
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
x86_64                 randconfig-x012-201717
x86_64                 randconfig-x015-201717
x86_64                 randconfig-x017-201717
x86_64                 randconfig-x010-201717
x86_64                 randconfig-x018-201717
x86_64                 randconfig-x011-201717
x86_64                 randconfig-x019-201717
x86_64                 randconfig-x016-201717
x86_64                 randconfig-x014-201717
x86_64                 randconfig-x013-201717
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
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
i386                     randconfig-s0-201717
i386                     randconfig-s1-201717
i386                             allmodconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                   randconfig-i0-201717
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                     randconfig-i0-201717
i386                     randconfig-i1-201717
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
nios2                         10m50_defconfig
h8300                    h8300h-sim_defconfig
i386                   randconfig-x010-201717
i386                   randconfig-x014-201717
i386                   randconfig-x016-201717
i386                   randconfig-x017-201717
i386                   randconfig-x013-201717
i386                   randconfig-x019-201717
i386                   randconfig-x011-201717
i386                   randconfig-x015-201717
i386                   randconfig-x012-201717
i386                   randconfig-x018-201717
i386                     randconfig-n0-201717
x86_64                                   rhel
x86_64                               rhel-7.2
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
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
i386                   randconfig-x073-201717
i386                   randconfig-x077-201717
i386                   randconfig-x070-201717
i386                   randconfig-x072-201717
i386                   randconfig-x076-201717
i386                   randconfig-x074-201717
i386                   randconfig-x078-201717
i386                   randconfig-x075-201717
i386                   randconfig-x079-201717
i386                   randconfig-x071-201717
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
x86_64                 randconfig-x009-201717
x86_64                 randconfig-x004-201717
x86_64                 randconfig-x003-201717
x86_64                 randconfig-x008-201717
x86_64                 randconfig-x002-201717
x86_64                 randconfig-x005-201717
x86_64                 randconfig-x007-201717
x86_64                 randconfig-x000-201717
x86_64                 randconfig-x001-201717
x86_64                 randconfig-x006-201717
i386                     randconfig-r0-201717
i386                   randconfig-x006-201717
i386                   randconfig-x002-201717
i386                   randconfig-x005-201717
i386                   randconfig-x007-201717
i386                   randconfig-x003-201717
i386                   randconfig-x001-201717
i386                   randconfig-x008-201717
i386                   randconfig-x000-201717
i386                   randconfig-x004-201717
i386                   randconfig-x009-201717

Thanks,
Fengguang
