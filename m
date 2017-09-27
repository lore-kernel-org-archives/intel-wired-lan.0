From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 28 Sep 2017 07:02:58 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 f054642c69087d746ce3c658cb4925f181a2cf0b
Message-ID: <59cc2e22.VF1iWdUm9QjrEBeo%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
f054642c69087d746ce3c658cb4925f181a2cf0b  i40e: fix a typo

ERROR: "__udivdi3" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
    ??? ERROR:__udivdi3-drivers-net-ethernet-intel-i40e-i40e.ko-undefined

elapsed time: 150m

configs tested: 161

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64                 randconfig-a0-09280604
blackfin                   CM-BF527_defconfig
ia64                            zx1_defconfig
sh                          rsk7201_defconfig
i386                   randconfig-n0-09250914
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
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                             allmodconfig
x86_64                 randconfig-x011-201739
x86_64                 randconfig-x016-201739
x86_64                 randconfig-x018-201739
x86_64                 randconfig-x013-201739
x86_64                 randconfig-x019-201739
x86_64                 randconfig-x014-201739
x86_64                 randconfig-x012-201739
x86_64                 randconfig-x015-201739
x86_64                 randconfig-x017-201739
x86_64                 randconfig-x010-201739
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
i386                   randconfig-a1-09250859
i386                   randconfig-a0-09250859
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
arm                        magician_defconfig
m32r                             allmodconfig
m32r                                defconfig
mips                           ip28_defconfig
x86_64                                   rhel
x86_64                               rhel-7.2
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s1-201739
i386                     randconfig-s0-201739
arm                          simpad_defconfig
mips                      bmips_stb_defconfig
sh                          rsk7269_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201739
i386                   randconfig-b0-09280548
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i1-201739
i386                     randconfig-i0-201739
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
x86_64                 randconfig-u0-09280540
m32r                              allnoconfig
s390                              allnoconfig
sh                     magicpanelr2_defconfig
i386                   randconfig-x013-201739
i386                   randconfig-x019-201739
i386                   randconfig-x018-201739
i386                   randconfig-x016-201739
i386                   randconfig-x012-201739
i386                   randconfig-x015-201739
i386                   randconfig-x011-201739
i386                   randconfig-x010-201739
i386                   randconfig-x017-201739
i386                   randconfig-x014-201739
x86_64                 randconfig-h0-09280621
i386                   randconfig-x070-201739
i386                   randconfig-x071-201739
i386                   randconfig-x072-201739
i386                   randconfig-x073-201739
i386                   randconfig-x074-201739
i386                   randconfig-x075-201739
i386                   randconfig-x076-201739
i386                   randconfig-x077-201739
i386                   randconfig-x078-201739
i386                   randconfig-x079-201739
sh                                allnoconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-x000-201739
i386                   randconfig-x003-201739
i386                   randconfig-x009-201739
i386                   randconfig-x004-201739
i386                   randconfig-x008-201739
i386                   randconfig-x001-201739
i386                   randconfig-x005-201739
i386                   randconfig-x002-201739
i386                   randconfig-x006-201739
i386                   randconfig-x007-201739
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                 randconfig-x000-201739
x86_64                 randconfig-x007-201739
x86_64                 randconfig-x001-201739
x86_64                 randconfig-x006-201739
x86_64                 randconfig-x004-201739
x86_64                 randconfig-x009-201739
x86_64                 randconfig-x003-201739
x86_64                 randconfig-x002-201739
x86_64                 randconfig-x005-201739
x86_64                 randconfig-x008-201739
x86_64                                  kexec
x86_64                randconfig-ws0-09280615
i386                 randconfig-x077-09280331
i386                 randconfig-x078-09280331
i386                 randconfig-x073-09280331
i386                 randconfig-x075-09280331
i386                 randconfig-x079-09280331
i386                 randconfig-x072-09280331
i386                 randconfig-x074-09280331
i386                 randconfig-x076-09280331
i386                 randconfig-x071-09280331
i386                 randconfig-x070-09280331
x86_64                 randconfig-r0-09280616
m68k                         amcore_defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
i386                   randconfig-x0-09280555

Thanks,
Fengguang
