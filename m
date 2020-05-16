From: kbuild test robot <lkp@intel.com>
Date: Sat, 16 May 2020 13:14:38 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 7/115]
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8157:14: warning: division by
 zero is undefined
Message-ID: <202005161317.Uba1bwFZ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   1ae51690bc317eb011c6fcc8f5549b151b347167
commit: cc703d543a3b97138318bfe7d3c86cbf78136395 [7/115] ixgbe: fix XDP redirect on archs with PAGE_SIZE above 4K
config: arm64-randconfig-r025-20200515 (attached as .config)
compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project b31cb3aa5ee7ea92d830b06a0a7e42c7f2791dd4)
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        git checkout cc703d543a3b97138318bfe7d3c86cbf78136395
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2271:15: error: redefinition of 'truesize'
unsigned int truesize = ring_uses_build_skb(rx_ring) ?
^
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2267:15: note: previous definition is here
unsigned int truesize = ixgbe_rx_frame_truesize(rx_ring, size);
^
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8157:14: warning: division by zero is undefined [-Wdivision-by-zero]
cmd_type |= IXGBE_SET_FLAG(tx_flags, IXGBE_TX_FLAGS_HW_VLAN,
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8147:26: note: expanded from macro 'IXGBE_SET_FLAG'
((u32)(_input & _flag) / (_flag / _result)))
^ ~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8161:14: warning: division by zero is undefined [-Wdivision-by-zero]
cmd_type |= IXGBE_SET_FLAG(tx_flags, IXGBE_TX_FLAGS_TSO,
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8147:26: note: expanded from macro 'IXGBE_SET_FLAG'
((u32)(_input & _flag) / (_flag / _result)))
^ ~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8165:14: warning: division by zero is undefined [-Wdivision-by-zero]
cmd_type |= IXGBE_SET_FLAG(tx_flags, IXGBE_TX_FLAGS_TSTAMP,
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8147:26: note: expanded from macro 'IXGBE_SET_FLAG'
((u32)(_input & _flag) / (_flag / _result)))
^ ~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8169:14: warning: division by zero is undefined [-Wdivision-by-zero]
cmd_type ^= IXGBE_SET_FLAG(skb->no_fcs, 1, IXGBE_ADVTXD_DCMD_IFCS);
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8147:26: note: expanded from macro 'IXGBE_SET_FLAG'
((u32)(_input & _flag) / (_flag / _result)))
^ ~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8180:19: warning: division by zero is undefined [-Wdivision-by-zero]
olinfo_status |= IXGBE_SET_FLAG(tx_flags,
^~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8147:26: note: expanded from macro 'IXGBE_SET_FLAG'
((u32)(_input & _flag) / (_flag / _result)))
^ ~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8185:19: warning: division by zero is undefined [-Wdivision-by-zero]
olinfo_status |= IXGBE_SET_FLAG(tx_flags,
^~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8147:26: note: expanded from macro 'IXGBE_SET_FLAG'
((u32)(_input & _flag) / (_flag / _result)))
^ ~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8190:19: warning: division by zero is undefined [-Wdivision-by-zero]
olinfo_status |= IXGBE_SET_FLAG(tx_flags,
^~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8147:26: note: expanded from macro 'IXGBE_SET_FLAG'
((u32)(_input & _flag) / (_flag / _result)))
^ ~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8198:19: warning: division by zero is undefined [-Wdivision-by-zero]
olinfo_status |= IXGBE_SET_FLAG(tx_flags,
^~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8147:26: note: expanded from macro 'IXGBE_SET_FLAG'
((u32)(_input & _flag) / (_flag / _result)))
^ ~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:10796:45: warning: shift count >= width of type [-Wshift-count-overflow]
if (!dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
^~~~~~~~~~~~~~~~
include/linux/dma-mapping.h:139:54: note: expanded from macro 'DMA_BIT_MASK'
#define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
^ ~~~
9 warnings and 1 error generated.

vim +8157 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c

9a799d71034c4e2 drivers/net/ixgbe/ixgbe_main.c                Auke Kok        2007-09-15  8143  
472148c320c0d11 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c Alexander Duyck 2012-11-07  8144  #define IXGBE_SET_FLAG(_input, _flag, _result) \
472148c320c0d11 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c Alexander Duyck 2012-11-07  8145  	((_flag <= _result) ? \
472148c320c0d11 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c Alexander Duyck 2012-11-07  8146  	 ((u32)(_input & _flag) * (_result / _flag)) : \
472148c320c0d11 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c Alexander Duyck 2012-11-07  8147  	 ((u32)(_input & _flag) / (_flag / _result)))
472148c320c0d11 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c Alexander Duyck 2012-11-07  8148  
472148c320c0d11 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c Alexander Duyck 2012-11-07  8149  static u32 ixgbe_tx_cmd_type(struct sk_buff *skb, u32 tx_flags)
9a799d71034c4e2 drivers/net/ixgbe/ixgbe_main.c                Auke Kok        2007-09-15  8150  {
d3d0023979c87ee drivers/net/ethernet/intel/ixgbe/ixgbe_main.c Alexander Duyck 2011-07-15  8151  	/* set type for advanced descriptor with frame checksum insertion */
472148c320c0d11 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c Alexander Duyck 2012-11-07  8152  	u32 cmd_type = IXGBE_ADVTXD_DTYP_DATA |
472148c320c0d11 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c Alexander Duyck 2012-11-07  8153  		       IXGBE_ADVTXD_DCMD_DEXT |
472148c320c0d11 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c Alexander Duyck 2012-11-07  8154  		       IXGBE_ADVTXD_DCMD_IFCS;
9a799d71034c4e2 drivers/net/ixgbe/ixgbe_main.c                Auke Kok        2007-09-15  8155  
d3d0023979c87ee drivers/net/ethernet/intel/ixgbe/ixgbe_main.c Alexander Duyck 2011-07-15  8156  	/* set HW vlan bit if vlan is present */
472148c320c0d11 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c Alexander Duyck 2012-11-07 @8157  	cmd_type |= IXGBE_SET_FLAG(tx_flags, IXGBE_TX_FLAGS_HW_VLAN,
472148c320c0d11 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c Alexander Duyck 2012-11-07  8158  				   IXGBE_ADVTXD_DCMD_VLE);
3a6a4edaa59273f drivers/net/ethernet/intel/ixgbe/ixgbe_main.c Jacob Keller    2012-05-01  8159  
d3d0023979c87ee drivers/net/ethernet/intel/ixgbe/ixgbe_main.c Alexander Duyck 2011-07-15  8160  	/* set segmentation enable bits for TSO/FSO */
472148c320c0d11 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c Alexander Duyck 2012-11-07  8161  	cmd_type |= IXGBE_SET_FLAG(tx_flags, IXGBE_TX_FLAGS_TSO,
472148c320c0d11 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c Alexander Duyck 2012-11-07  8162  				   IXGBE_ADVTXD_DCMD_TSE);
472148c320c0d11 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c Alexander Duyck 2012-11-07  8163  
472148c320c0d11 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c Alexander Duyck 2012-11-07  8164  	/* set timestamp bit if present */
472148c320c0d11 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c Alexander Duyck 2012-11-07  8165  	cmd_type |= IXGBE_SET_FLAG(tx_flags, IXGBE_TX_FLAGS_TSTAMP,
472148c320c0d11 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c Alexander Duyck 2012-11-07  8166  				   IXGBE_ADVTXD_MAC_TSTAMP);
9a799d71034c4e2 drivers/net/ixgbe/ixgbe_main.c                Auke Kok        2007-09-15  8167  
62748b7bde84618 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c Alexander Duyck 2012-07-20  8168  	/* insert frame checksum */
472148c320c0d11 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c Alexander Duyck 2012-11-07  8169  	cmd_type ^= IXGBE_SET_FLAG(skb->no_fcs, 1, IXGBE_ADVTXD_DCMD_IFCS);
62748b7bde84618 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c Alexander Duyck 2012-07-20  8170  
d3d0023979c87ee drivers/net/ethernet/intel/ixgbe/ixgbe_main.c Alexander Duyck 2011-07-15  8171  	return cmd_type;
d3d0023979c87ee drivers/net/ethernet/intel/ixgbe/ixgbe_main.c Alexander Duyck 2011-07-15  8172  }
9a799d71034c4e2 drivers/net/ixgbe/ixgbe_main.c                Auke Kok        2007-09-15  8173  

:::::: The code at line 8157 was first introduced by commit
:::::: 472148c320c0d11245932ba1315bc4ec0667ed57 ixgbe: Update ixgbe Tx flags to improve code efficiency

:::::: TO: Alexander Duyck <alexander.h.duyck@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 40294 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200516/8ee7f156/attachment-0001.bin>
