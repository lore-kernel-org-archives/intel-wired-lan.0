From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 22 Nov 2017 23:28:31 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:40GbE] BUILD SUCCESS
 f72271e2a0ae4277d53c4053f5eed8bb346ba38a
Message-ID: <5a15979f.PtKMtXjbXHzRMVt5%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  40GbE
branch HEAD: f72271e2a0ae4277d53c4053f5eed8bb346ba38a  i40evf: Use smp_rmb rather than read_barrier_depends

elapsed time: 42m

configs tested: 165

The following configs have been built successfully.
More configs may be tested in the coming days.

x86_64                 randconfig-a0-11222140
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-11222209
x86_64                randconfig-in0-11222200
arm                        trizeps4_defconfig
arm                       versatile_defconfig
powerpc                 linkstation_defconfig
x86_64                randconfig-it0-11222156
i386                               tinyconfig
i386                   randconfig-x019-201747
i386                   randconfig-x015-201747
i386                   randconfig-x014-201747
i386                   randconfig-x013-201747
i386                   randconfig-x011-201747
i386                   randconfig-x018-201747
i386                   randconfig-x010-201747
i386                   randconfig-x012-201747
i386                   randconfig-x017-201747
i386                   randconfig-x016-201747
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201747
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
i386                     randconfig-i0-201747
i386                     randconfig-i1-201747
arm                             ezx_defconfig
arm                      integrator_defconfig
powerpc                       maple_defconfig
x86_64                 randconfig-v0-11222133
arm                           h5000_defconfig
arm                           u8500_defconfig
tile                              allnoconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                 randconfig-g0-11222242
i386                             allmodconfig
x86_64                 randconfig-x018-201747
x86_64                 randconfig-x011-201747
x86_64                 randconfig-x013-201747
x86_64                 randconfig-x019-201747
x86_64                 randconfig-x012-201747
x86_64                 randconfig-x017-201747
x86_64                 randconfig-x016-201747
x86_64                 randconfig-x014-201747
x86_64                 randconfig-x015-201747
x86_64                 randconfig-x010-201747
i386                     randconfig-a0-201747
i386                     randconfig-a1-201747
x86_64                 randconfig-s0-11222229
x86_64                 randconfig-s1-11222229
x86_64                 randconfig-s2-11222229
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
arm                         ebsa110_defconfig
blackfin                  CM-BF537E_defconfig
mips                           jazz_defconfig
powerpc64                        allmodconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201747
i386                     randconfig-s1-201747
x86_64                   randconfig-i0-201747
i386                   randconfig-b0-11222145
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                         hackkit_defconfig
arm                        raumfeld_defconfig
blackfin                  TCM-BF518_defconfig
x86_64                 randconfig-u0-11222259
x86_64                 randconfig-h0-11222201
powerpc                     sequoia_defconfig
powerpc64                        allyesconfig
i386                   randconfig-x001-201747
i386                   randconfig-x008-201747
i386                   randconfig-x002-201747
i386                   randconfig-x003-201747
i386                   randconfig-x004-201747
i386                   randconfig-x006-201747
i386                   randconfig-x007-201747
i386                   randconfig-x005-201747
i386                   randconfig-x000-201747
i386                   randconfig-x009-201747
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                 randconfig-x000-201747
x86_64                 randconfig-x001-201747
x86_64                 randconfig-x008-201747
x86_64                 randconfig-x004-201747
x86_64                 randconfig-x005-201747
x86_64                 randconfig-x007-201747
x86_64                 randconfig-x006-201747
x86_64                 randconfig-x003-201747
x86_64                 randconfig-x009-201747
x86_64                 randconfig-x002-201747
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
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
i386                   randconfig-x074-201747
i386                   randconfig-x077-201747
i386                   randconfig-x076-201747
i386                   randconfig-x071-201747
i386                   randconfig-x073-201747
i386                   randconfig-x078-201747
i386                   randconfig-x072-201747
i386                   randconfig-x079-201747
i386                   randconfig-x070-201747
i386                   randconfig-x075-201747
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
arm                          pcm027_defconfig
m32r                    m32700ut.up_defconfig
powerpc                     pseries_defconfig
i386                   randconfig-x0-11222241

Thanks,
Fengguang
