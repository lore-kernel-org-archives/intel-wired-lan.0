From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 03 Oct 2017 13:53:13 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:40GbE] BUILD INCOMPLETE
 ab243ec9401d164531cc9bc07fb32231d72d1280
Message-ID: <59d325c9.Gw9WjUYq2qScS5vY%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  40GbE
ab243ec9401d164531cc9bc07fb32231d72d1280  i40e: Stop dropping 802.1ad tags - eth proto 0x88a8

TIMEOUT after 604m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs tested: 101

parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
x86_64                           allyesdebian
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
x86_64                              defconfig
mips                        generic_defconfig
h8300                     edosk2674_defconfig
mn10300                          allyesconfig
x86_64                 randconfig-x001-201740
x86_64                 randconfig-x000-201740
x86_64                 randconfig-x004-201740
x86_64                 randconfig-x008-201740
x86_64                 randconfig-x006-201740
x86_64                 randconfig-x007-201740
x86_64                 randconfig-x005-201740
x86_64                 randconfig-x009-201740
x86_64                 randconfig-x003-201740
x86_64                 randconfig-x002-201740
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
arm                               allnoconfig
arm                          exynos_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
i386                   randconfig-a1-10021839
i386                   randconfig-a0-10021839
i386                               tinyconfig
ia64                                defconfig
mips                                defconfig
powerpc                             defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
i386                   randconfig-i0-10021140
i386                   randconfig-i1-10021140
mips                           jazz_defconfig
powerpc64                        alldefconfig
i386                 randconfig-x013-10021430
i386                 randconfig-x011-10021430
i386                 randconfig-x016-10021430
i386                 randconfig-x015-10021430
i386                 randconfig-x019-10021430
i386                 randconfig-x012-10021430
i386                 randconfig-x018-10021430
i386                 randconfig-x017-10021430
i386                 randconfig-x014-10021430
i386                 randconfig-x010-10021430
arm                       multi_v4t_defconfig
i386                             allmodconfig
frv                                 defconfig
tile                         tilegx_defconfig
sparc64                          allyesconfig
x86_64                 randconfig-n0-10030040
m68k                       m5475evb_defconfig
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
sparc64                           allnoconfig
x86_64                           allmodconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
xtensa                       common_defconfig
ia64                              allnoconfig
ia64                             alldefconfig
x86_64                             acpi-redef
x86_64                                nfsroot
m32r                       m32104ut_defconfig
score                      spct6600_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
nios2                         10m50_defconfig
i386                   randconfig-x074-201740
i386                   randconfig-x071-201740
i386                   randconfig-x076-201740
i386                   randconfig-x077-201740
i386                   randconfig-x073-201740
i386                   randconfig-x079-201740
i386                   randconfig-x072-201740
i386                   randconfig-x078-201740
i386                   randconfig-x075-201740
i386                   randconfig-x070-201740
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig

Thanks,
Fengguang
