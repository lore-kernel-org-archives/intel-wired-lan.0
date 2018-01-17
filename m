From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 18 Jan 2018 03:26:23 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 543aacfa212b275b0bf327b50405790a4c433d8e
Message-ID: <5a5fa35f.ljuJpQoLh5EZuG6n%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 543aacfa212b275b0bf327b50405790a4c433d8e  ixgbe: don't set RXDCTL.RLPML for 82599

Regressions in current branch:

include/linux/avf/virtchnl.h:151:36: warning: division by zero [-Wdiv-by-zero]
include/linux/avf/virtchnl.h:527:116: error: enumerator value for 'virtchnl_static_assert_virtchnl_tc_info' is not an integer constant
include/linux/avf/virtchnl.h:527:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
include/linux/avf/virtchnl.h:527:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_tc_info' is not an integer constant
include/linux/avf/virtchnl.h:527:99: warning: division by zero [-Wdiv-by-zero]

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
??? ??? include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_tc_info-is-not-an-integer-constant
??? ??? include-linux-avf-virtchnl.h:note:in-expansion-of-macro-VIRTCHNL_CHECK_STRUCT_LEN
??? ??? include-linux-avf-virtchnl.h:warning:division-by-zero
??? i386-randconfig-i1-201802
??? ??? include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_tc_info-is-not-an-integer-constant
??? ??? include-linux-avf-virtchnl.h:note:in-expansion-of-macro-VIRTCHNL_CHECK_STRUCT_LEN
??? ??? include-linux-avf-virtchnl.h:warning:division-by-zero
??? i386-randconfig-x005-201802
    ??? include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_tc_info-is-not-an-integer-constant
    ??? include-linux-avf-virtchnl.h:note:in-expansion-of-macro-VIRTCHNL_CHECK_STRUCT_LEN
    ??? include-linux-avf-virtchnl.h:warning:division-by-zero

elapsed time: 199m

configs tested: 126

x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                   randconfig-x015-201802
i386                   randconfig-x010-201802
i386                   randconfig-x019-201802
i386                   randconfig-x014-201802
i386                   randconfig-x017-201802
i386                   randconfig-x012-201802
i386                   randconfig-x011-201802
i386                   randconfig-x016-201802
i386                   randconfig-x013-201802
i386                   randconfig-x018-201802
i386                     randconfig-n0-201802
x86_64                 randconfig-x008-201802
x86_64                 randconfig-x005-201802
x86_64                 randconfig-x000-201802
x86_64                 randconfig-x009-201802
x86_64                 randconfig-x007-201802
x86_64                 randconfig-x002-201802
x86_64                 randconfig-x006-201802
x86_64                 randconfig-x001-201802
x86_64                 randconfig-x003-201802
x86_64                 randconfig-x004-201802
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
i386                     randconfig-i0-201802
i386                     randconfig-i1-201802
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
frv                                 defconfig
tile                         tilegx_defconfig
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
score                      spct6600_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
nios2                         10m50_defconfig
h8300                    h8300h-sim_defconfig
x86_64                 randconfig-x017-201802
x86_64                 randconfig-x018-201802
x86_64                 randconfig-x016-201802
x86_64                 randconfig-x013-201802
x86_64                 randconfig-x014-201802
x86_64                 randconfig-x011-201802
x86_64                 randconfig-x015-201802
x86_64                 randconfig-x012-201802
x86_64                 randconfig-x019-201802
x86_64                 randconfig-x010-201802
i386                     randconfig-a1-201802
i386                     randconfig-a0-201802
cris                 etrax-100lx_v2_defconfig
x86_64                                   rhel
x86_64                               rhel-7.2
i386                     randconfig-s0-201802
i386                     randconfig-s1-201802
i386                               tinyconfig
x86_64                   randconfig-i0-201802
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
i386                   randconfig-x004-201802
i386                   randconfig-x002-201802
i386                   randconfig-x007-201802
i386                   randconfig-x003-201802
i386                   randconfig-x009-201802
i386                   randconfig-x000-201802
i386                   randconfig-x005-201802
i386                   randconfig-x006-201802
i386                   randconfig-x001-201802
i386                   randconfig-x008-201802
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                           allmodconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
i386                   randconfig-x071-201802
i386                   randconfig-x079-201802
i386                   randconfig-x077-201802
i386                   randconfig-x072-201802
i386                   randconfig-x076-201802
i386                   randconfig-x075-201802
i386                   randconfig-x070-201802
i386                   randconfig-x073-201802
i386                   randconfig-x074-201802
i386                   randconfig-x078-201802
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
i386                             allmodconfig

Thanks,
Fengguang
