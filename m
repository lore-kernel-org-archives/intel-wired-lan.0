From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 05 Oct 2017 15:01:37 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 80fa5f29e881d77e3a7a0c5f6ff8d76f3ec08ca7
Message-ID: <59d5d8d1.Kd1pFmvrAUbSj73H%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
80fa5f29e881d77e3a7a0c5f6ff8d76f3ec08ca7  ixgbe: fix crash when injecting AER after failed reset

ERROR: "__udivdi3" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
    ??? ERROR:__udivdi3-drivers-net-ethernet-intel-i40e-i40e.ko-undefined

elapsed time: 632m

configs tested: 80

i386                               tinyconfig
i386                   randconfig-x013-201740
i386                   randconfig-x014-201740
i386                   randconfig-x015-201740
i386                   randconfig-x019-201740
i386                   randconfig-x011-201740
i386                   randconfig-x018-201740
i386                   randconfig-x010-201740
i386                   randconfig-x017-201740
i386                   randconfig-x012-201740
i386                   randconfig-x016-201740
x86_64                 randconfig-x001-201740
x86_64                 randconfig-x000-201740
x86_64                 randconfig-x004-201740
x86_64                 randconfig-x008-201740
x86_64                 randconfig-x006-201740
x86_64                 randconfig-x007-201740
x86_64                 randconfig-x005-201740
x86_64                 randconfig-x009-201740
x86_64                 randconfig-x003-201740
x86_64                 randconfig-x002-201740
arm                               allnoconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
i386                             allmodconfig
ia64                             alldefconfig
ia64                              allnoconfig
i386                     randconfig-a0-201740
x86_64                           allyesdebian
parisc                            allnoconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
x86_64                                   rhel
x86_64                               rhel-7.2
m68k                       m5475evb_defconfig
x86_64                           allmodconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
sh                                allnoconfig
sh                            titan_defconfig
i386                   randconfig-x001-201740
i386                   randconfig-x008-201740
i386                   randconfig-x004-201740
i386                   randconfig-x003-201740
i386                   randconfig-x002-201740
i386                   randconfig-x006-201740
i386                   randconfig-x007-201740
i386                   randconfig-x009-201740
i386                   randconfig-x000-201740
i386                   randconfig-x005-201740
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
sparc64                           allnoconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
xtensa                       common_defconfig
i386                   randconfig-x074-201740
i386                   randconfig-x071-201740
i386                   randconfig-x076-201740
i386                   randconfig-x077-201740
i386                   randconfig-x073-201740
i386                   randconfig-x079-201740
i386                   randconfig-x072-201740
i386                   randconfig-x078-201740
i386                   randconfig-x075-201740
i386                   randconfig-x070-201740
tile                         tilegx_defconfig

Thanks,
Fengguang
