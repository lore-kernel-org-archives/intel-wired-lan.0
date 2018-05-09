From: kbuild test robot <lkp@intel.com>
Date: Wed, 09 May 2018 23:29:46 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:100GbE] BUILD SUCCESS
 c7ddd5212b525fc8ed3efb5b60ebd6a9dd849787
Message-ID: <5af313ea.IXYvsKUpWZDpiFOf%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  100GbE
branch HEAD: c7ddd5212b525fc8ed3efb5b60ebd6a9dd849787  fm10k: don't protect fm10k_queue_mac_request by fm10k_host_mbx_ready

elapsed time: 88m

configs tested: 143

The following configs have been built successfully.
More configs may be tested in the coming days.

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64                 randconfig-a0-05092138
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-05091914
c6x                        evmc6457_defconfig
m68k                            mac_defconfig
x86_64                randconfig-it0-05091510
i386                               tinyconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201818
x86_64                 randconfig-x002-201818
x86_64                 randconfig-x006-201818
x86_64                 randconfig-x005-201818
x86_64                 randconfig-x001-201818
x86_64                 randconfig-x009-201818
x86_64                 randconfig-x004-201818
x86_64                 randconfig-x003-201818
x86_64                 randconfig-x007-201818
x86_64                 randconfig-x000-201818
x86_64                 randconfig-x008-201818
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
i386                     randconfig-i0-201818
i386                     randconfig-i1-201818
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
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                             allmodconfig
i386                     randconfig-a0-201818
i386                     randconfig-a1-201818
x86_64                 randconfig-s0-05092139
x86_64                 randconfig-s1-05092139
x86_64                 randconfig-s2-05092139
x86_64                 randconfig-s0-05092251
x86_64                 randconfig-s1-05092251
x86_64                 randconfig-s2-05092251
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                 randconfig-x010-201818
x86_64                 randconfig-x014-201818
x86_64                 randconfig-x013-201818
x86_64                 randconfig-x011-201818
x86_64                 randconfig-x015-201818
x86_64                 randconfig-x019-201818
x86_64                 randconfig-x016-201818
x86_64                 randconfig-x018-201818
x86_64                 randconfig-x012-201818
x86_64                 randconfig-x017-201818
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
x86_64                              federa-25
x86_64                                   rhel
x86_64                               rhel-7.2
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201818
i386                     randconfig-s1-201818
x86_64                           allmodconfig
x86_64                 randconfig-s3-05092205
x86_64                 randconfig-s4-05092205
x86_64                 randconfig-s5-05092205
x86_64                 randconfig-s3-05092243
x86_64                 randconfig-s4-05092243
x86_64                 randconfig-s5-05092243
x86_64                   randconfig-i0-201818
i386                   randconfig-b0-05091957
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                 randconfig-u0-05092146
x86_64                randconfig-ne0-05092228
x86_64                 randconfig-h0-05092138
i386                   randconfig-x008-201818
i386                   randconfig-x006-201818
i386                   randconfig-x000-201818
i386                   randconfig-x004-201818
i386                   randconfig-x009-201818
i386                   randconfig-x003-201818
i386                   randconfig-x001-201818
i386                   randconfig-x002-201818
i386                   randconfig-x005-201818
i386                   randconfig-x007-201818
i386                   randconfig-x013-201818
i386                   randconfig-x014-201818
i386                   randconfig-x019-201818
i386                   randconfig-x016-201818
i386                   randconfig-x015-201818
i386                   randconfig-x012-201818
i386                   randconfig-x018-201818
i386                   randconfig-x010-201818
i386                   randconfig-x011-201818
i386                   randconfig-x017-201818
i386                   randconfig-x073-201818
i386                   randconfig-x075-201818
i386                   randconfig-x079-201818
i386                   randconfig-x071-201818
i386                   randconfig-x076-201818
i386                   randconfig-x074-201818
i386                   randconfig-x078-201818
i386                   randconfig-x077-201818
i386                   randconfig-x070-201818
i386                   randconfig-x072-201818
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
m68k                        mvme16x_defconfig
sh                         apsh4a3a_defconfig
x86_64                 randconfig-r0-05091646

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
