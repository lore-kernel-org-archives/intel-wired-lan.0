From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 28 Jun 2017 13:37:54 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 c8e535dfc418c2f2f3e03a4b38af6dd3397293af
Message-ID: <595340b2.bws4ZDk7O73wuOOP%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
c8e535dfc418c2f2f3e03a4b38af6dd3397293af  igb: Fix error of RX network flow classification

drivers/net/ethernet/intel/i40e/i40e_debugfs.c:160:28: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'u64 {aka long long unsigned int}' [-Wformat=]
drivers/net/ethernet/intel/i40e/i40e_debugfs.c:161:4: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'u64 {aka long long unsigned int}' [-Wformat=]

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? powerpc-defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? powerpc-ppc64_defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? x86_64-rhel
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? x86_64-rhel-7.2
    ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int

elapsed time: 355m

configs tested: 111

blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
i386                               tinyconfig
mn10300                          alldefconfig
sh                     magicpanelr2_defconfig
sh                      rts7751r2d1_defconfig
i386                   randconfig-c0-06281234
m68k                           sun3_defconfig
powerpc64                         allnoconfig
xtensa                generic_kc705_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
x86_64                 randconfig-s0-06281257
x86_64                 randconfig-s1-06281257
x86_64                 randconfig-s2-06281257
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
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
i386                             allmodconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                 randconfig-i0-06260516
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                           allmodconfig
mips                    maltaup_xpa_defconfig
powerpc                     mpc83xx_defconfig
s390                    performance_defconfig
x86_64                 randconfig-u0-06281241
x86_64                randconfig-ne0-06281245
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64                 randconfig-h0-06281133
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
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                  randconfig-sb0-06281231
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                                  kexec
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

Thanks,
Fengguang
