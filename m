From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 12 Jul 2017 17:16:38 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 fba7ac1c2ab15f03f3f95355b8e6d15b42922fa3
Message-ID: <5965e8f6.8KohQeTewvFEuC99%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
fba7ac1c2ab15f03f3f95355b8e6d15b42922fa3  ixgbe: Clear SWFW_SYNC register during init

drivers/net/ethernet/intel/i40e/i40e_debugfs.c:161:4: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'u64 {aka long long unsigned int}' [-Wformat=]

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? ia64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? x86_64-rhel
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? x86_64-rhel-7.2
    ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int

TIMEOUT after 603m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 101

alpha                            allmodconfig
alpha                            allyesconfig
arm64                          customconfig-0
arm64                          customconfig-1
arm64                          customconfig-2
arm                            customconfig-0
arm                            customconfig-1
arm                            customconfig-2
blackfin                         allmodconfig
blackfin                         allyesconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                             allmodconfig
cris                             allyesconfig
cris                 etrax-100lx_v2_defconfig
i386                           customconfig-0
i386                           customconfig-1
i386                           customconfig-2
i386                            randconfig-a0
i386                            randconfig-a1
i386                            randconfig-i0
i386                            randconfig-i1
i386                            randconfig-n0
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
i386                          randconfig-x070
i386                          randconfig-x071
i386                          randconfig-x072
i386                          randconfig-x073
i386                          randconfig-x074
i386                          randconfig-x075
i386                          randconfig-x076
i386                          randconfig-x077
i386                          randconfig-x078
i386                          randconfig-x079
ia64                             allmodconfig
ia64                             allyesconfig
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
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                             allmodconfig
s390                             allyesconfig
s390                        default_defconfig
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
x86_64                             acpi-redef
x86_64                           allmodconfig
x86_64                           allyesconfig
x86_64                           allyesdebian
x86_64                         customconfig-0
x86_64                         customconfig-1
x86_64                         customconfig-2
x86_64                                  kexec
x86_64                                    lkp
x86_64                                nfsroot
x86_64                          randconfig-i0
x86_64                        randconfig-x010
x86_64                        randconfig-x011
x86_64                        randconfig-x012
x86_64                        randconfig-x013
x86_64                        randconfig-x014
x86_64                        randconfig-x015
x86_64                        randconfig-x016
x86_64                        randconfig-x017
x86_64                        randconfig-x018
x86_64                        randconfig-x019
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 73

parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
i386                               tinyconfig
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
x86_64                                   rhel
x86_64                               rhel-7.2
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                   randconfig-x012-201728
i386                   randconfig-x018-201728
i386                   randconfig-x016-201728
i386                   randconfig-x017-201728
i386                   randconfig-x013-201728
i386                   randconfig-x010-201728
i386                   randconfig-x019-201728
i386                   randconfig-x014-201728
i386                   randconfig-x015-201728
i386                   randconfig-x011-201728
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
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
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
frv                                 defconfig
tile                         tilegx_defconfig
x86_64                 randconfig-x006-201728
x86_64                 randconfig-x004-201728
x86_64                 randconfig-x005-201728
x86_64                 randconfig-x007-201728
x86_64                 randconfig-x001-201728
x86_64                 randconfig-x008-201728
x86_64                 randconfig-x002-201728
x86_64                 randconfig-x000-201728
x86_64                 randconfig-x009-201728
x86_64                 randconfig-x003-201728
i386                             allmodconfig
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
