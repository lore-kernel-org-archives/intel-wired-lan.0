From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 04 Feb 2016 19:19:20 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 3414fa0b881883c29af690c383f9941bf6aa0b51 BUILD DONE
Message-ID: <56b333b8.jE361/5kyKb6OfCg%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
3414fa0b881883c29af690c383f9941bf6aa0b51  ixgbe: Use udelay to avoid sleeping while atomic

drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c:417:170: error: call to '__compiletime_assert_417' declared with attribute error: BUILD_BUG_ON failed: idx != FM10K_REGS_LEN_VSI

Error ids grouped by kconfigs:

recent_errors
??? i386-allyesconfig
    ??? drivers-net-ethernet-intel-fm10k-fm10k_ethtool.c:error:call-to-__compiletime_assert_NNN-declared-with-attribute-error:BUILD_BUG_ON-failed:idx-FM10K_REGS_LEN_VSI

elapsed time: 495m

configs tested: 153

parisc                        c3000_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
i386                   randconfig-a0-02040645
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
i386                               tinyconfig
arm                           efm32_defconfig
arm                         s3c2410_defconfig
frv                               allnoconfig
arm                          imote2_defconfig
powerpc                 linkstation_defconfig
um                               alldefconfig
i386                   randconfig-c0-02041716
arm                              allmodconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm                        mvebu_v7_defconfig
arm                           stm32_defconfig
blackfin             BF527-EZKIT-V2_defconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
i386                             allyesconfig
x86_64                 randconfig-v0-02041549
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
arm                         lpc32xx_defconfig
arm                       omap2plus_defconfig
parisc                           alldefconfig
arm                         assabet_defconfig
arm                          iop32x_defconfig
mips                      pic32mzda_defconfig
sh                          sdk7780_defconfig
x86_64               randconfig-x011-02041016
x86_64               randconfig-x012-02041016
x86_64               randconfig-x016-02041016
x86_64               randconfig-x010-02041016
x86_64               randconfig-x018-02041016
x86_64               randconfig-x013-02041016
x86_64               randconfig-x019-02041016
x86_64               randconfig-x014-02041016
x86_64               randconfig-x015-02041016
x86_64               randconfig-x017-02041016
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
i386                   randconfig-s1-02041016
i386                   randconfig-s0-02041016
x86_64                 randconfig-s0-02041708
x86_64                 randconfig-s1-02041708
x86_64                 randconfig-s2-02041708
x86_64                           allmodconfig
x86_64                 randconfig-s3-02041718
x86_64                 randconfig-s4-02041718
x86_64                 randconfig-s5-02041718
i386                             allmodconfig
m68k                              allnoconfig
powerpc                     redwood_defconfig
sh                   secureedge5410_defconfig
xtensa                              defconfig
x86_64                 randconfig-i0-02040645
i386                   randconfig-i0-02040654
i386                   randconfig-i1-02040654
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                      acs5k_tiny_defconfig
arm                        mvebu_v5_defconfig
mips                          malta_defconfig
arm                                      arm5
arm                                     arm67
arm                       imx_v6_v7_defconfig
arm                          ixp4xx_defconfig
arm                                    sa1100
arm                                   samsung
arm                                        sh
arm                           tegra_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                   randconfig-n0-02040646
i386                   randconfig-h0-02041610
i386                   randconfig-h1-02041610
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
x86_64                                   rhel
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
sh                          sdk7786_defconfig
sh                        sh7763rdp_defconfig
powerpc                  iss476-smp_defconfig
powerpc               mpc85xx_basic_defconfig
mips                   sb1250_swarm_defconfig
powerpc                       eiger_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                  randconfig-sb0-02041630
x86_64               randconfig-x000-02040645
x86_64               randconfig-x001-02040645
x86_64               randconfig-x002-02040646
x86_64               randconfig-x003-02040646
x86_64               randconfig-x004-02040646
x86_64               randconfig-x005-02040646
x86_64               randconfig-x006-02040646
x86_64               randconfig-x007-02040646
x86_64               randconfig-x008-02040646
x86_64               randconfig-x009-02040646
i386                   randconfig-r0-02040646
avr32                     atstk1004_defconfig
powerpc                    sam440ep_defconfig
powerpc64                        allmodconfig
i386                 randconfig-x008-02040645
i386                 randconfig-x009-02040645
i386                 randconfig-x000-02040645
i386                 randconfig-x006-02040645
i386                 randconfig-x002-02040645
i386                 randconfig-x007-02040645
i386                 randconfig-x005-02040645
i386                 randconfig-x001-02040645
i386                 randconfig-x004-02040645
i386                 randconfig-x003-02040645
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9

Thanks,
Fengguang
