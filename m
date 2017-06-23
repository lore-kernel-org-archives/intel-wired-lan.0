From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 23 Jun 2017 16:28:38 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 4fab0a0958d8da870bb86becb515c132c69b78ef
Message-ID: <594cd136.iR+fTpR3zj+7UG1c%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
4fab0a0958d8da870bb86becb515c132c69b78ef  e1000e: add check on e1e_wphy() return value

TIMEOUT after 604m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 54

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
mips                             allmodconfig
mips                             allyesconfig
parisc                           allmodconfig
parisc                           allyesconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
s390                             allmodconfig
s390                             allyesconfig
sh                               allmodconfig
sh                                allnoconfig
sh                               allyesconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
sparc                            allmodconfig
sparc                            allyesconfig
tile                             allmodconfig
tile                             allyesconfig
x86_64                           allyesconfig
x86_64                                    lkp
x86_64                        randconfig-x000
x86_64                        randconfig-x001
x86_64                        randconfig-x002
x86_64                        randconfig-x003
x86_64                        randconfig-x004
x86_64                        randconfig-x005
x86_64                        randconfig-x006
x86_64                        randconfig-x007
x86_64                        randconfig-x008
x86_64                        randconfig-x009
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 131

x86_64                           allmodconfig
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
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
i386                   randconfig-a0-06162344
i386                   randconfig-a1-06162344
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
x86_64                 randconfig-x010-201725
x86_64                 randconfig-x019-201725
x86_64                 randconfig-x015-201725
x86_64                 randconfig-x014-201725
x86_64                 randconfig-x012-201725
x86_64                 randconfig-x017-201725
x86_64                 randconfig-x018-201725
x86_64                 randconfig-x016-201725
x86_64                 randconfig-x013-201725
x86_64                 randconfig-x011-201725
i386                     randconfig-s0-201725
i386                     randconfig-s1-201725
i386                             allmodconfig
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                   randconfig-i0-201725
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201725
i386                     randconfig-i1-201725
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                               tinyconfig
i386                 randconfig-x011-06190614
i386                 randconfig-x017-06190614
i386                 randconfig-x012-06190614
i386                 randconfig-x016-06190614
i386                 randconfig-x018-06190614
i386                 randconfig-x014-06190614
i386                 randconfig-x019-06190614
i386                 randconfig-x015-06190614
i386                 randconfig-x010-06190614
i386                 randconfig-x013-06190614
i386                   randconfig-n0-06230650
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
frv                                 defconfig
tile                         tilegx_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
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
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
score                      spct6600_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
nios2                         10m50_defconfig
h8300                    h8300h-sim_defconfig
i386                 randconfig-x070-06180431
i386                 randconfig-x074-06180431
i386                 randconfig-x073-06180431
i386                 randconfig-x076-06180431
i386                 randconfig-x071-06180431
i386                 randconfig-x072-06180431
i386                 randconfig-x078-06180431
i386                 randconfig-x077-06180431
i386                 randconfig-x075-06180431
i386                 randconfig-x079-06180431
i386                   randconfig-x009-201725
i386                   randconfig-x006-201725
i386                   randconfig-x008-201725
i386                   randconfig-x002-201725
i386                   randconfig-x001-201725
i386                   randconfig-x000-201725
i386                   randconfig-x005-201725
i386                   randconfig-x007-201725
i386                   randconfig-x004-201725
i386                   randconfig-x003-201725
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9

Thanks,
Fengguang
