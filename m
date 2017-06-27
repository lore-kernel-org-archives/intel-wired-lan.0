From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 27 Jun 2017 16:24:52 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 ea3e0e4ac54c250449123f82d5d35f5fb53cec9e
Message-ID: <59521654.OJ3zQcnPfhgPCVcH%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
ea3e0e4ac54c250449123f82d5d35f5fb53cec9e  igb: Fix error of RX network flow classification

drivers/net/ethernet/intel/i40e/i40e_debugfs.c:160:28: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'u64 {aka long long unsigned int}' [-Wformat=]
drivers/net/ethernet/intel/i40e/i40e_debugfs.c:161:4: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'u64 {aka long long unsigned int}' [-Wformat=]

Error ids grouped by kconfigs:

recent_errors
??? arm64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? arm64-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? arm-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? frv-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? ia64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? powerpc-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? powerpc-defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? powerpc-ppc64_defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? x86_64-randconfig-ne0-06271311
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? x86_64-rhel
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? x86_64-rhel-7.2
    ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int

elapsed time: 505m

configs tested: 155

sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                               tinyconfig
i386                   randconfig-c0-06271514
x86_64                randconfig-in0-06271113
x86_64                 randconfig-v0-06271504
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
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
powerpc                          allyesconfig
x86_64                 randconfig-g0-06271506
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
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
i386                             allmodconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
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
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
i386                   randconfig-a0-06262357
i386                   randconfig-a1-06262357
x86_64                 randconfig-s0-06271514
x86_64                 randconfig-s1-06271514
x86_64                 randconfig-s2-06271514
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
frv                                 defconfig
tile                         tilegx_defconfig
frv                              allyesconfig
mips                           jazz_defconfig
mips                         mpc30x_defconfig
x86_64                 randconfig-x010-201726
x86_64                 randconfig-x019-201726
x86_64                 randconfig-x015-201726
x86_64                 randconfig-x012-201726
x86_64                 randconfig-x014-201726
x86_64                 randconfig-x016-201726
x86_64                 randconfig-x018-201726
x86_64                 randconfig-x017-201726
x86_64                 randconfig-x013-201726
x86_64                 randconfig-x011-201726
x86_64                 randconfig-s3-06271548
x86_64                 randconfig-s4-06271548
x86_64                 randconfig-s5-06271548
arm                            hisi_defconfig
arm                           sama5_defconfig
powerpc               corenet_basic_defconfig
sh                     magicpanelr2_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                 randconfig-i0-06260516
i386                   randconfig-b0-06271428
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                            pleb_defconfig
mips                      maltasmvp_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                   randconfig-i1-06252058
i386                   randconfig-i0-06252058
x86_64                 randconfig-b0-06271453
x86_64                           allmodconfig
arm64                            allyesconfig
powerpc                    socrates_defconfig
um                                  defconfig
x86_64                 randconfig-u0-06271459
arm                        vexpress_defconfig
arm                            zeus_defconfig
ia64                        generic_defconfig
x86_64                randconfig-ne0-06271311
i386                 randconfig-x012-06270719
i386                 randconfig-x018-06270719
i386                 randconfig-x014-06270719
i386                 randconfig-x016-06270719
i386                 randconfig-x017-06270719
i386                 randconfig-x010-06270719
i386                 randconfig-x015-06270719
i386                 randconfig-x011-06270719
i386                 randconfig-x013-06270719
i386                 randconfig-x019-06270719
i386                  randconfig-sb0-06271221
i386                 randconfig-x072-06262345
i386                 randconfig-x074-06262345
i386                 randconfig-x071-06262345
i386                 randconfig-x078-06262345
i386                 randconfig-x075-06262345
i386                 randconfig-x079-06262345
i386                 randconfig-x077-06262345
i386                 randconfig-x076-06262345
i386                 randconfig-x073-06262345
i386                 randconfig-x070-06262345
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
i386                   randconfig-x0-06271302

Thanks,
Fengguang
