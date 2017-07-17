From: kbuild test robot <fengguang.wu@intel.com>
Date: Mon, 17 Jul 2017 23:39:12 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 3877e478d6f9bf4da407060eb1ebaac7358e734d
Message-ID: <596cda20.IuCLxB3H+Jo3K1IO%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
3877e478d6f9bf4da407060eb1ebaac7358e734d  i40e: force VMDQ device name truncation

drivers/net/ethernet/intel/i40e/i40e_debugfs.c:160:28: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'u64 {aka long long unsigned int}' [-Wformat=]
drivers/net/ethernet/intel/i40e/i40e_debugfs.c:161:4: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'u64 {aka long long unsigned int}' [-Wformat=]
drivers/net/ethernet/intel/i40e/i40e_nvm.c:781:3-9: preceding lock on line 760

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? ??? drivers-net-ethernet-intel-i40e-i40e_nvm.c:preceding-lock-on-line
??? ia64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? powerpc-defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? powerpc-ppc64_defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? x86_64-rhel
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? x86_64-rhel-7.2
    ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int

elapsed time: 523m

configs tested: 132

parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
i386                               tinyconfig
i386                   randconfig-n0-07170916
x86_64                 randconfig-x006-201729
x86_64                 randconfig-x004-201729
x86_64                 randconfig-x005-201729
x86_64                 randconfig-x007-201729
x86_64                 randconfig-x001-201729
x86_64                 randconfig-x008-201729
x86_64                 randconfig-x002-201729
x86_64                 randconfig-x000-201729
x86_64                 randconfig-x009-201729
x86_64                 randconfig-x003-201729
x86_64                 randconfig-x019-201729
x86_64                 randconfig-x010-201729
x86_64                 randconfig-x015-201729
x86_64                 randconfig-x017-201729
x86_64                 randconfig-x018-201729
x86_64                 randconfig-x016-201729
x86_64                 randconfig-x014-201729
x86_64                 randconfig-x012-201729
x86_64                 randconfig-x011-201729
x86_64                 randconfig-x013-201729
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
i386                     randconfig-a1-201729
i386                     randconfig-a0-201729
i386                     randconfig-s0-201729
i386                     randconfig-s1-201729
x86_64                           allmodconfig
x86_64                   randconfig-i0-201729
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                   randconfig-i1-07170525
i386                   randconfig-i0-07170525
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
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                   randconfig-x012-201729
i386                   randconfig-x018-201729
i386                   randconfig-x016-201729
i386                   randconfig-x017-201729
i386                   randconfig-x013-201729
i386                   randconfig-x010-201729
i386                   randconfig-x019-201729
i386                   randconfig-x014-201729
i386                   randconfig-x015-201729
i386                   randconfig-x011-201729
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
i386                 randconfig-x076-07162059
i386                 randconfig-x077-07162059
i386                 randconfig-x072-07162059
i386                 randconfig-x073-07162059
i386                 randconfig-x075-07162059
i386                 randconfig-x074-07162059
i386                 randconfig-x078-07162059
i386                 randconfig-x079-07162059
i386                 randconfig-x070-07162059
i386                 randconfig-x071-07162059
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
frv                                 defconfig
tile                         tilegx_defconfig
i386                             allmodconfig
i386                   randconfig-x002-201729
i386                   randconfig-x009-201729
i386                   randconfig-x006-201729
i386                   randconfig-x008-201729
i386                   randconfig-x005-201729
i386                   randconfig-x001-201729
i386                   randconfig-x000-201729
i386                   randconfig-x004-201729
i386                   randconfig-x007-201729
i386                   randconfig-x003-201729
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9

Thanks,
Fengguang
