From: kbuild test robot <lkp@intel.com>
Date: Sat, 22 Jun 2019 08:34:26 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 29/30]
 drivers/net/ethernet/intel/ice/ice_xsk.c:487:18: warning: cast to pointer
 from integer of different size
Message-ID: <201906220824.NcnMMBDe%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   ded437072d67251cc469cb21d62d61dab54504d3
commit: 8aef1aba7a02a296d39caf5b2cc161ce2d958c91 [29/30] ice: Add support for AF_XDP
config: xtensa-allyesconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 8aef1aba7a02a296d39caf5b2cc161ce2d958c91
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=xtensa 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/ice/ice_xsk.c: In function 'ice_reuse_rx_buf_zc':
>> drivers/net/ethernet/intel/ice/ice_xsk.c:487:18: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     new_buf->addr = (void *)(((unsigned long)old_buf->addr & mask) + hr);
                     ^

vim +487 drivers/net/ethernet/intel/ice/ice_xsk.c

   465	
   466	/**
   467	 * ice_reuse_rx_buf_zc - reuse an Rx buffer
   468	 * @rx_ring: Rx ring
   469	 * @old_buf: The buffer to recycle
   470	 *
   471	 * This function recycles a finished Rx buffer, and places it on the recycle
   472	 * queue (next_to_alloc).
   473	 */
   474	static void
   475	ice_reuse_rx_buf_zc(struct ice_ring *rx_ring, struct ice_rx_buf *old_buf)
   476	{
   477		unsigned long mask = (unsigned long)rx_ring->xsk_umem->chunk_mask;
   478		u64 hr = rx_ring->xsk_umem->headroom + XDP_PACKET_HEADROOM;
   479		u16 nta = rx_ring->next_to_alloc;
   480		struct ice_rx_buf *new_buf;
   481	
   482		new_buf = &rx_ring->rx_buf[rx_ring->next_to_alloc];
   483		nta++;
   484		rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
   485	
   486		new_buf->dma = (old_buf->dma & mask) + hr;
 > 487		new_buf->addr = (void *)(((unsigned long)old_buf->addr & mask) + hr);
   488		new_buf->handle = (old_buf->handle & mask);
   489		new_buf->handle += rx_ring->xsk_umem->headroom;
   490	
   491		old_buf->addr = NULL;
   492	}
   493	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 58346 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190622/bf158bda/attachment-0001.bin>
