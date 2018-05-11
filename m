From: kbuild test robot <lkp@intel.com>
Date: Fri, 11 May 2018 14:32:55 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 458c3999535d70b766f571967104c4303ed90583
Message-ID: <5af53917.gh+XYLYAlKWB+4kj%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 458c3999535d70b766f571967104c4303ed90583  Documentation: e1000: Update kernel documentation

Regressions in current branch:

kernel/sched/fair.c:9809:15: warning: assignment makes integer from pointer without a cast [-Wint-conversion]

Error ids grouped by kconfigs:

recent_errors
|-- powerpc-defconfig
|   `-- kernel-sched-fair.c:warning:assignment-makes-integer-from-pointer-without-a-cast
`-- powerpc-ppc64_defconfig
    `-- kernel-sched-fair.c:warning:assignment-makes-integer-from-pointer-without-a-cast

TIMEOUT after 606m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 31

alpha                            allmodconfig
alpha                            allyesconfig
arm                            customconfig-0
arm                            customconfig-1
arm                            customconfig-2
arm64                          customconfig-0
arm64                          customconfig-1
arm64                          customconfig-2
i386                           customconfig-0
i386                           customconfig-1
i386                           customconfig-2
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
mips                             allmodconfig
mips                             allyesconfig
parisc                           allmodconfig
powerpc                          allyesconfig
s390                             allmodconfig
s390                             allyesconfig
sh                               allmodconfig
sparc                            allmodconfig
sparc                            allyesconfig
sparc64                          allyesconfig
x86_64                           allyesconfig
x86_64                         customconfig-0
x86_64                         customconfig-1
x86_64                         customconfig-2
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 215

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64                 randconfig-a0-05110017
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-05102027
x86_64                           allmodconfig
mips                    maltaup_xpa_defconfig
powerpc                      tqm8xx_defconfig
x86_64                randconfig-in0-05101830
x86_64                randconfig-it0-05110011
i386                   randconfig-x013-201818
i386                   randconfig-x014-201818
i386                   randconfig-x019-201818
i386                   randconfig-x016-201818
i386                   randconfig-x015-201818
i386                   randconfig-x012-201818
i386                   randconfig-x018-201818
i386                   randconfig-x010-201818
i386                   randconfig-x011-201818
i386                   randconfig-x017-201818
x86_64                              federa-25
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201818
x86_64                 randconfig-x002-201818
x86_64                 randconfig-x006-201818
x86_64                 randconfig-x005-201818
x86_64                 randconfig-x001-201818
x86_64                 randconfig-x009-201818
x86_64                 randconfig-x004-201818
x86_64                 randconfig-x003-201818
x86_64                 randconfig-x007-201818
x86_64                 randconfig-x000-201818
x86_64                 randconfig-x008-201818
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
i386                     randconfig-i1-201818
i386                     randconfig-i0-201818
x86_64                 randconfig-v0-05101836
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
sh                           se7619_defconfig
x86_64                 randconfig-g0-05102359
i386                             allmodconfig
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
i386                     randconfig-a0-201818
i386                     randconfig-a1-201818
x86_64                 randconfig-s0-05101923
x86_64                 randconfig-s1-05101923
x86_64                 randconfig-s2-05101923
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
openrisc                         allmodconfig
powerpc                      mgcoge_defconfig
sparc                             allnoconfig
powerpc                    sam440ep_defconfig
powerpc64                           defconfig
sparc64                             defconfig
arm                            pleb_defconfig
powerpc64                         allnoconfig
sh                           cayman_defconfig
arm                         axm55xx_defconfig
arm                        spear6xx_defconfig
mips                        jmr3927_defconfig
um                               alldefconfig
arm                        oxnas_v6_defconfig
arm                        raumfeld_defconfig
powerpc                      makalu_defconfig
arm                         lubbock_defconfig
m68k                         apollo_defconfig
parisc                           allyesconfig
arm                          gemini_defconfig
arm                         mv78xx0_defconfig
powerpc                     mpc83xx_defconfig
powerpc                      virtex_defconfig
arm                  colibri_pxa270_defconfig
powerpc                    gamecube_defconfig
powerpc                  mpc866_ads_defconfig
sh                          landisk_defconfig
mips                     loongson1b_defconfig
powerpc                      chrp32_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                ecovec24-romimage_defconfig
arm                           omap1_defconfig
arm                          tango4_defconfig
sh                        dreamcast_defconfig
x86_64                 randconfig-x010-201818
x86_64                 randconfig-x014-201818
x86_64                 randconfig-x013-201818
x86_64                 randconfig-x011-201818
x86_64                 randconfig-x015-201818
x86_64                 randconfig-x019-201818
x86_64                 randconfig-x016-201818
x86_64                 randconfig-x018-201818
x86_64                 randconfig-x012-201818
x86_64                 randconfig-x017-201818
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s1-201818
i386                     randconfig-s0-201818
x86_64                 randconfig-s3-05110330
x86_64                 randconfig-s4-05110330
x86_64                 randconfig-s5-05110330
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201818
i386                   randconfig-b0-05102358
i386                             allyesconfig
x86_64                 randconfig-b0-05101859
sparc                               defconfig
sparc64                           allnoconfig
microblaze                       allmodconfig
x86_64                 randconfig-u0-05110101
i386                               tinyconfig
mips                        maltaup_defconfig
powerpc                          allmodconfig
sparc                       sparc32_defconfig
i386                   randconfig-h0-05110044
i386                   randconfig-h1-05110044
m68k                            mac_defconfig
sparc64                          allmodconfig
arm                            dove_defconfig
arm                         lpc32xx_defconfig
arm                            xcep_defconfig
sh                         ecovec24_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                      ppc64e_defconfig
x86_64                randconfig-ne0-05101904
x86_64                randconfig-ne0-05111400
arm                           corgi_defconfig
powerpc                     pq2fads_defconfig
arm                            mps2_defconfig
c6x                        evmc6474_defconfig
powerpc                   currituck_defconfig
x86_64                 randconfig-h0-05102358
i386                   randconfig-x008-201818
i386                   randconfig-x006-201818
i386                   randconfig-x000-201818
i386                   randconfig-x004-201818
i386                   randconfig-x009-201818
i386                   randconfig-x003-201818
i386                   randconfig-x001-201818
i386                   randconfig-x002-201818
i386                   randconfig-x005-201818
i386                   randconfig-x007-201818
x86_64                randconfig-ws0-05102331
i386                   randconfig-x073-201818
i386                   randconfig-x075-201818
i386                   randconfig-x079-201818
i386                   randconfig-x071-201818
i386                   randconfig-x076-201818
i386                   randconfig-x074-201818
i386                   randconfig-x078-201818
i386                   randconfig-x077-201818
i386                   randconfig-x070-201818
i386                   randconfig-x072-201818
mips                         cobalt_defconfig
s390                       zfcpdump_defconfig
x86_64                 randconfig-r0-05102337
sh                               allyesconfig
i386                   randconfig-x0-05102354
i386                   randconfig-x0-05111330

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
