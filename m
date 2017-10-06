From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 07 Oct 2017 00:42:32 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 6cf4b8ea1d0a2d450a99aa859668fccc7022c7a5
Message-ID: <59d7b278.jocMLywtefk+o/1z%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
6cf4b8ea1d0a2d450a99aa859668fccc7022c7a5  i40e: convert i40e_set_link_ksettings to new API

ERROR: "__aeabi_uldivmod" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!
ERROR: "__udivdi3" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!

Error ids grouped by kconfigs:

recent_errors
??? arm-allmodconfig
??? ??? ERROR:__aeabi_uldivmod-drivers-net-ethernet-intel-i40e-i40e.ko-undefined
??? i386-allmodconfig
    ??? ERROR:__udivdi3-drivers-net-ethernet-intel-i40e-i40e.ko-undefined

elapsed time: 150m

configs tested: 180

alpha                            allyesconfig
sh                ecovec24-romimage_defconfig
xtensa                              defconfig
x86_64                 randconfig-a0-10062225
mn10300                          allmodconfig
sh                          r7780mp_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
arm                            netx_defconfig
cris                        etraxfs_defconfig
powerpc                       eiger_defconfig
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
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201740
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                 randconfig-v0-10062339
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
arm                            mmp2_defconfig
arm                         socfpga_defconfig
powerpc                      obs600_defconfig
x86_64                 randconfig-g0-10062249
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                             allmodconfig
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
i386                     randconfig-a0-201740
i386                     randconfig-a1-201740
x86_64                           allmodconfig
i386                               tinyconfig
arm                          nuc950_defconfig
mips                        nlm_xlp_defconfig
mips                      pic32mzda_defconfig
x86_64                   randconfig-i0-201740
i386                   randconfig-b0-10062337
i386                     randconfig-i1-201740
i386                     randconfig-i0-201740
x86_64                 randconfig-b0-10062312
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
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
arm                       multi_v4t_defconfig
powerpc                     tqm5200_defconfig
sh                        apsh4ad0a_defconfig
x86_64                 randconfig-u0-10062327
blackfin                BF537-STAMP_defconfig
sh                               allyesconfig
x86_64                randconfig-ne0-10062321
arm                       netwinder_defconfig
powerpc                    mvme5100_defconfig
powerpc                      ppc40x_defconfig
sparc                             allnoconfig
i386                   randconfig-h0-10062248
i386                   randconfig-h1-10062248
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
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
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
arm                           corgi_defconfig
c6x                        evmc6472_defconfig
x86_64                randconfig-ws0-10062309
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
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
mips                          ath25_defconfig
mips                        xilfpga_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9

Thanks,
Fengguang
