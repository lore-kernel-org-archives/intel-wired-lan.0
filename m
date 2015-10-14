From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 15 Oct 2015 05:10:13 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 1c68c8580bd6290fa616b5d992e7c22a53c95cb1 BUILD DONE
Message-ID: <561ec4b5.c0kur9eRQyQ1HACF%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
1c68c8580bd6290fa616b5d992e7c22a53c95cb1  i40e: fix unconditional execution of cpu_to_le16()

drivers/net/ethernet/intel/i40e/i40e_txrx.c:2357:17: warning: 'oudph' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2357:20: warning: 'oiph' may be used uninitialized in this function [-Wmaybe-uninitialized]

Error ids grouped by kconfigs:

recent_errors
??? x86_64-rhel
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oiph-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oudph-may-be-used-uninitialized-in-this-function
??? x86_64-rhel+CONFIG_DEBUG_INFO_REDUCED
    ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oiph-may-be-used-uninitialized-in-this-function
    ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oudph-may-be-used-uninitialized-in-this-function

elapsed time: 133m

configs tested: 113

parisc                            allnoconfig
mips                        maltaup_defconfig
mn10300                          allyesconfig
i386                     randconfig-a0-201541
x86_64                 randconfig-a0-10141704
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                            allnoconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                                allnoconfig
i386                   randconfig-c0-10142341
frv                              allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
x86_64                 randconfig-v0-10141709
alpha                               defconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                             allmodconfig
mips                             allyesconfig
mips                           ip32_defconfig
mips                          lasat_defconfig
mips                      malta_kvm_defconfig
x86_64               randconfig-x010-10130227
x86_64               randconfig-x015-10130227
x86_64               randconfig-x017-10130227
x86_64               randconfig-x019-10130227
x86_64               randconfig-x012-10130227
x86_64               randconfig-x018-10130227
x86_64               randconfig-x011-10130227
x86_64               randconfig-x016-10130227
x86_64               randconfig-x014-10130227
x86_64               randconfig-x013-10130227
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
i386                     randconfig-s1-201541
i386                     randconfig-s0-201541
x86_64                 randconfig-s0-10141707
x86_64                 randconfig-s2-10141707
x86_64                           allmodconfig
x86_64                 randconfig-s3-10142325
x86_64                 randconfig-s4-10142325
x86_64                 randconfig-s5-10142325
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
x86_64                   randconfig-i0-201541
i386                   randconfig-b0-10141925
arm64                            allmodconfig
mips                          sead3_defconfig
powerpc                 mpc832x_rdb_defconfig
i386                     randconfig-i1-201541
i386                     randconfig-i0-201541
x86_64                 randconfig-b0-10141703
arm                              allmodconfig
x86_64                                    lkp
x86_64                                   rhel
x86_64         rhel+CONFIG_DEBUG_INFO_REDUCED
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201541
i386                             allyesconfig
i386                   randconfig-h0-10141540
i386                   randconfig-h1-10141540
powerpc                          allmodconfig
ia64                             alldefconfig
ia64                              allnoconfig
x86_64                 randconfig-h0-10141807
arm                               allnoconfig
arm                          marzen_defconfig
i386                  randconfig-sb0-10141904
powerpc                     sbc834x_defconfig
xtensa                           allmodconfig
x86_64                 randconfig-x002-201541
x86_64                 randconfig-x009-201541
x86_64                 randconfig-x000-201541
x86_64                 randconfig-x003-201541
x86_64                 randconfig-x004-201541
x86_64                 randconfig-x001-201541
x86_64                 randconfig-x006-201541
x86_64                 randconfig-x007-201541
x86_64                 randconfig-x008-201541
x86_64                 randconfig-x005-201541
ia64                                defconfig
i386                     randconfig-r0-201541
x86_64                 randconfig-r0-10131108
i386                 randconfig-x000-10121721
i386                 randconfig-x001-10121721
i386                 randconfig-x002-10121721
i386                 randconfig-x003-10121721
i386                 randconfig-x004-10121721
i386                 randconfig-x005-10121721
i386                 randconfig-x006-10121721
i386                 randconfig-x007-10121721
i386                 randconfig-x008-10121721
i386                 randconfig-x009-10121721
i386                   randconfig-x0-10141708

Thanks,
Fengguang
