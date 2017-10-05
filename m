From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 06 Oct 2017 02:41:00 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 974f1e236fb3165edc8fb1774dfffe3a6e04d37f
Message-ID: <59d67cbc.JnZcDrLXeqqIgfUi%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
974f1e236fb3165edc8fb1774dfffe3a6e04d37f  i40e: Fix memory leak related filter programming status

ERROR: "__aeabi_uldivmod" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!
ERROR: "__udivdi3" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!

Error ids grouped by kconfigs:

recent_errors
??? arm-allmodconfig
??? ??? ERROR:__aeabi_uldivmod-drivers-net-ethernet-intel-i40e-i40e.ko-undefined
??? i386-allmodconfig
    ??? ERROR:__udivdi3-drivers-net-ethernet-intel-i40e-i40e.ko-undefined

elapsed time: 125m

configs tested: 171

x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-10052314
arm                           tegra_defconfig
microblaze                    nommu_defconfig
mips                        workpad_defconfig
i386                              allnoconfig
arm                          ixp4xx_defconfig
mips                        bcm63xx_defconfig
i386                     randconfig-n0-201740
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
powerpc                  mpc866_ads_defconfig
sh                      rts7751r2d1_defconfig
xtensa                           allmodconfig
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64                 randconfig-g0-10060117
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                             allmodconfig
arm                              allmodconfig
arm                                      arm5
arm                                     arm67
arm                       imx_v6_v7_defconfig
arm                        mvebu_v7_defconfig
arm                       omap2plus_defconfig
arm                                    sa1100
arm                                   samsung
arm                                        sh
arm64                            alldefconfig
arm64                            allmodconfig
i386                     randconfig-a0-201740
i386                     randconfig-a1-201740
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
mips                     loongson1c_defconfig
powerpc64                           defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                   randconfig-s0-10032350
i386                   randconfig-s1-10032350
x86_64                 randconfig-s3-10060114
x86_64                 randconfig-s4-10060114
x86_64                 randconfig-s5-10060114
mips                        msp71xx_defconfig
powerpc                 canyonlands_defconfig
powerpc                     mpc5200_defconfig
xtensa                           alldefconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                   randconfig-i0-201740
i386                   randconfig-b0-10060140
m32r                    mappi.nommu_defconfig
m68k                       m5208evb_defconfig
sh                           se7780_defconfig
microblaze                      mmu_defconfig
i386                     randconfig-i1-201740
i386                     randconfig-i0-201740
x86_64                 randconfig-b0-10060128
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                            hisi_defconfig
sparc64                          allmodconfig
xtensa                              defconfig
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
powerpc                    sam440ep_defconfig
s390                           gcov_defconfig
blackfin             BF527-EZKIT-V2_defconfig
cris                              allnoconfig
microblaze                          defconfig
ia64                            zx1_defconfig
mips                  maltasmvp_eva_defconfig
x86_64                 randconfig-h0-10060134
x86_64                 randconfig-n0-10060112
x86_64                           allmodconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
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
mips                             allmodconfig
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
arm                          pxa3xx_defconfig
sh                           se7619_defconfig
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
i386                                defconfig
i386                             alldefconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9

Thanks,
Fengguang
