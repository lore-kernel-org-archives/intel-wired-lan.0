From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 22 Mar 2017 12:42:24 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 cd4854ec7c7247181c7a9400c9f4d5ae559149ec
Message-ID: <58d200b0.Ia1E465WzF6SrRbY%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
cd4854ec7c7247181c7a9400c9f4d5ae559149ec  Subject: i40e: initialize params before notifying of l2_param_changes  Colin Ian King <colin.king@canonical.com>

drivers/net/ethernet/intel/i40e/i40e_ethtool.c:3119:32-37: ERROR: invalid reference to the index variable of the iterator on line 3073

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:ERROR:invalid-reference-to-the-index-variable-of-the-iterator-on-line

elapsed time: 385m

configs tested: 148

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                     randconfig-a0-201712
x86_64                 randconfig-a0-03220905
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                               tinyconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
x86_64                                  kexec
x86_64                                   rhel
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                 randconfig-g0-03220821
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
nios2                         10m50_defconfig
h8300                    h8300h-sim_defconfig
score                      spct6600_defconfig
x86_64                 randconfig-x015-201712
x86_64                 randconfig-x012-201712
x86_64                 randconfig-x017-201712
x86_64                 randconfig-x010-201712
x86_64                 randconfig-x018-201712
x86_64                 randconfig-x011-201712
x86_64                 randconfig-x019-201712
x86_64                 randconfig-x016-201712
x86_64                 randconfig-x013-201712
x86_64                 randconfig-x014-201712
x86_64                               rhel-7.2
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
i386                     randconfig-s0-201712
i386                     randconfig-s1-201712
x86_64                 randconfig-s0-03220906
x86_64                 randconfig-s1-03220906
x86_64                 randconfig-s2-03220906
x86_64                           allmodconfig
i386                             allmodconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201712
i386                   randconfig-b0-03220905
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201712
i386                     randconfig-i1-201712
i386                   randconfig-x014-201712
i386                   randconfig-x010-201712
i386                   randconfig-x016-201712
i386                   randconfig-x017-201712
i386                   randconfig-x013-201712
i386                   randconfig-x019-201712
i386                   randconfig-x012-201712
i386                   randconfig-x015-201712
i386                   randconfig-x011-201712
i386                   randconfig-x018-201712
x86_64                randconfig-ne0-03220957
i386                     randconfig-n0-201712
i386                   randconfig-h0-03220937
i386                   randconfig-h1-03220937
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
x86_64                 randconfig-x009-201712
x86_64                 randconfig-x004-201712
x86_64                 randconfig-x003-201712
x86_64                 randconfig-x008-201712
x86_64                 randconfig-x002-201712
x86_64                 randconfig-x005-201712
x86_64                 randconfig-x000-201712
x86_64                 randconfig-x007-201712
x86_64                 randconfig-x006-201712
x86_64                 randconfig-x001-201712
i386                   randconfig-x070-201712
i386                   randconfig-x077-201712
i386                   randconfig-x073-201712
i386                   randconfig-x076-201712
i386                   randconfig-x072-201712
i386                   randconfig-x078-201712
i386                   randconfig-x074-201712
i386                   randconfig-x075-201712
i386                   randconfig-x079-201712
i386                   randconfig-x071-201712
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
i386         randconfig-r0-201712+CONFIG_DEBUG_INFO_REDUCED
i386                     randconfig-r0-201712
arm                           stm32_defconfig
cris                          dev88_defconfig
cris                    etrax-100lx_defconfig
i386                   randconfig-x005-201712
i386                   randconfig-x002-201712
i386                   randconfig-x006-201712
i386                   randconfig-x003-201712
i386                   randconfig-x007-201712
i386                   randconfig-x008-201712
i386                   randconfig-x001-201712
i386                   randconfig-x000-201712
i386                   randconfig-x004-201712
i386                   randconfig-x009-201712
i386                   randconfig-x0-03220659

Thanks,
Fengguang
