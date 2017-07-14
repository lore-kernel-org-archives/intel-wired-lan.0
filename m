From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 14 Jul 2017 20:04:31 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 cd0ae899da362747a24364975922d6ed5522fbc7
Message-ID: <5968b34f.TXYCWY4I/cpamreW%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
cd0ae899da362747a24364975922d6ed5522fbc7  i40e: 25G FEC status improvements

drivers/net/ethernet/intel/i40e/i40e_debugfs.c:160:28: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'u64 {aka long long unsigned int}' [-Wformat=]
drivers/net/ethernet/intel/i40e/i40e_debugfs.c:160:2: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'u64' [-Wformat]
drivers/net/ethernet/intel/i40e/i40e_debugfs.c:160: warning: format '%08lx' expects type 'long unsigned int', but argument 3 has type 'u64'
drivers/net/ethernet/intel/i40e/i40e_debugfs.c:161:4: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'u64 {aka long long unsigned int}' [-Wformat=]
drivers/net/ethernet/intel/i40e/i40e_main.c:2437: warning: unused variable 'max_frame'
drivers/net/ethernet/intel/i40evf/i40evf_main.c:2294: warning: unused variable 'max_frame'

Error ids grouped by kconfigs:

recent_errors
??? alpha-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? arm64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? arm64-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? arm-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? i386-randconfig-x0-07141525
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? ia64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? parisc-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? powerpc-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? powerpc-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? powerpc-defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? powerpc-powernv_defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? powerpc-ppc64_defconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? s390-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? sparc64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? tile-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64
??? tile-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? x86_64-randconfig-a0-07141525
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? x86_64-randconfig-g0-07140747
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? x86_64-randconfig-s0-07140825
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? x86_64-randconfig-s0-07141901
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? x86_64-randconfig-s2-07141901
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? x86_64-randconfig-s3-07141729
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? x86_64-randconfig-s5-07141759
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? x86_64-randconfig-u0-07141934
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? x86_64-randconfig-v0-07141645
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-08lx-expects-type-long-unsigned-int-but-argument-has-type-u64
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:unused-variable-max_frame
??? ??? drivers-net-ethernet-intel-i40evf-i40evf_main.c:warning:unused-variable-max_frame
??? x86_64-rhel
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int
??? x86_64-rhel-7.2
    ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u64-aka-long-long-unsigned-int

elapsed time: 820m

configs tested: 413

parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
ia64                      gensparse_defconfig
ia64                            sim_defconfig
sparc64                           allnoconfig
arm                           stm32_defconfig
mips                        msp71xx_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                      bamboo_defconfig
powerpc                     sbc834x_defconfig
powerpc64                        allyesconfig
arm                            pleb_defconfig
cris                        etraxfs_defconfig
sh                           se7619_defconfig
blackfin                BF538-EZKIT_defconfig
m68k                          sun3x_defconfig
sh                          rsk7201_defconfig
mips                malta_kvm_guest_defconfig
sh                         ecovec24_defconfig
sh                          r7780mp_defconfig
blackfin                 BlackStamp_defconfig
mips                 pnx8335_stb225_defconfig
sh                                  defconfig
arm                        vexpress_defconfig
mips                             alldefconfig
openrisc                            defconfig
x86_64                 randconfig-a0-07140809
x86_64                 randconfig-a0-07141525
x86_64                 randconfig-a0-07141750
x86_64                 randconfig-a0-07141837
x86_64                 randconfig-a0-07141916
x86_64                 randconfig-a0-07141951
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
arm                           h5000_defconfig
arm                            mmp2_defconfig
sh                           se7780_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-07140750
i386                   randconfig-c0-07141448
i386                   randconfig-c0-07141559
i386                   randconfig-c0-07141706
i386                   randconfig-c0-07141932
x86_64                           allmodconfig
blackfin                   CM-BF527_defconfig
sparc                       sparc64_defconfig
tile                                defconfig
x86_64                randconfig-in0-07140803
arm                        keystone_defconfig
mips                         tb0219_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                      walnut_defconfig
sh                        edosk7705_defconfig
arm                         nhk8815_defconfig
powerpc                        warp_defconfig
arm                       multi_v4t_defconfig
blackfin                   CM-BF533_defconfig
sh                            hp6xx_defconfig
mips                    maltaup_xpa_defconfig
sh                          rsk7264_defconfig
sparc                            allyesconfig
x86_64                randconfig-it0-07140750
x86_64                randconfig-it0-07141450
x86_64                randconfig-it0-07141941
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201728
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
arm                     davinci_all_defconfig
arm                          iop33x_defconfig
xtensa                           allyesconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                 randconfig-v0-07140800
x86_64                 randconfig-v0-07141522
x86_64                 randconfig-v0-07141645
x86_64                 randconfig-v0-07141901
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
frv                               allnoconfig
powerpc                          allmodconfig
ia64                         bigsur_defconfig
powerpc                    adder875_defconfig
sh                        edosk7760_defconfig
arm64                            allyesconfig
x86_64                 randconfig-g0-07140747
x86_64                 randconfig-g0-07141506
x86_64                 randconfig-g0-07141558
x86_64                 randconfig-g0-07141639
x86_64                 randconfig-g0-07141807
x86_64                 randconfig-g0-07141847
x86_64                 randconfig-g0-07141930
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
arm                       omap2plus_defconfig
arm                                    sa1100
arm                              allmodconfig
arm                                   samsung
arm                        mvebu_v7_defconfig
arm                          ixp4xx_defconfig
arm                       imx_v6_v7_defconfig
arm64                            allmodconfig
arm                           tegra_defconfig
arm                                      arm5
arm64                            alldefconfig
arm                                        sh
arm                                     arm67
x86_64                                  kexec
x86_64                 randconfig-s0-07140825
x86_64                 randconfig-s1-07140825
x86_64                 randconfig-s2-07140825
x86_64                 randconfig-s0-07141458
x86_64                 randconfig-s1-07141458
x86_64                 randconfig-s2-07141458
x86_64                 randconfig-s0-07141535
x86_64                 randconfig-s1-07141535
x86_64                 randconfig-s2-07141535
x86_64                 randconfig-s0-07141618
x86_64                 randconfig-s1-07141618
x86_64                 randconfig-s2-07141618
x86_64                 randconfig-s0-07141650
x86_64                 randconfig-s1-07141650
x86_64                 randconfig-s2-07141650
x86_64                 randconfig-s0-07141731
x86_64                 randconfig-s1-07141731
x86_64                 randconfig-s2-07141731
x86_64                 randconfig-s0-07141758
x86_64                 randconfig-s1-07141758
x86_64                 randconfig-s2-07141758
x86_64                 randconfig-s0-07141839
x86_64                 randconfig-s1-07141839
x86_64                 randconfig-s2-07141839
x86_64                 randconfig-s0-07141901
x86_64                 randconfig-s1-07141901
x86_64                 randconfig-s2-07141901
x86_64                 randconfig-s0-07141938
x86_64                 randconfig-s1-07141938
x86_64                 randconfig-s2-07141938
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
arm                             ezx_defconfig
m68k                          multi_defconfig
parisc                           allmodconfig
sh                ecovec24-romimage_defconfig
sh                           se7750_defconfig
arm                           acs5k_defconfig
powerpc                 mpc836x_mds_defconfig
sh                           se7343_defconfig
arm                              alldefconfig
arm                            dove_defconfig
sh                           se7206_defconfig
sh                        sh7763rdp_defconfig
xtensa                  cadence_csp_defconfig
mn10300                          allmodconfig
powerpc                 mpc837x_rdb_defconfig
arm                        spear6xx_defconfig
arm                        trizeps4_defconfig
ia64                          tiger_defconfig
sh                           se7712_defconfig
arm                          nuc960_defconfig
arm                            u300_defconfig
blackfin               BF518F-EZBRD_defconfig
m68k                       m5275evb_defconfig
openrisc                        smp_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                    mvme5100_defconfig
arm                      pxa255-idp_defconfig
powerpc               corenet_basic_defconfig
powerpc                    socrates_defconfig
openrisc                          allnoconfig
parisc                generic-32bit_defconfig
powerpc                 linkstation_defconfig
tile                             allyesconfig
arm                         assabet_defconfig
arm                         vf610m4_defconfig
arm                            zeus_defconfig
mips                      pistachio_defconfig
sparc                       sparc32_defconfig
alpha                            allmodconfig
arm                          pxa910_defconfig
powerpc                     ep8248e_defconfig
powerpc                  iss476-smp_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                         lubbock_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                 mpc832x_mds_defconfig
s390                             alldefconfig
x86_64                 randconfig-x019-201728
x86_64                 randconfig-x010-201728
x86_64                 randconfig-x015-201728
x86_64                 randconfig-x018-201728
x86_64                 randconfig-x017-201728
x86_64                 randconfig-x016-201728
x86_64                 randconfig-x014-201728
x86_64                 randconfig-x012-201728
x86_64                 randconfig-x011-201728
x86_64                 randconfig-x013-201728
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                       m5475evb_defconfig
m68k                           sun3_defconfig
i386                   randconfig-s0-07121634
i386                   randconfig-s1-07121634
x86_64                 randconfig-s3-07140811
x86_64                 randconfig-s4-07140811
x86_64                 randconfig-s5-07140811
x86_64                 randconfig-s3-07141536
x86_64                 randconfig-s4-07141536
x86_64                 randconfig-s5-07141536
x86_64                 randconfig-s3-07141601
x86_64                 randconfig-s4-07141601
x86_64                 randconfig-s5-07141601
x86_64                 randconfig-s3-07141633
x86_64                 randconfig-s4-07141633
x86_64                 randconfig-s5-07141633
x86_64                 randconfig-s3-07141655
x86_64                 randconfig-s4-07141655
x86_64                 randconfig-s5-07141655
x86_64                 randconfig-s3-07141729
x86_64                 randconfig-s4-07141729
x86_64                 randconfig-s5-07141729
x86_64                 randconfig-s3-07141759
x86_64                 randconfig-s4-07141759
x86_64                 randconfig-s5-07141759
x86_64                 randconfig-s3-07141923
x86_64                 randconfig-s4-07141923
x86_64                 randconfig-s5-07141923
i386                             allmodconfig
arm                             mxs_defconfig
powerpc                     sbc8548_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                          r7785rp_defconfig
sh                              ul2_defconfig
arm                      footbridge_defconfig
mips                       lemote2f_defconfig
powerpc                     pq2fads_defconfig
sparc64                          allmodconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
x86_64                 randconfig-i0-07121632
i386                   randconfig-b0-07140752
i386                   randconfig-b0-07141454
i386                   randconfig-b0-07141628
i386                   randconfig-b0-07141703
i386                   randconfig-b0-07141742
i386                   randconfig-b0-07141835
x86_64                 randconfig-b0-07140727
m68k                        mvme147_defconfig
mips                          malta_defconfig
powerpc                     mpc5200_defconfig
m68k                       m5208evb_defconfig
powerpc                   motionpro_defconfig
arm                         bcm2835_defconfig
arm                          simpad_defconfig
sh                     sh7710voipgw_defconfig
arm                          pcm027_defconfig
mips                          rb532_defconfig
powerpc                     mpc512x_defconfig
m68k                              allnoconfig
x86_64                 randconfig-u0-07140827
x86_64                 randconfig-u0-07141453
x86_64                 randconfig-u0-07141554
x86_64                 randconfig-u0-07141636
x86_64                 randconfig-u0-07141653
x86_64                 randconfig-u0-07141734
x86_64                 randconfig-u0-07141745
x86_64                 randconfig-u0-07141833
x86_64                 randconfig-u0-07141852
x86_64                 randconfig-u0-07141934
arm                       aspeed_g5_defconfig
m32r                    m32700ut.up_defconfig
s390                           gcov_defconfig
tile                             alldefconfig
cris                                defconfig
mips                            e55_defconfig
powerpc                     tqm8540_defconfig
sparc64                          alldefconfig
m68k                       m5249evb_defconfig
powerpc                         c2k_defconfig
parisc                           alldefconfig
powerpc                          allyesconfig
x86_64                randconfig-ne0-07141618
x86_64                randconfig-ne0-07141750
x86_64                randconfig-ne0-07141808
x86_64                randconfig-ne0-07141835
x86_64                randconfig-ne0-07141920
x86_64                randconfig-ne0-07141944
m68k                         amcore_defconfig
m68k                        mvme16x_defconfig
microblaze                        allnoconfig
blackfin          BF527-AD7160-EVAL_defconfig
m68k                       bvme6000_defconfig
tile                             allmodconfig
i386                   randconfig-h0-07140813
i386                   randconfig-h1-07140813
i386                   randconfig-h0-07141525
i386                   randconfig-h1-07141525
i386                   randconfig-h0-07141626
i386                   randconfig-h1-07141626
i386                   randconfig-h0-07141748
i386                   randconfig-h1-07141748
i386                   randconfig-h0-07141845
i386                   randconfig-h1-07141845
powerpc                     powernv_defconfig
s390                       zfcpdump_defconfig
sh                               allyesconfig
mips                           jazz_defconfig
powerpc                       holly_defconfig
mips                         rt305x_defconfig
sh                         microdev_defconfig
mips                     loongson1c_defconfig
powerpc                    ge_imp3a_defconfig
x86_64                 randconfig-h0-07140750
x86_64                 randconfig-h0-07141533
x86_64                 randconfig-h0-07141636
x86_64                 randconfig-h0-07141657
x86_64                 randconfig-h0-07141927
arm                          gemini_defconfig
m32r                   mappi2.vdec2_defconfig
um                                allnoconfig
xtensa                generic_kc705_defconfig
blackfin                BF548-EZKIT_defconfig
sh                        dreamcast_defconfig
arm                          badge4_defconfig
powerpc                        cell_defconfig
sh                          landisk_defconfig
x86_64                 randconfig-n0-07140822
x86_64                 randconfig-n0-07141503
x86_64                 randconfig-n0-07141552
x86_64                 randconfig-n0-07141643
x86_64                 randconfig-n0-07141705
x86_64                 randconfig-n0-07141727
x86_64                 randconfig-n0-07141740
x86_64                 randconfig-n0-07141855
sh                           se7721_defconfig
xtensa                  audio_kc705_defconfig
sparc                               defconfig
sparc64                             defconfig
x86_64                randconfig-ws0-07140755
x86_64                randconfig-ws0-07141904
mips                       rbtx49xx_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                     magicpanelr2_defconfig
x86_64                randconfig-ws0-07140639
x86_64                randconfig-ws0-07141458
m32r                      mappi.smp_defconfig
s390                             allyesconfig
arm                  colibri_pxa300_defconfig
sh                         apsh4a3a_defconfig
mips                        bcm63xx_defconfig
sh                             espt_defconfig
cris                             allyesconfig
mips                     decstation_defconfig
x86_64                 randconfig-r0-07140821
x86_64                 randconfig-r0-07141504
x86_64                 randconfig-r0-07141628
x86_64                 randconfig-r0-07141647
x86_64                 randconfig-r0-07141745
x86_64                 randconfig-r0-07141847
alpha                            allyesconfig
powerpc                      katmai_defconfig
powerpc                      ppc40x_defconfig
i386                   randconfig-x0-07140810
i386                   randconfig-x0-07141525
i386                   randconfig-x0-07141701
i386                   randconfig-x0-07141740
i386                   randconfig-x0-07141835

Thanks,
Fengguang
