From: kbuild test robot <lkp@intel.com>
Date: Thu, 25 Apr 2019 09:47:31 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 02bdf3465506ed91276b20ed7e75e5fcac9d51e2
Message-ID: <5cc111b3.dPr3Dx7ZMaj6g1Gr%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 02bdf3465506ed91276b20ed7e75e5fcac9d51e2  i40e: Memory leak in i40e_config_iwarp_qvlist

Regressions in current branch:

drivers/net/ethernet/intel/i40e/i40e_main.c:14840:2-8: ERROR: missing iounmap; ioremap on line 14698 and execution via conditional on line 14839
drivers/net/ethernet/intel/iavf/iavf_adminq.c:554:18-26: Unneeded variable: "ret_code". Return "0" on line 562

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:ERROR:missing-iounmap-ioremap-on-line-and-execution-via-conditional-on-line
??? ??? drivers-net-ethernet-intel-iavf-iavf_adminq.c:Unneeded-variable:ret_code-Return-on-line
??? x86_64-allyesconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:ERROR:missing-iounmap-ioremap-on-line-and-execution-via-conditional-on-line
    ??? drivers-net-ethernet-intel-iavf-iavf_adminq.c:Unneeded-variable:ret_code-Return-on-line

elapsed time: 312m

configs tested: 172

arm                               allnoconfig
sparc64                           allnoconfig
i386                   randconfig-x010-201916
i386                   randconfig-x018-201916
i386                   randconfig-x017-201916
i386                   randconfig-x013-201916
i386                   randconfig-x011-201916
i386                   randconfig-x014-201916
i386                   randconfig-x019-201916
i386                   randconfig-x015-201916
i386                   randconfig-x016-201916
i386                   randconfig-x012-201916
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n2-201916
i386                     randconfig-n3-201916
i386                     randconfig-n0-201916
i386                     randconfig-n1-201916
x86_64                 randconfig-x004-201916
x86_64                 randconfig-x001-201916
x86_64                 randconfig-x000-201916
x86_64                 randconfig-x003-201916
x86_64                 randconfig-x008-201916
x86_64                 randconfig-x007-201916
x86_64                 randconfig-x002-201916
x86_64                 randconfig-x006-201916
x86_64                 randconfig-x009-201916
x86_64                 randconfig-x005-201916
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
i386                     randconfig-i1-201916
i386                     randconfig-i0-201916
i386                     randconfig-i3-201916
i386                     randconfig-i2-201916
riscv                             allnoconfig
riscv                               defconfig
x86_64                 randconfig-x015-201916
x86_64                 randconfig-x016-201916
x86_64                 randconfig-x017-201916
x86_64                 randconfig-x012-201916
x86_64                 randconfig-x013-201916
x86_64                 randconfig-x018-201916
x86_64                 randconfig-x010-201916
x86_64                 randconfig-x014-201916
x86_64                 randconfig-x019-201916
x86_64                 randconfig-x011-201916
i386                     randconfig-a0-201916
i386                     randconfig-a1-201916
i386                     randconfig-a2-201916
i386                     randconfig-a3-201916
arm                              allmodconfig
arm64                            allmodconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                 randconfig-k0-04220059
x86_64                 randconfig-k1-04220059
x86_64                 randconfig-k2-04220059
x86_64                 randconfig-k3-04220059
i386                   randconfig-k0-04220059
i386                   randconfig-k1-04220059
i386                   randconfig-k2-04220059
i386                   randconfig-k3-04220059
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                           allmodconfig
i386                             alldefconfig
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
nds32                             allnoconfig
nds32                               defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                             defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                     randconfig-m0-201916
x86_64                   randconfig-m2-201916
i386                     randconfig-m3-201916
i386                     randconfig-m2-201916
x86_64                   randconfig-m1-201916
x86_64                   randconfig-m0-201916
x86_64                   randconfig-m3-201916
i386                     randconfig-m1-201916
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
um                                  defconfig
arm64                            allyesconfig
x86_64                           allyesconfig
i386                             allmodconfig
x86_64                 randconfig-i0-04210908
x86_64                 randconfig-i1-04210908
x86_64                 randconfig-i2-04210908
x86_64                 randconfig-i3-04210908
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                               defconfig
x86_64                 randconfig-h0-04211727
x86_64                 randconfig-h1-04211727
x86_64                 randconfig-h2-04211727
x86_64                 randconfig-h3-04211727
x86_64                 randconfig-g0-04220745
x86_64                 randconfig-g1-04220745
x86_64                 randconfig-g2-04220745
x86_64                 randconfig-g3-04220745
i386                              allnoconfig
i386                                defconfig
riscv                              tinyconfig
i386                               tinyconfig
i386                   randconfig-x077-201916
i386                   randconfig-x074-201916
i386                   randconfig-x070-201916
i386                   randconfig-x072-201916
i386                   randconfig-x075-201916
i386                   randconfig-x071-201916
i386                   randconfig-x079-201916
i386                   randconfig-x078-201916
i386                   randconfig-x073-201916
i386                   randconfig-x076-201916
i386                   randconfig-x002-201916
i386                   randconfig-x001-201916
i386                   randconfig-x005-201916
i386                   randconfig-x007-201916
i386                   randconfig-x000-201916
i386                   randconfig-x004-201916
i386                   randconfig-x008-201916
i386                   randconfig-x009-201916
i386                   randconfig-x006-201916
i386                   randconfig-x003-201916
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
x86_64                 randconfig-e0-04220048
x86_64                 randconfig-e1-04220048
x86_64                 randconfig-e2-04220048
x86_64                 randconfig-e3-04220048

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
