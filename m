From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 21 Dec 2017 09:44:54 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 2948aa26774f3748a8311fd6bec0bb89e36fdd38
Message-ID: <5a3b1216.Cbn+ZjhS0A2kWMeq%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 2948aa26774f3748a8311fd6bec0bb89e36fdd38  ixgbe: register ipsec offload with the xfrm subsystem

Regressions in current branch:

drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:46:17: sparse: incorrect type in argument 3 (different base types)

Error ids grouped by kconfigs:

recent_errors
??? x86_64-allmodconfig
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:sparse:incorrect-type-in-argument-(different-base-types)-expected-unsigned-int-unsigned-usertype-value-got-ed-int-unsigned-usertype-value

elapsed time: 149m

configs tested: 194

frv                                 defconfig
sparc                             allnoconfig
xtensa                              defconfig
x86_64                 randconfig-a0-12210806
arm                           sunxi_defconfig
microblaze                    nommu_defconfig
mips                   sb1250_swarm_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-12210733
x86_64                           allmodconfig
x86_64                randconfig-in0-12210800
i386                               tinyconfig
i386                     randconfig-n0-201751
x86_64                 randconfig-x003-201751
x86_64                 randconfig-x002-201751
x86_64                 randconfig-x006-201751
x86_64                 randconfig-x007-201751
x86_64                 randconfig-x000-201751
x86_64                 randconfig-x005-201751
x86_64                 randconfig-x004-201751
x86_64                 randconfig-x009-201751
x86_64                 randconfig-x008-201751
x86_64                 randconfig-x001-201751
i386                   randconfig-i0-12180843
i386                   randconfig-i1-12180843
arm                            u300_defconfig
blackfin                BF561-EZKIT_defconfig
powerpc                      mgcoge_defconfig
x86_64                 randconfig-v0-12210606
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
arm64                            allmodconfig
blackfin                   CM-BF548_defconfig
parisc                        c8000_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                 randconfig-g0-12210639
i386                             allmodconfig
x86_64                 randconfig-x012-201751
x86_64                 randconfig-x010-201751
x86_64                 randconfig-x011-201751
x86_64                 randconfig-x015-201751
x86_64                 randconfig-x019-201751
x86_64                 randconfig-x014-201751
x86_64                 randconfig-x013-201751
x86_64                 randconfig-x016-201751
x86_64                 randconfig-x017-201751
x86_64                 randconfig-x018-201751
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
i386                     randconfig-a0-201751
i386                     randconfig-a1-201751
x86_64                 randconfig-s0-12210746
x86_64                 randconfig-s1-12210746
x86_64                 randconfig-s2-12210746
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
arm                       multi_v4t_defconfig
arm                         shannon_defconfig
mips                        vocore2_defconfig
powerpc                    adder875_defconfig
sh                          rsk7203_defconfig
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
i386                     randconfig-s1-201751
i386                     randconfig-s0-201751
x86_64                 randconfig-s3-12210802
x86_64                 randconfig-s4-12210802
x86_64                 randconfig-s5-12210802
arm                         s5pv210_defconfig
m32r                             allmodconfig
powerpc                    sam440ep_defconfig
sh                     magicpanelr2_defconfig
x86_64                   randconfig-i0-201751
i386                   randconfig-b0-12210750
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                         palmz72_defconfig
blackfin                BF527-EZKIT_defconfig
mips                    maltaup_xpa_defconfig
powerpc                     taishan_defconfig
x86_64                 randconfig-b0-12210802
blackfin                    PNAV-10_defconfig
cris                        etraxfs_defconfig
powerpc                          g5_defconfig
x86_64                 randconfig-u0-12210802
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
arm                     am200epdkit_defconfig
x86_64                randconfig-ne0-12210749
arm                       mainstone_defconfig
openrisc                         allmodconfig
sh                      rts7751r2d1_defconfig
sh                   secureedge5410_defconfig
i386                   randconfig-h0-12210802
i386                   randconfig-h1-12210802
x86_64                 randconfig-n0-12210710
i386                   randconfig-x007-201751
i386                   randconfig-x008-201751
i386                   randconfig-x009-201751
i386                   randconfig-x004-201751
i386                   randconfig-x002-201751
i386                   randconfig-x005-201751
i386                   randconfig-x001-201751
i386                   randconfig-x006-201751
i386                   randconfig-x003-201751
i386                   randconfig-x000-201751
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
microblaze                      mmu_defconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
arm                          ep93xx_defconfig
m68k                        mvme147_defconfig
powerpc                        warp_defconfig
x86_64                randconfig-ws0-12210614
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm64                             allnoconfig
arm64                               defconfig
x86_64                randconfig-ws0-12210751
i386                   randconfig-x072-201751
i386                   randconfig-x078-201751
i386                   randconfig-x071-201751
i386                   randconfig-x077-201751
i386                   randconfig-x070-201751
i386                   randconfig-x074-201751
i386                   randconfig-x073-201751
i386                   randconfig-x079-201751
i386                   randconfig-x076-201751
i386                   randconfig-x075-201751
arm                      acs5k_tiny_defconfig
blackfin                 BlackStamp_defconfig
powerpc                      pcm030_defconfig
x86_64                 randconfig-r0-12210758
alpha                            allyesconfig
powerpc                      ppc40x_defconfig
i386                   randconfig-x0-12210732

Thanks,
Fengguang
