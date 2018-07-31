From: kbuild test robot <lkp@intel.com>
Date: Wed, 01 Aug 2018 00:16:12 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD SUCCESS
 0fd17e183fc37531b60eb5e01203b3ab4a470886
Message-ID: <5b608b4c.sliMrTUWzdw04zt4%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 0fd17e183fc37531b60eb5e01203b3ab4a470886  igb_sw_init() is never called in atomic context. It calls kzalloc() and kcalloc() with GFP_ATOMIC, which is not necessary. GFP_ATOMIC can be replaced with GFP_KERNEL.

elapsed time: 39m

configs tested: 98

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                             pxa_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                  colibri_pxa300_defconfig
arm                        magician_defconfig
i386                   randconfig-x018-201830
i386                   randconfig-x017-201830
i386                   randconfig-x010-201830
i386                   randconfig-x016-201830
i386                   randconfig-x013-201830
i386                   randconfig-x011-201830
i386                   randconfig-x015-201830
i386                   randconfig-x019-201830
i386                   randconfig-x012-201830
i386                   randconfig-x014-201830
i386                   randconfig-n0-07310844
x86_64                 randconfig-x000-201830
x86_64                 randconfig-x009-201830
x86_64                 randconfig-x004-201830
x86_64                 randconfig-x001-201830
x86_64                 randconfig-x003-201830
x86_64                 randconfig-x007-201830
x86_64                 randconfig-x008-201830
x86_64                 randconfig-x005-201830
x86_64                 randconfig-x002-201830
x86_64                 randconfig-x006-201830
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                   randconfig-a0-07310851
i386                   randconfig-a1-07310851
x86_64                 randconfig-s0-07312321
x86_64                 randconfig-s1-07312321
x86_64                 randconfig-s2-07312321
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
arm                            dove_defconfig
arm                         ebsa110_defconfig
powerpc                         ps3_defconfig
powerpc                    sam440ep_defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                   randconfig-s0-07310852
i386                   randconfig-s1-07310852
x86_64                 randconfig-s3-07312332
x86_64                 randconfig-s4-07312332
x86_64                 randconfig-s5-07312332
i386                               tinyconfig
x86_64                 randconfig-x019-201830
x86_64                 randconfig-x013-201830
x86_64                 randconfig-x017-201830
x86_64                 randconfig-x018-201830
x86_64                 randconfig-x012-201830
x86_64                 randconfig-x010-201830
x86_64                 randconfig-x014-201830
x86_64                 randconfig-x016-201830
x86_64                 randconfig-x011-201830
x86_64                 randconfig-x015-201830
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                   randconfig-x077-201830
i386                   randconfig-x070-201830
i386                   randconfig-x076-201830
i386                   randconfig-x075-201830
i386                   randconfig-x072-201830
i386                   randconfig-x074-201830
i386                   randconfig-x078-201830
i386                   randconfig-x071-201830
i386                   randconfig-x073-201830
i386                   randconfig-x079-201830
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
i386                   randconfig-x002-201830
i386                   randconfig-x005-201830
i386                   randconfig-x003-201830
i386                   randconfig-x008-201830
i386                   randconfig-x000-201830
i386                   randconfig-x007-201830
i386                   randconfig-x001-201830
i386                   randconfig-x004-201830
i386                   randconfig-x009-201830
i386                   randconfig-x006-201830

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
