From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 18 Oct 2017 00:32:48 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 ff312d579ad51d0c77f507bf972327332a64fa9d
Message-ID: <59e630b0.sUreOWj9sUNFPlp0%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: ff312d579ad51d0c77f507bf972327332a64fa9d  ethernet/intel: Convert timers to use timer_setup()

Regressions in current branch:

ERROR: "__aeabi_uldivmod" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!
ERROR: "__udivdi3" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!

Error ids grouped by kconfigs:

recent_errors
??? arm-allmodconfig
??? ??? ERROR:__aeabi_uldivmod-drivers-net-ethernet-intel-i40e-i40e.ko-undefined
??? i386-allmodconfig
    ??? ERROR:__udivdi3-drivers-net-ethernet-intel-i40e-i40e.ko-undefined

elapsed time: 82m

configs tested: 145

sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-x015-201742
i386                   randconfig-x013-201742
i386                   randconfig-x014-201742
i386                   randconfig-x019-201742
i386                   randconfig-x011-201742
i386                   randconfig-x018-201742
i386                   randconfig-x010-201742
i386                   randconfig-x012-201742
i386                   randconfig-x017-201742
i386                   randconfig-x016-201742
i386                   randconfig-n0-10171314
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
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
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
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
arm                              allmodconfig
arm                                      arm5
arm                                     arm67
arm                       imx_v6_v7_defconfig
arm                          ixp4xx_defconfig
arm                        mvebu_v7_defconfig
arm                       omap2plus_defconfig
arm                                    sa1100
arm                                   samsung
arm                                        sh
arm                           tegra_defconfig
arm64                            alldefconfig
arm64                            allmodconfig
i386                     randconfig-a0-201742
i386                     randconfig-a1-201742
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                 randconfig-x018-201742
x86_64                 randconfig-x011-201742
x86_64                 randconfig-x012-201742
x86_64                 randconfig-x013-201742
x86_64                 randconfig-x019-201742
x86_64                 randconfig-x017-201742
x86_64                 randconfig-x014-201742
x86_64                 randconfig-x015-201742
x86_64                 randconfig-x016-201742
x86_64                 randconfig-x010-201742
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
i386                     randconfig-s0-201742
i386                     randconfig-s1-201742
i386                               tinyconfig
i386                             allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                   randconfig-i0-201742
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                     randconfig-i1-201742
i386                     randconfig-i0-201742
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
x86_64                           allmodconfig
i386                   randconfig-x001-201742
i386                   randconfig-x008-201742
i386                   randconfig-x002-201742
i386                   randconfig-x004-201742
i386                   randconfig-x003-201742
i386                   randconfig-x006-201742
i386                   randconfig-x007-201742
i386                   randconfig-x009-201742
i386                   randconfig-x005-201742
i386                   randconfig-x000-201742
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
i386                   randconfig-x074-201742
i386                   randconfig-x077-201742
i386                   randconfig-x071-201742
i386                   randconfig-x076-201742
i386                   randconfig-x073-201742
i386                   randconfig-x079-201742
i386                   randconfig-x078-201742
i386                   randconfig-x072-201742
i386                   randconfig-x070-201742
i386                   randconfig-x075-201742
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                 randconfig-x001-201742
x86_64                 randconfig-x000-201742
x86_64                 randconfig-x004-201742
x86_64                 randconfig-x008-201742
x86_64                 randconfig-x007-201742
x86_64                 randconfig-x006-201742
x86_64                 randconfig-x005-201742
x86_64                 randconfig-x009-201742
x86_64                 randconfig-x003-201742
x86_64                 randconfig-x002-201742
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9

Thanks,
Fengguang
