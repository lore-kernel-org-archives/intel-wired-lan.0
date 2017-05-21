From: kbuild test robot <fengguang.wu@intel.com>
Date: Sun, 21 May 2017 11:08:20 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 6c76cd8d8a7a6dc38bb19f29294982ab0fb6be16
Message-ID: <592104a4.tvLAWNc1yjhrZre/%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
6c76cd8d8a7a6dc38bb19f29294982ab0fb6be16  ixgbe: fix incorrect status check

TIMEOUT after 2510m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 141

alpha                            allmodconfig
alpha                            allyesconfig
alpha                               defconfig
arm64                             allnoconfig
arm64                               defconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
blackfin                         allmodconfig
blackfin                         allyesconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
c6x                        evmc6678_defconfig
cris                             allmodconfig
cris                             allyesconfig
cris                 etrax-100lx_v2_defconfig
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
frv                                 defconfig
h8300                    h8300h-sim_defconfig
i386                             alldefconfig
i386                             allmodconfig
i386                              allnoconfig
i386                                defconfig
i386                            randconfig-a0
i386                            randconfig-i0
i386                            randconfig-i1
i386                            randconfig-n0
i386                            randconfig-r0
i386                            randconfig-s0
i386                            randconfig-s1
i386                          randconfig-x000
i386                          randconfig-x001
i386                          randconfig-x002
i386                          randconfig-x003
i386                          randconfig-x004
i386                          randconfig-x005
i386                          randconfig-x006
i386                          randconfig-x007
i386                          randconfig-x008
i386                          randconfig-x009
i386                          randconfig-x010
i386                          randconfig-x011
i386                          randconfig-x012
i386                          randconfig-x013
i386                          randconfig-x014
i386                          randconfig-x015
i386                          randconfig-x016
i386                          randconfig-x017
i386                          randconfig-x018
i386                          randconfig-x019
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
mn10300                     asb2364_defconfig
nios2                         10m50_defconfig
openrisc                    or1ksim_defconfig
parisc                           allmodconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                             allmodconfig
s390                             allyesconfig
s390                        default_defconfig
score                      spct6600_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                               allyesconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
sparc                            allmodconfig
sparc                            allyesconfig
sparc                               defconfig
tile                             allmodconfig
tile                             allyesconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                             acpi-redef
x86_64                           allmodconfig
x86_64                           allyesconfig
x86_64                           allyesdebian
x86_64                                  kexec
x86_64                                    lkp
x86_64                                nfsroot
x86_64                          randconfig-i0
x86_64                                   rhel
x86_64                               rhel-7.2
xtensa                           allmodconfig
xtensa                           allyesconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig

configs tested: 31

i386                               tinyconfig
x86_64                 randconfig-x019-201720
x86_64                 randconfig-x010-201720
x86_64                 randconfig-x015-201720
x86_64                 randconfig-x014-201720
x86_64                 randconfig-x012-201720
x86_64                 randconfig-x018-201720
x86_64                 randconfig-x017-201720
x86_64                 randconfig-x016-201720
x86_64                 randconfig-x013-201720
x86_64                 randconfig-x011-201720
x86_64                 randconfig-x006-201720
x86_64                 randconfig-x007-201720
x86_64                 randconfig-x001-201720
x86_64                 randconfig-x004-201720
x86_64                 randconfig-x005-201720
x86_64                 randconfig-x000-201720
x86_64                 randconfig-x008-201720
x86_64                 randconfig-x002-201720
x86_64                 randconfig-x003-201720
x86_64                 randconfig-x009-201720
i386                 randconfig-x074-05150639
i386                 randconfig-x076-05150639
i386                 randconfig-x070-05150639
i386                 randconfig-x077-05150639
i386                 randconfig-x078-05150639
i386                 randconfig-x075-05150639
i386                 randconfig-x072-05150639
i386                 randconfig-x071-05150639
i386                 randconfig-x079-05150639
i386                 randconfig-x073-05150639

Thanks,
Fengguang
