From: kernel test robot <lkp@intel.com>
Date: Thu, 31 Mar 2022 06:23:02 +0800
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix error when changing
 ring parameters on ice PF
In-Reply-To: <20220330200551.1319989-1-michal.maloszewski@intel.com>
References: <20220330200551.1319989-1-michal.maloszewski@intel.com>
Message-ID: <202203310630.dWNnf9Ol-lkp@intel.com>
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
config: s390-randconfig-r033-20220330 (https://download.01.org/0day-ci/archive/20220331/202203310630.dWNnf9Ol-lkp at intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/a8068b9657399592e287db78ed570816d1bda796
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Michal-Maloszewski/iavf-Fix-error-when-changing-ring-parameters-on-ice-PF/20220331-020106
        git checkout a8068b9657399592e287db78ed570816d1bda796
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/net/ethernet/intel/iavf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/intel/iavf/iavf_ethtool.c:5:
   In file included from drivers/net/ethernet/intel/iavf/iavf.h:8:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from drivers/net/ethernet/intel/iavf/iavf_ethtool.c:5:
   In file included from drivers/net/ethernet/intel/iavf/iavf.h:8:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from drivers/net/ethernet/intel/iavf/iavf_ethtool.c:5:
   In file included from drivers/net/ethernet/intel/iavf/iavf.h:8:
   In file included from include/linux/pci.h:39:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/net/ethernet/intel/iavf/iavf_ethtool.c:635:39: warning: '&&' within '||' [-Wlogical-op-parentheses]
               adapter->state == __IAVF_RUNNING &&
               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~
   drivers/net/ethernet/intel/iavf/iavf_ethtool.c:635:39: note: place parentheses around the '&&' expression to silence this warning
               adapter->state == __IAVF_RUNNING &&
                                                ^
               (
   13 warnings generated.


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
