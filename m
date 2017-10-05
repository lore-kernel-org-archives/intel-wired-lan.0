From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 05 Oct 2017 13:08:58 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 a99c110d8cc0c2787cbfbbdc194c253082238f63
Message-ID: <59d5be6a.D2nlX/UKi1Jq2YMC%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
a99c110d8cc0c2787cbfbbdc194c253082238f63  i40e: Fix memory leak related filter programming status

ERROR: "__aeabi_uldivmod" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!
ERROR: "__udivdi3" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!

Error ids grouped by kconfigs:

recent_errors
??? arm-allmodconfig
??? ??? ERROR:__aeabi_uldivmod-drivers-net-ethernet-intel-i40e-i40e.ko-undefined
??? i386-allmodconfig
    ??? ERROR:__udivdi3-drivers-net-ethernet-intel-i40e-i40e.ko-undefined

elapsed time: 495m

configs tested: 106

x86_64                           allyesdebian
sh                                allnoconfig
sh                            titan_defconfig
x86_64                           allmodconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                              defconfig
arm                               allnoconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
frv                                 defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
x86_64                 randconfig-x018-201740
x86_64                 randconfig-x011-201740
x86_64                 randconfig-x012-201740
x86_64                 randconfig-x019-201740
x86_64                 randconfig-x013-201740
x86_64                 randconfig-x017-201740
x86_64                 randconfig-x015-201740
x86_64                 randconfig-x014-201740
x86_64                 randconfig-x016-201740
x86_64                 randconfig-x010-201740
arm                              allmodconfig
arm                                      arm5
arm                                     arm67
arm                          ixp4xx_defconfig
arm                                    sa1100
arm                                   samsung
arm                                        sh
arm64                            alldefconfig
arm64                            allmodconfig
x86_64                                   rhel
x86_64                               rhel-7.2
i386                               tinyconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                   randconfig-i0-201740
sparc64                           allnoconfig
i386                     randconfig-i0-201740
i386                     randconfig-i1-201740
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
m68k                       m5475evb_defconfig
i386                   randconfig-x000-201740
i386                   randconfig-x001-201740
i386                   randconfig-x002-201740
i386                   randconfig-x003-201740
i386                   randconfig-x004-201740
i386                   randconfig-x005-201740
i386                   randconfig-x006-201740
i386                   randconfig-x007-201740
i386                   randconfig-x008-201740
i386                   randconfig-x009-201740
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
ia64                             alldefconfig
ia64                              allnoconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
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
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
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
i386                             allmodconfig

Thanks,
Fengguang
