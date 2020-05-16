From: kbuild test robot <lkp@intel.com>
Date: Sat, 16 May 2020 09:52:03 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 7/115]
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2271:15: error: redefinition
 of 'truesize'
Message-ID: <202005160901.jprqRj3x%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   1ae51690bc317eb011c6fcc8f5549b151b347167
commit: cc703d543a3b97138318bfe7d3c86cbf78136395 [7/115] ixgbe: fix XDP redirect on archs with PAGE_SIZE above 4K
config: powerpc-defconfig (attached as .config)
compiler: powerpc64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout cc703d543a3b97138318bfe7d3c86cbf78136395
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_rx_buffer_flip':
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2271:15: error: redefinition of 'truesize'
2271 |  unsigned int truesize = ring_uses_build_skb(rx_ring) ?
|               ^~~~~~~~
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2267:15: note: previous definition of 'truesize' was here
2267 |  unsigned int truesize = ixgbe_rx_frame_truesize(rx_ring, size);
|               ^~~~~~~~

vim +/truesize +2271 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c

  2262	
  2263	static void ixgbe_rx_buffer_flip(struct ixgbe_ring *rx_ring,
  2264					 struct ixgbe_rx_buffer *rx_buffer,
  2265					 unsigned int size)
  2266	{
  2267		unsigned int truesize = ixgbe_rx_frame_truesize(rx_ring, size);
  2268	#if (PAGE_SIZE < 8192)
  2269		rx_buffer->page_offset ^= truesize;
  2270	#else
> 2271		unsigned int truesize = ring_uses_build_skb(rx_ring) ?
  2272					SKB_DATA_ALIGN(IXGBE_SKB_PAD + size) +
  2273					SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) :
  2274					SKB_DATA_ALIGN(size);
  2275	
  2276		rx_buffer->page_offset += truesize;
  2277	#endif
  2278	}
  2279	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 26149 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200516/f5af7617/attachment-0001.bin>
