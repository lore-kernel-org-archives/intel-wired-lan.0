From: kbuild test robot <lkp@intel.com>
Date: Wed, 26 Sep 2018 23:07:09 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 58/78]
 drivers/net/ethernet/intel/ice/ice_main.c:3882:25: error: 'ice_netpoll'
 undeclared here (not in a function); did you mean 'ice_napi_poll'?
Message-ID: <201809262307.gU0ytAX9%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   5b3f08c3aca3b47795dd75807714a01ffcbf8b22
commit: 3709d0587b84bd44d1b34cb8fb676ff4222d9160 [58/78] ice: Add handlers for VF netdevice operations
config: xtensa-allmodconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 3709d0587b84bd44d1b34cb8fb676ff4222d9160
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=xtensa 

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ice/ice_main.c:3882:25: error: 'ice_netpoll' undeclared here (not in a function); did you mean 'ice_napi_poll'?
     .ndo_poll_controller = ice_netpoll,
                            ^~~~~~~~~~~
                            ice_napi_poll

vim +3882 drivers/net/ethernet/intel/ice/ice_main.c

  3870	
  3871	static const struct net_device_ops ice_netdev_ops = {
  3872		.ndo_open = ice_open,
  3873		.ndo_stop = ice_stop,
  3874		.ndo_start_xmit = ice_start_xmit,
  3875		.ndo_features_check = ice_features_check,
  3876		.ndo_set_rx_mode = ice_set_rx_mode,
  3877		.ndo_set_mac_address = ice_set_mac_address,
  3878		.ndo_validate_addr = eth_validate_addr,
  3879		.ndo_change_mtu = ice_change_mtu,
  3880		.ndo_get_stats64 = ice_get_stats64,
  3881	#ifdef CONFIG_NET_POLL_CONTROLLER
> 3882		.ndo_poll_controller = ice_netpoll,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 55095 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180926/513be9ad/attachment-0001.bin>
