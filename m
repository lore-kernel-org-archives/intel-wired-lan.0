From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 28 Jun 2017 03:09:40 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:10GbE] BUILD INCOMPLETE
 7d2cf1a622c77ba6d52ae4d3ed693092667064b7
Message-ID: <5952ad74.vO647PXQJEjQ2h1/%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  10GbE
7d2cf1a622c77ba6d52ae4d3ed693092667064b7  ixgbe: Add malicious driver detection support

TIMEOUT after 607m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 63

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
i386                            randconfig-n0
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
mips                             allmodconfig
mips                             allyesconfig
parisc                           allmodconfig
parisc                           allyesconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
s390                             allmodconfig
s390                             allyesconfig
sh                               allyesconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
sparc                            allmodconfig
sparc                            allyesconfig
tile                             allmodconfig
tile                             allyesconfig
x86_64                             acpi-redef
x86_64                           allmodconfig
x86_64                           allyesconfig
x86_64                           allyesdebian
x86_64                                  kexec
x86_64                                    lkp
x86_64                                nfsroot
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
x86_64                                   rhel
x86_64                               rhel-7.2
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 109

i386                 randconfig-x016-06250006
i386                 randconfig-x011-06250006
i386                 randconfig-x012-06250006
i386                 randconfig-x013-06250006
i386                 randconfig-x010-06250006
i386                 randconfig-x019-06250006
i386                 randconfig-x015-06250006
i386                 randconfig-x014-06250006
i386                 randconfig-x017-06250006
i386                 randconfig-x018-06250006
sh                               allmodconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
i386                   randconfig-a0-06262357
i386                   randconfig-a1-06262357
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
x86_64                 randconfig-x010-201726
x86_64                 randconfig-x019-201726
x86_64                 randconfig-x015-201726
x86_64                 randconfig-x012-201726
x86_64                 randconfig-x014-201726
x86_64                 randconfig-x016-201726
x86_64                 randconfig-x018-201726
x86_64                 randconfig-x017-201726
x86_64                 randconfig-x013-201726
x86_64                 randconfig-x011-201726
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
i386                   randconfig-s0-06262349
i386                   randconfig-s1-06262349
i386                             allmodconfig
x86_64                 randconfig-i0-06260516
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                   randconfig-i1-06252058
i386                   randconfig-i0-06252058
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
i386                               tinyconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
frv                                 defconfig
tile                         tilegx_defconfig
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
i386                 randconfig-x072-06262345
i386                 randconfig-x074-06262345
i386                 randconfig-x071-06262345
i386                 randconfig-x078-06262345
i386                 randconfig-x075-06262345
i386                 randconfig-x079-06262345
i386                 randconfig-x077-06262345
i386                 randconfig-x076-06262345
i386                 randconfig-x073-06262345
i386                 randconfig-x070-06262345
i386                 randconfig-x002-06251247
i386                 randconfig-x005-06251247
i386                 randconfig-x006-06251247
i386                 randconfig-x008-06251247
i386                 randconfig-x007-06251247
i386                 randconfig-x000-06251247
i386                 randconfig-x003-06251247
i386                 randconfig-x009-06251247
i386                 randconfig-x001-06251247
i386                 randconfig-x004-06251247
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9

Thanks,
Fengguang
