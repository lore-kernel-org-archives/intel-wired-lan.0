From: kbuild test robot <lkp@intel.com>
Date: Tue, 26 May 2020 23:00:51 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 19/99]
 drivers/net/ethernet/intel/i40e/i40e_xsk.c:183:6: sparse: the previous one
 is here
Message-ID: <20200526150050.GA30967@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   5950d1e508b225372208a78339e6434adf129852
commit: b530c4dd1d0830c45139e65808038373cc54ebc8 [19/99] i40e: trivial fixup of comments in i40e_xsk.c
:::::: branch date: 9 hours ago
:::::: commit date: 9 hours ago
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-193-gb8fad4bc-dirty
        git checkout b530c4dd1d0830c45139e65808038373cc54ebc8
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=x86_64 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/net/ethernet/intel/i40e/i40e_xsk.c:234:6: sparse: sparse: multiple definitions for function 'i40e_alloc_rx_buffers_zc'
>> drivers/net/ethernet/intel/i40e/i40e_xsk.c:183:6: sparse:  the previous one is here
   drivers/net/ethernet/intel/i40e/i40e_xsk.c:236:16: sparse: sparse: undefined identifier '__i40e_alloc_rx_buffers_zc'
   drivers/net/ethernet/intel/i40e/i40e_xsk.c:252:16: sparse: sparse: undefined identifier '__i40e_alloc_rx_buffers_zc'
   drivers/net/ethernet/intel/i40e/i40e_xsk.c:302:15: sparse: sparse: no member 'addr' in struct i40e_rx_buffer
   drivers/net/ethernet/intel/i40e/i40e_xsk.c:302:30: sparse: sparse: no member 'addr' in struct i40e_rx_buffer
   drivers/net/ethernet/intel/i40e/i40e_xsk.c:303:15: sparse: sparse: no member 'handle' in struct i40e_rx_buffer
   drivers/net/ethernet/intel/i40e/i40e_xsk.c:303:32: sparse: sparse: no member 'handle' in struct i40e_rx_buffer
   drivers/net/ethernet/intel/i40e/i40e_xsk.c:305:15: sparse: sparse: no member 'addr' in struct i40e_rx_buffer
   drivers/net/ethernet/intel/i40e/i40e_xsk.c:320:19: sparse: sparse: no member 'zca' in struct i40e_ring
>> drivers/net/ethernet/intel/i40e/i40e_xsk.c:320:19: sparse: sparse: unknown member
>> drivers/net/ethernet/intel/i40e/i40e_xsk.c:320:19: sparse: sparse: cast from unknown type
   drivers/net/ethernet/intel/i40e/i40e_xsk.c:322:33: sparse: sparse: no member 'chunk_mask' in struct xdp_umem
   drivers/net/ethernet/intel/i40e/i40e_xsk.c:332:19: sparse: sparse: undefined identifier 'xdp_umem_get_dma'
   drivers/net/ethernet/intel/i40e/i40e_xsk.c:335:11: sparse: sparse: no member 'addr' in struct i40e_rx_buffer
   drivers/net/ethernet/intel/i40e/i40e_xsk.c:335:20: sparse: sparse: undefined identifier 'xdp_umem_get_data'
   drivers/net/ethernet/intel/i40e/i40e_xsk.c:336:11: sparse: sparse: no member 'addr' in struct i40e_rx_buffer
   drivers/net/ethernet/intel/i40e/i40e_xsk.c:338:11: sparse: sparse: no member 'handle' in struct i40e_rx_buffer
   drivers/net/ethernet/intel/i40e/i40e_xsk.c:338:22: sparse: sparse: undefined identifier 'xsk_umem_adjust_offset'
   drivers/net/ethernet/intel/i40e/i40e_xsk.c:536:46: sparse: sparse: invalid assignment: |=

# https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git/commit/?id=b530c4dd1d0830c45139e65808038373cc54ebc8
git remote add jkirsher-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
git remote update jkirsher-next-queue
git checkout b530c4dd1d0830c45139e65808038373cc54ebc8
vim +183 drivers/net/ethernet/intel/i40e/i40e_xsk.c

0a714186d3c0f7 Bj?rn T?pel            2018-08-28  182  
3b4f0b66c2b3dc Bj?rn T?pel            2020-05-20 @183  bool i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_ring, u16 count)
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  184  {
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  185  	u16 ntu = rx_ring->next_to_use;
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  186  	union i40e_rx_desc *rx_desc;
3b4f0b66c2b3dc Bj?rn T?pel            2020-05-20  187  	struct xdp_buff **bi, *xdp;
3b4f0b66c2b3dc Bj?rn T?pel            2020-05-20  188  	dma_addr_t dma;
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  189  	bool ok = true;
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  190  
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  191  	rx_desc = I40E_RX_DESC(rx_ring, ntu);
e1675f97367bed Bj?rn T?pel            2020-05-20  192  	bi = i40e_rx_bi(rx_ring, ntu);
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  193  	do {
3b4f0b66c2b3dc Bj?rn T?pel            2020-05-20  194  		xdp = xsk_buff_alloc(rx_ring->xsk_umem);
3b4f0b66c2b3dc Bj?rn T?pel            2020-05-20  195  		if (!xdp) {
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  196  			ok = false;
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  197  			goto no_buffers;
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  198  		}
3b4f0b66c2b3dc Bj?rn T?pel            2020-05-20  199  		*bi = xdp;
3b4f0b66c2b3dc Bj?rn T?pel            2020-05-20  200  		dma = xsk_buff_xdp_get_dma(xdp);
3b4f0b66c2b3dc Bj?rn T?pel            2020-05-20  201  		rx_desc->read.pkt_addr = cpu_to_le64(dma);
3b4f0b66c2b3dc Bj?rn T?pel            2020-05-20  202  		rx_desc->read.hdr_addr = 0;
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  203  
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  204  		rx_desc++;
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  205  		bi++;
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  206  		ntu++;
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  207  
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  208  		if (unlikely(ntu == rx_ring->count)) {
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  209  			rx_desc = I40E_RX_DESC(rx_ring, 0);
e1675f97367bed Bj?rn T?pel            2020-05-20  210  			bi = i40e_rx_bi(rx_ring, 0);
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  211  			ntu = 0;
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  212  		}
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  213  
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  214  		count--;
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  215  	} while (count);
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  216  
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  217  no_buffers:
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  218  	if (rx_ring->next_to_use != ntu)
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  219  		i40e_release_rx_desc(rx_ring, ntu);
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  220  
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  221  	return ok;
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  222  }
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  223  
0a714186d3c0f7 Bj?rn T?pel            2018-08-28  224  /**
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  225   * i40e_alloc_rx_buffers_zc - Allocates a number of Rx buffers
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  226   * @rx_ring: Rx ring
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  227   * @count: The number of buffers to allocate
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  228   *
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  229   * This function allocates a number of Rx buffers from the reuse queue
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  230   * or fill ring and places them on the Rx ring.
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  231   *
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  232   * Returns true for a successful allocation, false otherwise
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  233   **/
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  234  bool i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_ring, u16 count)
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  235  {
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  236  	return __i40e_alloc_rx_buffers_zc(rx_ring, count,
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  237  					  i40e_alloc_buffer_slow_zc);
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  238  }
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  239  
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  240  /**
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  241   * i40e_alloc_rx_buffers_fast_zc - Allocates a number of Rx buffers
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  242   * @rx_ring: Rx ring
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  243   * @count: The number of buffers to allocate
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  244   *
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  245   * This function allocates a number of Rx buffers from the fill ring
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  246   * or the internal recycle mechanism and places them on the Rx ring.
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  247   *
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  248   * Returns true for a successful allocation, false otherwise
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  249   **/
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  250  static bool i40e_alloc_rx_buffers_fast_zc(struct i40e_ring *rx_ring, u16 count)
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  251  {
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  252  	return __i40e_alloc_rx_buffers_zc(rx_ring, count,
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  253  					  i40e_alloc_buffer_zc);
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  254  }
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  255  
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  256  /**
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  257   * i40e_get_rx_buffer_zc - Return the current Rx buffer
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  258   * @rx_ring: Rx ring
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  259   * @size: The size of the rx buffer (read from descriptor)
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  260   *
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  261   * This function returns the current, received Rx buffer, and also
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  262   * does DMA synchronization.  the Rx ring.
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  263   *
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  264   * Returns the received Rx buffer
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  265   **/
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  266  static struct i40e_rx_buffer *i40e_get_rx_buffer_zc(struct i40e_ring *rx_ring,
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  267  						    const unsigned int size)
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  268  {
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  269  	struct i40e_rx_buffer *bi;
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  270  
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  271  	bi = &rx_ring->rx_bi[rx_ring->next_to_clean];
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  272  
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  273  	/* we are reusing so sync this buffer for CPU use */
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  274  	dma_sync_single_range_for_cpu(rx_ring->dev,
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  275  				      bi->dma, 0,
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  276  				      size,
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  277  				      DMA_BIDIRECTIONAL);
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  278  
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  279  	return bi;
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  280  }
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  281  
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  282  /**
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  283   * i40e_reuse_rx_buffer_zc - Recycle an Rx buffer
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  284   * @rx_ring: Rx ring
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  285   * @old_bi: The Rx buffer to recycle
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  286   *
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  287   * This function recycles a finished Rx buffer, and places it on the
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  288   * recycle queue (next_to_alloc).
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  289   **/
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  290  static void i40e_reuse_rx_buffer_zc(struct i40e_ring *rx_ring,
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  291  				    struct i40e_rx_buffer *old_bi)
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  292  {
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  293  	struct i40e_rx_buffer *new_bi = &rx_ring->rx_bi[rx_ring->next_to_alloc];
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  294  	u16 nta = rx_ring->next_to_alloc;
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  295  
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  296  	/* update, and store next to alloc */
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  297  	nta++;
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  298  	rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  299  
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  300  	/* transfer page from old buffer to new buffer */
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  301  	new_bi->dma = old_bi->dma;
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  302  	new_bi->addr = old_bi->addr;
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  303  	new_bi->handle = old_bi->handle;
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  304  
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  305  	old_bi->addr = NULL;
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  306  }
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  307  
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  308  /**
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  309   * i40e_zca_free - Free callback for MEM_TYPE_ZERO_COPY allocations
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  310   * @alloc: Zero-copy allocator
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  311   * @handle: Buffer handle
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  312   **/
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  313  void i40e_zca_free(struct zero_copy_allocator *alloc, unsigned long handle)
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  314  {
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  315  	struct i40e_rx_buffer *bi;
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  316  	struct i40e_ring *rx_ring;
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  317  	u64 hr, mask;
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  318  	u16 nta;
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  319  
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30 @320  	rx_ring = container_of(alloc, struct i40e_ring, zca);
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  321  	hr = rx_ring->xsk_umem->headroom + XDP_PACKET_HEADROOM;
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  322  	mask = rx_ring->xsk_umem->chunk_mask;
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  323  
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  324  	nta = rx_ring->next_to_alloc;
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  325  	bi = &rx_ring->rx_bi[nta];
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  326  
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  327  	nta++;
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  328  	rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  329  
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  330  	handle &= mask;
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  331  
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  332  	bi->dma = xdp_umem_get_dma(rx_ring->xsk_umem, handle);
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  333  	bi->dma += hr;
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  334  
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  335  	bi->addr = xdp_umem_get_data(rx_ring->xsk_umem, handle);
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  336  	bi->addr += hr;
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  337  
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  338  	bi->handle = xsk_umem_adjust_offset(rx_ring->xsk_umem, (u64)handle,
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  339  					    rx_ring->xsk_umem->headroom);
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  340  }
b530c4dd1d0830 Jesper Dangaard Brouer 2020-04-30  341  

:::::: The code at line 183 was first introduced by commit
:::::: 3b4f0b66c2b3dceea01bd26efa8c4c6f01b4961f i40e, xsk: Migrate to new MEM_TYPE_XSK_BUFF_POOL

:::::: TO: Bj?rn T?pel <bjorn.topel@intel.com>
:::::: CC: Alexei Starovoitov <ast@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 74120 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200526/67dfdf6a/attachment-0001.bin>
