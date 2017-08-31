From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 31 Aug 2017 08:53:05 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 b908ea672f07f89d265f7785fd4f8368fa114a13
Message-ID: <59a75df1.x5GnOtgxDJ88aVE0%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
b908ea672f07f89d265f7785fd4f8368fa114a13  i40e/i40evf: use DECLARE_BITMAP for state

drivers/net/ethernet/intel/i40e/i40e_debugfs.c:280:29: warning: format '%li' expects argument of type 'long int', but argument 4 has type 'long unsigned int *' [-Wformat=]
drivers/net/ethernet/intel/i40e/i40e_debugfs.c:281:5: warning: format '%li' expects argument of type 'long int', but argument 4 has type 'long unsigned int *' [-Wformat=]

Error ids grouped by kconfigs:

recent_errors
??? arm64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-li-expects-argument-of-type-long-int-but-argument-has-type-long-unsigned-int
??? arm64-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-li-expects-argument-of-type-long-int-but-argument-has-type-long-unsigned-int
??? arm-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-li-expects-argument-of-type-long-int-but-argument-has-type-long-unsigned-int
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-li-expects-argument-of-type-long-int-but-argument-has-type-long-unsigned-int
??? ia64-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-li-expects-argument-of-type-long-int-but-argument-has-type-long-unsigned-int
??? powerpc-defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-li-expects-argument-of-type-long-int-but-argument-has-type-long-unsigned-int
??? powerpc-ppc64_defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-li-expects-argument-of-type-long-int-but-argument-has-type-long-unsigned-int
??? x86_64-allmodconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-li-expects-argument-of-type-long-int-but-argument-has-type-long-unsigned-int

elapsed time: 141m

configs tested: 172

x86_64                 randconfig-a0-08310543
i386                   randconfig-c0-08310622
x86_64                randconfig-in0-08310654
arm                        trizeps4_defconfig
m32r                           usrv_defconfig
m68k                           sun3_defconfig
x86_64                randconfig-it0-08310522
i386                               tinyconfig
i386                   randconfig-x019-201735
i386                   randconfig-x013-201735
i386                   randconfig-x012-201735
i386                   randconfig-x016-201735
i386                   randconfig-x018-201735
i386                   randconfig-x010-201735
i386                   randconfig-x011-201735
i386                   randconfig-x015-201735
i386                   randconfig-x014-201735
i386                   randconfig-x017-201735
i386                     randconfig-n0-201735
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                             allmodconfig
x86_64                 randconfig-x016-201735
x86_64                 randconfig-x011-201735
x86_64                 randconfig-x012-201735
x86_64                 randconfig-x019-201735
x86_64                 randconfig-x014-201735
x86_64                 randconfig-x018-201735
x86_64                 randconfig-x013-201735
x86_64                 randconfig-x015-201735
x86_64                 randconfig-x010-201735
x86_64                 randconfig-x017-201735
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
i386                     randconfig-a0-201735
i386                     randconfig-a1-201735
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
arm                       versatile_defconfig
m68k                             allyesconfig
powerpc                     ep8248e_defconfig
um                             i386_defconfig
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
i386                     randconfig-s1-201735
i386                     randconfig-s0-201735
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                           x86_64_defconfig
arm                             ezx_defconfig
arm                         lpc18xx_defconfig
m32r                             allmodconfig
sh                                allnoconfig
x86_64                   randconfig-i0-201735
i386                   randconfig-b0-08310653
arm                         s3c2410_defconfig
blackfin                BF538-EZKIT_defconfig
mips                           jazz_defconfig
x86_64                 randconfig-b0-08310543
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                       mainstone_defconfig
cris                              allnoconfig
powerpc                    socrates_defconfig
x86_64                 randconfig-u0-08310638
sh                ecovec24-romimage_defconfig
arm                           sama5_defconfig
powerpc                     tqm5200_defconfig
xtensa                       common_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
alpha                            allmodconfig
m32r                   m32700ut.smp_defconfig
sh                             shx3_defconfig
x86_64                 randconfig-h0-08310643
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                  randconfig-sb0-08310531
x86_64                           allmodconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
nios2                         10m50_defconfig
score                      spct6600_defconfig
xtensa                          iss_defconfig
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
arm                         hackkit_defconfig
arm                      integrator_defconfig
sh                          r7780mp_defconfig
x86_64                randconfig-ws0-08310523
powerpc                     mpc5200_defconfig
powerpc                 mpc837x_rdb_defconfig
x86_64                randconfig-ws0-08310541
i386                   randconfig-x076-201735
i386                   randconfig-x075-201735
i386                   randconfig-x071-201735
i386                   randconfig-x070-201735
i386                   randconfig-x074-201735
i386                   randconfig-x079-201735
i386                   randconfig-x072-201735
i386                   randconfig-x073-201735
i386                   randconfig-x078-201735
i386                   randconfig-x077-201735
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
arm64                            allyesconfig
powerpc                       ebony_defconfig
arm                         socfpga_defconfig
i386                   randconfig-x000-201735
i386                   randconfig-x001-201735
i386                   randconfig-x002-201735
i386                   randconfig-x003-201735
i386                   randconfig-x004-201735
i386                   randconfig-x005-201735
i386                   randconfig-x006-201735
i386                   randconfig-x007-201735
i386                   randconfig-x008-201735
i386                   randconfig-x009-201735
i386                   randconfig-x0-08310713

Thanks,
Fengguang
