From: kernel test robot <lkp@intel.com>
Date: Thu, 31 Mar 2022 09:26:01 +0800
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix error when changing
 ring parameters on ice PF
In-Reply-To: <20220330200551.1319989-1-michal.maloszewski@intel.com>
References: <20220330200551.1319989-1-michal.maloszewski@intel.com>
Message-ID: <202203310910.dFCrEjEI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Michal,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on net/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Michal-Maloszewski/iavf-Fix-error-when-changing-ring-parameters-on-ice-PF/20220331-020106
base:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 77c9387c0c5bd496fba3200024e3618356b2fd34
config: ia64-buildonly-randconfig-r006-20220330 (https://download.01.org/0day-ci/archive/20220331/202203310910.dFCrEjEI-lkp at intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a8068b9657399592e287db78ed570816d1bda796
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Michal-Maloszewski/iavf-Fix-error-when-changing-ring-parameters-on-ice-PF/20220331-020106
        git checkout a8068b9657399592e287db78ed570816d1bda796
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/net/ethernet/intel/iavf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/iavf/iavf_ethtool.c: In function 'iavf_set_ringparam':
>> drivers/net/ethernet/intel/iavf/iavf_ethtool.c:635:46: warning: suggest parentheses around '&&' within '||' [-Wparentheses]
     635 |             adapter->state == __IAVF_RUNNING &&
         |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~
     636 |             (adapter->flags & IAVF_FLAG_QUEUES_DISABLED))
         |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +635 drivers/net/ethernet/intel/iavf/iavf_ethtool.c

   612	
   613	/**
   614	 * iavf_set_ringparam - Set ring parameters
   615	 * @netdev: network interface device structure
   616	 * @ring: ethtool ringparam structure
   617	 * @kernel_ring: ethtool external ringparam structure
   618	 * @extack: netlink extended ACK report struct
   619	 *
   620	 * Sets ring parameters. TX and RX rings are controlled separately, but the
   621	 * number of rings is not specified, so all rings get the same settings.
   622	 **/
   623	static int iavf_set_ringparam(struct net_device *netdev,
   624				      struct ethtool_ringparam *ring,
   625				      struct kernel_ethtool_ringparam *kernel_ring,
   626				      struct netlink_ext_ack *extack)
   627	{
   628		struct iavf_adapter *adapter = netdev_priv(netdev);
   629		u32 new_rx_count, new_tx_count;
   630	
   631		if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
   632			return -EINVAL;
   633	
   634		if (adapter->state == __IAVF_RESETTING ||
 > 635		    adapter->state == __IAVF_RUNNING &&
   636		    (adapter->flags & IAVF_FLAG_QUEUES_DISABLED))
   637			return -EAGAIN;
   638	
   639		if (ring->tx_pending > IAVF_MAX_TXD ||
   640		    ring->tx_pending < IAVF_MIN_TXD ||
   641		    ring->rx_pending > IAVF_MAX_RXD ||
   642		    ring->rx_pending < IAVF_MIN_RXD) {
   643			netdev_err(netdev, "Descriptors requested (Tx: %d / Rx: %d) out of range [%d-%d] (increment %d)\n",
   644				   ring->tx_pending, ring->rx_pending, IAVF_MIN_TXD,
   645				   IAVF_MAX_RXD, IAVF_REQ_DESCRIPTOR_MULTIPLE);
   646			return -EINVAL;
   647		}
   648	
   649		new_tx_count = ALIGN(ring->tx_pending, IAVF_REQ_DESCRIPTOR_MULTIPLE);
   650		if (new_tx_count != ring->tx_pending)
   651			netdev_info(netdev, "Requested Tx descriptor count rounded up to %d\n",
   652				    new_tx_count);
   653	
   654		new_rx_count = ALIGN(ring->rx_pending, IAVF_REQ_DESCRIPTOR_MULTIPLE);
   655		if (new_rx_count != ring->rx_pending)
   656			netdev_info(netdev, "Requested Rx descriptor count rounded up to %d\n",
   657				    new_rx_count);
   658	
   659		/* if nothing to do return success */
   660		if ((new_tx_count == adapter->tx_desc_count) &&
   661		    (new_rx_count == adapter->rx_desc_count)) {
   662			netdev_dbg(netdev, "Nothing to change, descriptor count is same as requested\n");
   663			return 0;
   664		}
   665	
   666		if (new_tx_count != adapter->tx_desc_count) {
   667			netdev_dbg(netdev, "Changing Tx descriptor count from %d to %d\n",
   668				   adapter->tx_desc_count, new_tx_count);
   669			adapter->tx_desc_count = new_tx_count;
   670		}
   671	
   672		if (new_rx_count != adapter->rx_desc_count) {
   673			netdev_dbg(netdev, "Changing Rx descriptor count from %d to %d\n",
   674				   adapter->rx_desc_count, new_rx_count);
   675			adapter->rx_desc_count = new_rx_count;
   676		}
   677	
   678		if (netif_running(netdev)) {
   679			adapter->flags |= IAVF_FLAG_RESET_NEEDED;
   680			queue_work(iavf_wq, &adapter->reset_task);
   681		}
   682	
   683		return 0;
   684	}
   685	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
