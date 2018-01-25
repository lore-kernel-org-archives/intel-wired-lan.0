From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 25 Jan 2018 10:59:16 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 6e5978044afe4d9865f6c9005ec02b15d2888c70
Message-ID: <5a694804.swmzkaxu6dZRKMIA%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 6e5978044afe4d9865f6c9005ec02b15d2888c70  i40evf: Use the correct iterator to access the vlan filter

Regressions in current branch:

drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:96:9: sparse: cast from restricted __be32

Error ids grouped by kconfigs:

recent_errors
??? x86_64-allmodconfig
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:sparse:cast-from-restricted-__be32

elapsed time: 152m

configs tested: 187

x86_64                              defconfig
arm                         lpc32xx_defconfig
powerpc                   currituck_defconfig
x86_64                 randconfig-a0-01250939
i386                               tinyconfig
frv                                 defconfig
parisc                           alldefconfig
sh                          rsk7264_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-01250917
x86_64                           allmodconfig
x86_64                randconfig-in0-01250745
arm                          nuc950_defconfig
m32r                   mappi2.vdec2_defconfig
mips                        omega2p_defconfig
x86_64                randconfig-it0-01250923
i386                   randconfig-x015-201803
i386                   randconfig-x010-201803
i386                   randconfig-x019-201803
i386                   randconfig-x014-201803
i386                   randconfig-x017-201803
i386                   randconfig-x011-201803
i386                   randconfig-x012-201803
i386                   randconfig-x016-201803
i386                   randconfig-x013-201803
i386                   randconfig-x018-201803
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201803
x86_64                 randconfig-x008-201803
x86_64                 randconfig-x005-201803
x86_64                 randconfig-x000-201803
x86_64                 randconfig-x009-201803
x86_64                 randconfig-x007-201803
x86_64                 randconfig-x002-201803
x86_64                 randconfig-x001-201803
x86_64                 randconfig-x006-201803
x86_64                 randconfig-x003-201803
x86_64                 randconfig-x004-201803
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
i386                     randconfig-i0-201803
i386                     randconfig-i1-201803
arm                           acs5k_defconfig
arm                         ebsa110_defconfig
blackfin                       SRV1_defconfig
x86_64                 randconfig-v0-01250938
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
i386                   randconfig-a1-01241352
i386                   randconfig-a0-01241352
x86_64                 randconfig-s0-01250905
x86_64                 randconfig-s1-01250905
x86_64                 randconfig-s2-01250905
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
x86_64                 randconfig-x017-201803
x86_64                 randconfig-x018-201803
x86_64                 randconfig-x016-201803
x86_64                 randconfig-x013-201803
x86_64                 randconfig-x014-201803
x86_64                 randconfig-x011-201803
x86_64                 randconfig-x012-201803
x86_64                 randconfig-x015-201803
x86_64                 randconfig-x019-201803
x86_64                 randconfig-x010-201803
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201803
i386                     randconfig-s1-201803
x86_64                 randconfig-s3-01250919
x86_64                 randconfig-s4-01250919
x86_64                 randconfig-s5-01250919
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
arm                        spear6xx_defconfig
frv                              alldefconfig
mips                                defconfig
powerpc                      obs600_defconfig
x86_64                   randconfig-i0-201803
i386                   randconfig-b0-01250904
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                 randconfig-b0-01250817
powerpc                mpc7448_hpc2_defconfig
powerpc64                        allyesconfig
x86_64                 randconfig-u0-01250906
i386                   randconfig-h0-01250615
i386                   randconfig-h1-01250615
blackfin                  TCM-BF518_defconfig
m32r                       mappi.up_defconfig
x86_64                            allnoconfig
arm                            netx_defconfig
arm                         shannon_defconfig
x86_64                 randconfig-h0-01251004
arm                    vt8500_v6_v7_defconfig
cris                             alldefconfig
mips                           jazz_defconfig
i386                  randconfig-sb0-01250926
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
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
arm                         nhk8815_defconfig
arm                       versatile_defconfig
powerpc                  iss476-smp_defconfig
x86_64                randconfig-ws0-01250815
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
i386                   randconfig-x071-201803
i386                   randconfig-x079-201803
i386                   randconfig-x077-201803
i386                   randconfig-x072-201803
i386                   randconfig-x076-201803
i386                   randconfig-x075-201803
i386                   randconfig-x073-201803
i386                   randconfig-x070-201803
i386                   randconfig-x074-201803
i386                   randconfig-x078-201803
blackfin                      H8606_defconfig
sh                          r7780mp_defconfig
xtensa                  audio_kc705_defconfig
x86_64                 randconfig-r0-01250917
i386                             allmodconfig
parisc                           allmodconfig
powerpc                    adder875_defconfig
powerpc                    gamecube_defconfig
i386                   randconfig-x004-201803
i386                   randconfig-x002-201803
i386                   randconfig-x007-201803
i386                   randconfig-x003-201803
i386                   randconfig-x009-201803
i386                   randconfig-x000-201803
i386                   randconfig-x006-201803
i386                   randconfig-x005-201803
i386                   randconfig-x001-201803
i386                   randconfig-x008-201803
i386                   randconfig-x0-01250917

Thanks,
Fengguang
