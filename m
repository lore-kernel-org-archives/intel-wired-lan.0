From: kbuild test robot <fengguang.wu@intel.com>
Date: Sun, 08 Jan 2017 18:23:41 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 9411d80b16a0693f4e3557cdfeddb61dac150dc3
Message-ID: <5872132d.s86NKn/NxFw/NkiY%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
9411d80b16a0693f4e3557cdfeddb61dac150dc3  igb: Revert "igb: Revert support for build_skb in igb"

drivers/net/ethernet/intel/igb/igb_main.c:6999:7: error: invalid operands to binary - (have 'unsigned char *' and 'void *')

Error ids grouped by kconfigs:

recent_errors
??? i386-randconfig-x007-201702
    ??? drivers-net-ethernet-intel-igb-igb_main.c:error:invalid-operands-to-binary-(have-unsigned-char-and-void-)

elapsed time: 68m

configs tested: 124

i386                     randconfig-a0-201702
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
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
x86_64                 randconfig-x011-201702
x86_64                 randconfig-x014-201702
x86_64                 randconfig-x017-201702
x86_64                 randconfig-x016-201702
x86_64                 randconfig-x012-201702
x86_64                 randconfig-x010-201702
x86_64                 randconfig-x013-201702
x86_64                 randconfig-x019-201702
x86_64                 randconfig-x018-201702
x86_64                 randconfig-x015-201702
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201702
i386                     randconfig-s1-201702
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                   randconfig-i0-201702
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                   randconfig-i0-01081531
i386                   randconfig-i1-01081531
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                           allmodconfig
i386                               tinyconfig
i386                   randconfig-x011-201702
i386                   randconfig-x018-201702
i386                   randconfig-x015-201702
i386                   randconfig-x012-201702
i386                   randconfig-x017-201702
i386                   randconfig-x013-201702
i386                   randconfig-x014-201702
i386                   randconfig-x019-201702
i386                   randconfig-x010-201702
i386                   randconfig-x016-201702
i386                     randconfig-n0-201702
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
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
x86_64                 randconfig-x008-201702
x86_64                 randconfig-x001-201702
x86_64                 randconfig-x009-201702
x86_64                 randconfig-x003-201702
x86_64                 randconfig-x000-201702
x86_64                 randconfig-x006-201702
x86_64                 randconfig-x002-201702
x86_64                 randconfig-x007-201702
x86_64                 randconfig-x004-201702
x86_64                 randconfig-x005-201702
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
i386                     randconfig-r0-201702
i386                             allmodconfig
i386                   randconfig-x004-201702
i386                   randconfig-x003-201702
i386                   randconfig-x007-201702
i386                   randconfig-x001-201702
i386                   randconfig-x006-201702
i386                   randconfig-x009-201702
i386                   randconfig-x008-201702
i386                   randconfig-x002-201702
i386                   randconfig-x005-201702
i386                   randconfig-x000-201702
i386                              allnoconfig
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
