From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 14 Apr 2016 07:57:29 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:master]
 99717bdfdbeaaf387ba6ecbf7eba7fbb7a47e50a BUILD DONE
Message-ID: <570edce9.H3UoqfjoE9UrODKG%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  master
99717bdfdbeaaf387ba6ecbf7eba7fbb7a47e50a  Merge branch 'dsa-refactoring-set-1'

include/net/sock.h:442: warning: No description found for parameter 'sk_rcu'
net/ipv4/udp.c:1708:9: sparse: incompatible types in comparison expression (different address spaces)
net/ipv6/udp.c:758:9: sparse: incompatible types in comparison expression (different address spaces)
net/tipc/bearer.c:560:48: sparse: incompatible types in comparison expression (different base types)

Error ids grouped by kconfigs:

recent_errors
??? i386-allnoconfig
??? ??? include-net-sock.h:warning:No-description-found-for-parameter-sk_rcu
??? x86_64-allmodconfig
    ??? net-ipv4-udp.c:sparse:incompatible-types-in-comparison-expression-(different-address-spaces)
    ??? net-ipv6-udp.c:sparse:incompatible-types-in-comparison-expression-(different-address-spaces)
    ??? net-tipc-bearer.c:sparse:incompatible-types-in-comparison-expression-(different-base-types)


i386-tinyconfig vmlinux size:

+-------+--------------+---------------------------------------------------------------------------+
| DELTA |    SYMBOL    |                                  COMMIT                                   |
+-------+--------------+---------------------------------------------------------------------------+
|  -220 | TOTAL        | 05cf8077e54b..99717bdfdbea (ALL COMMITS)                                  |
|  -200 | TOTAL        | ae95d7126104 Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/ne |
|  -125 | TEXT         | 05cf8077e54b..99717bdfdbea (ALL COMMITS)                                  |
|  -108 | TEXT         | ae95d7126104 Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/ne |
|   -92 | DATA         | ae95d7126104 Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/ne |
|  -117 | init.text    | ae95d7126104 Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/ne |
|  -131 | setup_arch() | ae95d7126104 Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/ne |
+-------+--------------+---------------------------------------------------------------------------+

elapsed time: 53m

configs tested: 104

i386                     randconfig-a0-201615
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
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
i386                             allmodconfig
x86_64                 randconfig-x010-201615
x86_64                 randconfig-x018-201615
x86_64                 randconfig-x011-201615
x86_64                 randconfig-x013-201615
x86_64                 randconfig-x019-201615
x86_64                 randconfig-x012-201615
x86_64                 randconfig-x014-201615
x86_64                 randconfig-x016-201615
x86_64                 randconfig-x015-201615
x86_64                 randconfig-x017-201615
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s1-201615
i386                     randconfig-s0-201615
x86_64                           allmodconfig
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
x86_64                   randconfig-i0-201615
i386                     randconfig-i0-201615
i386                     randconfig-i1-201615
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                              rhel_gcov
i386                   randconfig-x012-201615
i386                   randconfig-x013-201615
i386                   randconfig-x015-201615
i386                   randconfig-x019-201615
i386                   randconfig-x011-201615
i386                   randconfig-x018-201615
i386                   randconfig-x010-201615
i386                   randconfig-x016-201615
i386                   randconfig-x017-201615
i386                   randconfig-x014-201615
x86_64                                    lkp
x86_64                                   rhel
x86_64         rhel+CONFIG_DEBUG_INFO_REDUCED
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201615
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
x86_64                 randconfig-x000-201615
x86_64                 randconfig-x001-201615
x86_64                 randconfig-x007-201615
x86_64                 randconfig-x005-201615
x86_64                 randconfig-x006-201615
x86_64                 randconfig-x004-201615
x86_64                 randconfig-x008-201615
x86_64                 randconfig-x009-201615
x86_64                 randconfig-x003-201615
x86_64                 randconfig-x002-201615
i386                   randconfig-x000-201615
i386                   randconfig-x003-201615
i386                   randconfig-x009-201615
i386                   randconfig-x005-201615
i386                   randconfig-x004-201615
i386                   randconfig-x002-201615
i386                   randconfig-x006-201615
i386                   randconfig-x007-201615
i386                   randconfig-x008-201615
i386                   randconfig-x001-201615
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9

Thanks,
Fengguang
