From: kernel test robot <lkp@intel.com>
Date: Sat, 7 Aug 2021 16:24:21 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue 80/118]
 ice_main.c:undefined reference to `ice_ptp_link_change'
Message-ID: <202108071616.TxA4HRdX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
head:   96ea8bee7ce727581d6cc6f23ed4b277dc0e3355
commit: 5ef81503204bb4b80757b03ff40129ad038cd7c0 [80/118] ice: implement basic E822 PTP support
config: arm-randconfig-r003-20210804 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 10.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?id=5ef81503204bb4b80757b03ff40129ad038cd7c0
        git remote add tnguy-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
        git fetch --no-tags tnguy-next-queue dev-queue
        git checkout 5ef81503204bb4b80757b03ff40129ad038cd7c0
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_eth_ioctl':
   ice_main.c:(.text+0x1724): undefined reference to `ice_ptp_get_ts_config'
   arm-linux-gnueabi-ld: ice_main.c:(.text+0x1734): undefined reference to `ice_ptp_set_ts_config'
   arm-linux-gnueabi-ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_prepare_for_reset':
   ice_main.c:(.text+0x6678): undefined reference to `ice_ptp_release'
   arm-linux-gnueabi-ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_rebuild':
   ice_main.c:(.text+0x8148): undefined reference to `ice_ptp_init'
   arm-linux-gnueabi-ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_remove':
   ice_main.c:(.text+0x912c): undefined reference to `ice_ptp_release'
   arm-linux-gnueabi-ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_link_event':
>> ice_main.c:(.text+0xb91c): undefined reference to `ice_ptp_link_change'
   arm-linux-gnueabi-ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_misc_intr':
   ice_main.c:(.text+0xd62c): undefined reference to `ice_ptp_process_ts'
   arm-linux-gnueabi-ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_up_complete':
   ice_main.c:(.text+0xdc58): undefined reference to `ice_ptp_link_change'
   arm-linux-gnueabi-ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_down':
>> (.text+0x1038c): undefined reference to `ice_ptp_link_change'
   arm-linux-gnueabi-ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_probe':
   ice_main.c:(.text+0x122b8): undefined reference to `ice_ptp_init'
   arm-linux-gnueabi-ld: drivers/net/ethernet/intel/ice/ice_txrx_lib.o: in function `ice_process_skb_fields':
   ice_txrx_lib.c:(.text+0x5b4): undefined reference to `ice_ptp_rx_hwtstamp'
   arm-linux-gnueabi-ld: drivers/net/ethernet/intel/ice/ice_txrx.o: in function `ice_tstamp':
   ice_txrx.c:(.text+0xab8): undefined reference to `ice_ptp_request_ts'
   arm-linux-gnueabi-ld: drivers/net/ethernet/intel/ice/ice_ethtool.o: in function `ice_get_ts_info':
   ice_ethtool.c:(.text+0x4074): undefined reference to `ice_get_ptp_clock_index'
   arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-smc.o: in function `__scm_smc_do_quirk':
   qcom_scm-smc.c:(.text+0x74): undefined reference to `__arm_smccc_smc'
   arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call':
   qcom_scm-legacy.c:(.text+0x3a0): undefined reference to `__arm_smccc_smc'
   arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call_atomic':
   qcom_scm-legacy.c:(.text+0x634): undefined reference to `__arm_smccc_smc'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for QCOM_SCM
   Depends on (ARM || ARM64) && HAVE_ARM_SMCCC
   Selected by
   - ARM_QCOM_SPM_CPUIDLE && CPU_IDLE && (ARM || ARM64) && (ARCH_QCOM || COMPILE_TEST && !ARM64 && MMU

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 35643 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210807/a0f503f5/attachment-0001.bin>
