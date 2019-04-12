From: kbuild test robot <lkp@intel.com>
Date: Fri, 12 Apr 2019 10:49:19 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 9ef69d5afcb18e176c4e62dafce62bc81460dcd1
Message-ID: <5caffcaf.SiGVjf5Kwd+/wyoF%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 9ef69d5afcb18e176c4e62dafce62bc81460dcd1  net: Add a define for LLDP ethertype

Regressions in current branch:

drivers/net/ethernet/intel/i40e/i40e_main.c:14842:2-8: ERROR: missing iounmap; ioremap on line 14700 and execution via conditional on line 14841
ERROR: "__aeabi_uldivmod" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
ERROR: "__udivdi3" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!

Error ids grouped by kconfigs:

recent_errors
??? arm-allmodconfig
??? ??? ERROR:__aeabi_uldivmod-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:ERROR:missing-iounmap-ioremap-on-line-and-execution-via-conditional-on-line
??? ??? ERROR:__udivdi3-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? i386-randconfig-i1-201914
??? ??? ERROR:__udivdi3-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? mips-allmodconfig
??? ??? ERROR:__udivdi3-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? x86_64-allyesconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:ERROR:missing-iounmap-ioremap-on-line-and-execution-via-conditional-on-line

elapsed time: 273m

configs tested: 198

arm                         iop13xx_defconfig
sh                          rsk7264_defconfig
arm                     eseries_pxa_defconfig
riscv                               defconfig
i386                   randconfig-x010-201914
i386                   randconfig-x018-201914
i386                   randconfig-x017-201914
i386                   randconfig-x013-201914
i386                   randconfig-x011-201914
i386                   randconfig-x014-201914
i386                   randconfig-x019-201914
i386                   randconfig-x015-201914
i386                   randconfig-x016-201914
i386                   randconfig-x012-201914
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n2-201914
i386                     randconfig-n3-201914
i386                     randconfig-n0-201914
i386                     randconfig-n1-201914
x86_64                 randconfig-x001-201914
x86_64                 randconfig-x004-201914
x86_64                 randconfig-x000-201914
x86_64                 randconfig-x003-201914
x86_64                 randconfig-x008-201914
x86_64                 randconfig-x007-201914
x86_64                 randconfig-x002-201914
x86_64                 randconfig-x006-201914
x86_64                 randconfig-x009-201914
x86_64                 randconfig-x005-201914
nds32                             allnoconfig
nds32                               defconfig
i386                     randconfig-i0-201914
i386                     randconfig-i1-201914
i386                     randconfig-i2-201914
i386                     randconfig-i3-201914
i386                   randconfig-x002-201914
i386                   randconfig-x001-201914
i386                   randconfig-x005-201914
i386                   randconfig-x007-201914
i386                   randconfig-x000-201914
i386                   randconfig-x004-201914
i386                   randconfig-x008-201914
i386                   randconfig-x009-201914
i386                   randconfig-x006-201914
i386                   randconfig-x003-201914
x86_64                 randconfig-x015-201914
x86_64                 randconfig-x016-201914
x86_64                 randconfig-x012-201914
x86_64                 randconfig-x017-201914
x86_64                 randconfig-x013-201914
x86_64                 randconfig-x018-201914
x86_64                 randconfig-x010-201914
x86_64                 randconfig-x014-201914
x86_64                 randconfig-x019-201914
x86_64                 randconfig-x011-201914
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
i386                     randconfig-a1-201914
i386                     randconfig-a2-201914
i386                     randconfig-a0-201914
i386                     randconfig-a3-201914
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
x86_64                           allyesconfig
i386                             allmodconfig
mips                          malta_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                       ebony_defconfig
powerpc64                           defconfig
arm                           spitz_defconfig
mips                           ip28_defconfig
powerpc                     sbc8548_defconfig
sh                           se7619_defconfig
c6x                         dsk6455_defconfig
parisc                         a500_defconfig
microblaze                       allmodconfig
mips                  mips_paravirt_defconfig
powerpc                     mpc5200_defconfig
sh                           cayman_defconfig
arm                            mmp2_defconfig
m68k                        mvme147_defconfig
x86_64                 randconfig-u0-04120838
x86_64                 randconfig-u0-04120859
x86_64                 randconfig-u0-04120920
arm                              allmodconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sparc64                          allmodconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                              fedora-25
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
i386                     randconfig-m0-201914
x86_64                   randconfig-m2-201914
i386                     randconfig-m3-201914
i386                     randconfig-m2-201914
x86_64                   randconfig-m1-201914
x86_64                   randconfig-m0-201914
x86_64                   randconfig-m3-201914
i386                     randconfig-m1-201914
riscv                             allnoconfig
i386                   randconfig-l0-04120829
x86_64                 randconfig-l2-04120829
x86_64                 randconfig-l3-04120829
i386                   randconfig-l1-04120829
x86_64                 randconfig-l1-04120829
x86_64                 randconfig-l0-04120829
i386                   randconfig-l3-04120829
i386                   randconfig-l2-04120829
x86_64                   randconfig-j0-201914
x86_64                   randconfig-j1-201914
x86_64                   randconfig-j2-201914
x86_64                   randconfig-j3-201914
i386                     randconfig-j0-201914
i386                     randconfig-j1-201914
i386                     randconfig-j2-201914
i386                     randconfig-j3-201914
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
um                                  defconfig
arc                                 defconfig
sh                          sdk7786_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
riscv                              tinyconfig
i386                               tinyconfig
arm                   milbeaut_m10v_defconfig
sh                           se7343_defconfig
arm                          pxa910_defconfig
powerpc                          alldefconfig
i386                   randconfig-c0-04120838
x86_64                           allmodconfig
i386                             alldefconfig
x86_64                            allnoconfig
i386                   randconfig-x0-04120839
arm                         palmz72_defconfig
powerpc                       ep405_defconfig
i386                   randconfig-x070-201914
i386                   randconfig-x071-201914
i386                   randconfig-x072-201914
i386                   randconfig-x073-201914
i386                   randconfig-x074-201914
i386                   randconfig-x075-201914
i386                   randconfig-x076-201914
i386                   randconfig-x077-201914
i386                   randconfig-x078-201914
i386                   randconfig-x079-201914
i386                              allnoconfig
i386                                defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
powerpc                      mgcoge_defconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
