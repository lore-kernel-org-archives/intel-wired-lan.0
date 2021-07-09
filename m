From: kernel test robot <lkp@intel.com>
Date: Fri, 9 Jul 2021 16:22:23 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue 117/120]
 ice_main.c:undefined reference to `ice_ptp_link_change'
Message-ID: <202107091617.YE7HqIM6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
head:   a6c5ae02c186fae2cd3040f328feba345b81a278
commit: 79bf99329dc45d26118260c858dec37c10b8949e [117/120] ice: implement basic E822 PTP support
config: i386-randconfig-a015-20210709 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?id=79bf99329dc45d26118260c858dec37c10b8949e
        git remote add tnguy-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
        git fetch --no-tags tnguy-next-queue dev-queue
        git checkout 79bf99329dc45d26118260c858dec37c10b8949e
        # save the attached .config to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_do_ioctl':
   ice_main.c:(.text+0xb1f): undefined reference to `ice_ptp_get_ts_config'
   ld: ice_main.c:(.text+0xb28): undefined reference to `ice_ptp_set_ts_config'
   ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_prepare_for_reset':
   ice_main.c:(.text+0x1fc6): undefined reference to `ice_ptp_release'
   ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_misc_intr':
   ice_main.c:(.text+0x3707): undefined reference to `ice_ptp_process_ts'
   ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_up_complete':
>> ice_main.c:(.text+0x3991): undefined reference to `ice_ptp_link_change'
   ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_down':
   ice_main.c:(.text+0x4576): undefined reference to `ice_ptp_link_change'
   ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_rebuild':
   ice_main.c:(.text+0x59bd): undefined reference to `ice_ptp_init'
   ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_remove':
   ice_main.c:(.text+0x5dbd): undefined reference to `ice_ptp_release'
   ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `__ice_clean_ctrlq':
   ice_main.c:(.text+0x63fe): undefined reference to `ice_ptp_link_change'
   ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_probe':
   ice_main.c:(.text+0x7d3a): undefined reference to `ice_ptp_init'
   ld: drivers/net/ethernet/intel/ice/ice_txrx_lib.o: in function `ice_process_skb_fields':
   ice_txrx_lib.c:(.text+0x1c1): undefined reference to `ice_ptp_rx_hwtstamp'
   ld: drivers/net/ethernet/intel/ice/ice_txrx.o: in function `ice_xmit_frame_ring':
   ice_txrx.c:(.text+0xd24): undefined reference to `ice_ptp_request_ts'
   ld: drivers/net/ethernet/intel/ice/ice_ethtool.o: in function `ice_get_ts_info':
   ice_ethtool.c:(.text+0x9bd): undefined reference to `ice_get_ptp_clock_index'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 39918 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210709/50e1e0f0/attachment-0001.bin>
