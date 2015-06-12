From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 12 Jun 2015 17:31:42 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:master]
 c63264def3393dd123bfa630a7a46b5d6d2d6038 BUILD INCOMPLETE
Message-ID: <557aa6fe.krIlPAcGG2pwQbOO%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  master
c63264def3393dd123bfa630a7a46b5d6d2d6038  Merge branch 'tcp-gso-settings-defer'

drivers/net/ethernet/cavium/liquidio/cn66xx_device.c:45:2: error: implicit declaration of function 'writeq' [-Werror=implicit-function-declaration]
drivers/net/ethernet/cavium/liquidio/cn66xx_device.c:61:2: error: implicit declaration of function 'readq' [-Werror=implicit-function-declaration]
drivers/net/ethernet/cavium/liquidio/cn68xx_device.c:87:2: error: implicit declaration of function 'readq' [-Werror=implicit-function-declaration]
drivers/net/ethernet/cavium/liquidio/cn68xx_device.c:94:2: error: implicit declaration of function 'writeq' [-Werror=implicit-function-declaration]
drivers/net/ethernet/cavium/liquidio/lio_ethtool.c:237:19: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/cavium/liquidio/lio_main.c:1169:19: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/cavium/liquidio/lio_main.c:1558:22: warning: passing argument 1 of 'timespec_to_ns' from incompatible pointer type
drivers/net/ethernet/cavium/liquidio/lio_main.c:2135:30: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
drivers/net/ethernet/cavium/liquidio/lio_main.c:213:6: sparse: symbol 'octeon_droq_bh' was not declared. Should it be static?
drivers/net/ethernet/cavium/liquidio/lio_main.c:233:5: sparse: symbol 'lio_wait_for_oq_pkts' was not declared. Should it be static?
drivers/net/ethernet/cavium/liquidio/lio_main.c:2618:16: sparse: cast from restricted __be16
drivers/net/ethernet/cavium/liquidio/lio_main.c:2618:16: sparse: incorrect type in argument 1 (different base types)
drivers/net/ethernet/cavium/liquidio/lio_main.c:2618:16: sparse: restricted __be16 degrades to integer
drivers/net/ethernet/cavium/liquidio/lio_main.c:3083:5: sparse: symbol 'lio_nic_info' was not declared. Should it be static?
drivers/net/ethernet/cavium/liquidio/octeon_console.c:470:5: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t' [-Wformat=]
drivers/net/ethernet/cavium/liquidio/octeon_device.c:1230:2: error: implicit declaration of function 'readq' [-Werror=implicit-function-declaration]
drivers/net/ethernet/cavium/liquidio/octeon_device.c:1246:2: error: implicit declaration of function 'writeq' [-Werror=implicit-function-declaration]
drivers/net/ethernet/cavium/liquidio/octeon_droq.c:281:2: warning: format '%lx' expects argument of type 'long unsigned int', but argument 6 has type 'size_t' [-Wformat=]
drivers/net/ethernet/cavium/liquidio/octeon_mem_ops.c:72:3: error: implicit declaration of function 'writeq' [-Werror=implicit-function-declaration]
drivers/net/ethernet/cavium/liquidio/octeon_mem_ops.c:96:3: error: implicit declaration of function 'readq' [-Werror=implicit-function-declaration]
drivers/net/ethernet/chelsio/cxgb4/t4_hw.c:2530:9: sparse: context imbalance in 't4_load_phy_fw' - different lock contexts for basic block
drivers/net/ethernet/emulex/benet/be_main.c:1257:28: sparse: restricted __be16 degrades to integer
lib/test_bpf.c:2569:17: sparse: too many warnings
net/ipv4/inet_hashtables.c:631:13: warning: division by zero
net/ipv4/inet_hashtables.c:631:13: warning: division by zero [-Wdiv-by-zero]
net/ipv4/inet_hashtables.c:631:46: warning: division by zero [-Wdiv-by-zero]
net/ipv4/inet_hashtables.c:631:52: warning: division by zero [-Wdiv-by-zero]
net/ipv4/inet_hashtables.c:631:54: warning: division by zero [-Wdiv-by-zero]
net/ipv4/inet_hashtables.c:631: warning: division by zero
net/ipv4/inet_hashtables.c:632:24: warning: division by zero [-Wdiv-by-zero]
nf_nat_snmp_basic.c:(.text+0x166c24): undefined reference to `__avr32_udiv64'
tcp_cdg.c:(.text+0x217774): undefined reference to `__udivdi3'

TIMEOUT after 584m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs tested: 248

arm                          simpad_defconfig
blackfin             BF527-EZKIT-V2_defconfig
mips                  mips_paravirt_defconfig
i386                     randconfig-a0-201523
x86_64                 randconfig-a0-06120904
x86_64                 randconfig-a0-06121416
x86_64                 randconfig-a0-06121525
x86_64                            allnoconfig
i386                   randconfig-c0-06121422
i386                   randconfig-c0-06121450
i386                   randconfig-c0-06121516
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                                  at_hdmac
arm                                    ep93xx
arm                                  iop-adma
arm                                    sa1100
arm                                   samsung
arm                                        sh
blackfin                         allyesconfig
m68k                          hp300_defconfig
sh                           se7619_defconfig
m32r                           usrv_defconfig
m68k                          sun3x_defconfig
avr32            atngw100_evklcd101_defconfig
mips                      pistachio_defconfig
xtensa                  audio_kc705_defconfig
arm                           sama5_defconfig
arm                       spear13xx_defconfig
mips                            gpr_defconfig
ia64                            sim_defconfig
powerpc                    sbc8641d_defconfig
arm                         axm55xx_defconfig
arm                             mxs_defconfig
powerpc                           allnoconfig
mips                          lasat_defconfig
powerpc                      ppc6xx_defconfig
arm                      integrator_defconfig
arm                          iop33x_defconfig
powerpc                     stx_gp3_defconfig
mips                malta_kvm_guest_defconfig
openrisc                          allnoconfig
xtensa                           allmodconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
x86_64                 randconfig-v0-06120811
x86_64                 randconfig-v0-06120830
x86_64                 randconfig-v0-06120843
x86_64                 randconfig-v0-06120901
x86_64                 randconfig-v0-06121414
x86_64                 randconfig-v0-06121423
x86_64                 randconfig-v0-06121428
x86_64                 randconfig-v0-06121437
x86_64                 randconfig-v0-06121447
x86_64                 randconfig-v0-06121457
x86_64                 randconfig-v0-06121503
x86_64                 randconfig-v0-06121511
x86_64                 randconfig-v0-06121519
arm                      pxa255-idp_defconfig
blackfin                BF538-EZKIT_defconfig
powerpc                      ep88xc_defconfig
sh                      rts7751r2d1_defconfig
arm                         ebsa110_defconfig
microblaze                       allmodconfig
mips                                defconfig
sh                          rsk7264_defconfig
powerpc                      mgcoge_defconfig
powerpc                    sam440ep_defconfig
sh                         microdev_defconfig
i386                             alldefconfig
arm                            lart_defconfig
mips                            e55_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201523
i386                   randconfig-b0-06120821
i386                   randconfig-b0-06120831
i386                   randconfig-b0-06120855
i386                   randconfig-b0-06121419
i386                   randconfig-b0-06121432
i386                   randconfig-b0-06121441
i386                   randconfig-b0-06121500
i386                   randconfig-b0-06121517
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
m32r                       mappi.up_defconfig
powerpc                 mpc832x_mds_defconfig
s390                             alldefconfig
xtensa                          iss_defconfig
arm                          badge4_defconfig
m32r                        oaks32r_defconfig
m68k                           sun3_defconfig
powerpc                mpc8610_hpcd_defconfig
i386                             allyesconfig
mips                         rt305x_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                      virtex_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201523
x86_64                 randconfig-b0-06120815
x86_64                 randconfig-b0-06120852
x86_64                 randconfig-b0-06121413
x86_64                 randconfig-b0-06121432
x86_64                 randconfig-b0-06121503
x86_64                 randconfig-b0-06121510
x86_64                 randconfig-b0-06121521
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
x86_64                              defconfig
arm                             ezx_defconfig
blackfin                BF561-EZKIT_defconfig
sh                          sdk7780_defconfig
i386                     randconfig-n0-201523
i386                     randconfig-n1-201523
arm                                      arm5
arm                                     arm67
arm                                       mmp
arm                       omap2plus_defconfig
arm                         s3c2410_defconfig
arm                           tegra_defconfig
i386                   randconfig-h0-06121420
i386                   randconfig-h1-06121420
i386                   randconfig-h0-06121451
i386                   randconfig-h1-06121451
i386                   randconfig-h0-06121519
i386                   randconfig-h1-06121519
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                             allmodconfig
i386                              allnoconfig
i386                                defconfig
arm                         s5pv210_defconfig
sh                           se7206_defconfig
sh                           se7722_defconfig
powerpc                 linkstation_defconfig
powerpc                     mpc86xx_defconfig
sh                        sh7757lcr_defconfig
arm                           sunxi_defconfig
powerpc                      pmac32_defconfig
x86_64                                    lkp
x86_64                                   rhel
x86_64                 randconfig-h0-06120832
x86_64                 randconfig-h0-06120901
x86_64                 randconfig-h0-06121426
x86_64                 randconfig-h0-06121458
x86_64                 randconfig-h0-06121511
x86_64                 randconfig-n0-06120822
x86_64                 randconfig-n0-06120851
x86_64                 randconfig-n0-06121421
x86_64                 randconfig-n0-06121428
x86_64                 randconfig-n0-06121436
x86_64                 randconfig-n0-06121442
x86_64                 randconfig-n0-06121459
x86_64                 randconfig-n0-06121508
x86_64                 randconfig-n0-06121522
arm                          prima2_defconfig
arm                       imx_v6_v7_defconfig
arm                          marzen_defconfig
arm                    realview-smp_defconfig
sparc                            allyesconfig
um                                allnoconfig
blackfin                         alldefconfig
sh                          landisk_defconfig
arm                          pxa3xx_defconfig
powerpc                     redwood_defconfig
sh                         apsh4a3a_defconfig
powerpc                     tqm8548_defconfig
sh                          lboxre2_defconfig
m68k                          amiga_defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                  randconfig-sb0-06120839
i386                  randconfig-sb0-06120856
i386                  randconfig-sb0-06120909
i386                  randconfig-sb0-06121426
i386                  randconfig-sb0-06121433
i386                  randconfig-sb0-06121442
i386                  randconfig-sb0-06121459
i386                  randconfig-sb0-06121516
i386                  randconfig-sb0-06121523
arm                            u300_defconfig
avr32                     atstk1006_defconfig
blackfin                   CM-BF561_defconfig
arm                     eseries_pxa_defconfig
m68k                        mvme16x_defconfig
arm                              zx_defconfig
openrisc                            defconfig
xtensa                    smp_lx200_defconfig
x86_64               randconfig-x000-06112155
x86_64               randconfig-x001-06112155
x86_64               randconfig-x002-06112155
x86_64               randconfig-x003-06112155
x86_64               randconfig-x004-06112155
x86_64               randconfig-x005-06112155
x86_64               randconfig-x006-06112155
x86_64               randconfig-x007-06112155
x86_64               randconfig-x008-06112155
x86_64               randconfig-x009-06112155
i386                     randconfig-r0-201523
x86_64                 randconfig-r0-06121442
x86_64                 randconfig-r0-06121513
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64                 randconfig-s0-06120823
x86_64                 randconfig-s0-06120904
x86_64                 randconfig-s0-06121415
x86_64                 randconfig-s0-06121427
x86_64                 randconfig-s0-06121459
x86_64                           allmodconfig
avr32                      atngw100_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                 randconfig-x000-06110847
i386                 randconfig-x001-06110847
i386                 randconfig-x002-06110847
i386                 randconfig-x003-06110847
i386                 randconfig-x004-06110847
i386                 randconfig-x005-06110847
i386                 randconfig-x006-06110847
i386                 randconfig-x007-06110847
i386                 randconfig-x008-06110847
i386                 randconfig-x009-06110847
i386                   randconfig-x0-06120825
i386                   randconfig-x0-06121446

Thanks,
Fengguang
