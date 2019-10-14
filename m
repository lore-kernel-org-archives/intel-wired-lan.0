From: kbuild test robot <lkp@intel.com>
Date: Tue, 15 Oct 2019 04:25:54 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 53/66]
 drivers/net//ethernet/intel/ice/ice_txrx_lib.c:218:33: error: implicit
 declaration of function 'ice_build_ctob'; did you mean '__build_skb'?
Message-ID: <201910150442.Dj87jstp%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   ab6984b6134690d6345109a0679beabc0c52e2cf
commit: 6d188a7bb3705a9a6be7cb909f63eeeee90c3175 [53/66] ice: introduce frame padding computation logic
config: sparc64-allmodconfig (attached as .config)
compiler: sparc64-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 6d188a7bb3705a9a6be7cb909f63eeeee90c3175
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=sparc64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net//ethernet/intel/ice/ice_txrx_lib.c: In function 'ice_xmit_xdp_ring':
>> drivers/net//ethernet/intel/ice/ice_txrx_lib.c:218:33: error: implicit declaration of function 'ice_build_ctob'; did you mean '__build_skb'? [-Werror=implicit-function-declaration]
     tx_desc->cmd_type_offset_bsz = ice_build_ctob(ICE_TXD_LAST_DESC_CMD, 0,
                                    ^~~~~~~~~~~~~~
                                    __build_skb
   cc1: some warnings being treated as errors
--
   drivers/net//ethernet/intel/ice/ice_xsk.c: In function 'ice_xmit_zc':
>> drivers/net//ethernet/intel/ice/ice_xsk.c:980:4: error: implicit declaration of function 'ice_build_ctob'; did you mean 'ice_bump_ntc'? [-Werror=implicit-function-declaration]
       ice_build_ctob(ICE_TXD_LAST_DESC_CMD, 0, desc.len, 0);
       ^~~~~~~~~~~~~~
       ice_bump_ntc
   cc1: some warnings being treated as errors

vim +218 drivers/net//ethernet/intel/ice/ice_txrx_lib.c

8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  184  
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  185  /**
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  186   * ice_xmit_xdp_ring - submit single packet to XDP ring for transmission
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  187   * @data: packet data pointer
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  188   * @size: packet data size
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  189   * @xdp_ring: XDP ring for transmission
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  190   */
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  191  int ice_xmit_xdp_ring(void *data, u16 size, struct ice_ring *xdp_ring)
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  192  {
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  193  	u16 i = xdp_ring->next_to_use;
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  194  	struct ice_tx_desc *tx_desc;
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  195  	struct ice_tx_buf *tx_buf;
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  196  	dma_addr_t dma;
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  197  
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  198  	if (!unlikely(ICE_DESC_UNUSED(xdp_ring))) {
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  199  		xdp_ring->tx_stats.tx_busy++;
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  200  		return ICE_XDP_CONSUMED;
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  201  	}
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  202  
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  203  	dma = dma_map_single(xdp_ring->dev, data, size, DMA_TO_DEVICE);
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  204  	if (dma_mapping_error(xdp_ring->dev, dma))
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  205  		return ICE_XDP_CONSUMED;
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  206  
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  207  	tx_buf = &xdp_ring->tx_buf[i];
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  208  	tx_buf->bytecount = size;
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  209  	tx_buf->gso_segs = 1;
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  210  	tx_buf->raw_buf = data;
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  211  
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  212  	/* record length, and DMA address */
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  213  	dma_unmap_len_set(tx_buf, len, size);
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  214  	dma_unmap_addr_set(tx_buf, dma, dma);
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  215  
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  216  	tx_desc = ICE_TX_DESC(xdp_ring, i);
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  217  	tx_desc->buf_addr = cpu_to_le64(dma);
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14 @218  	tx_desc->cmd_type_offset_bsz = ice_build_ctob(ICE_TXD_LAST_DESC_CMD, 0,
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  219  						      size, 0);
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  220  
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  221  	/* Make certain all of the status bits have been updated
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  222  	 * before next_to_watch is written.
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  223  	 */
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  224  	smp_wmb();
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  225  
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  226  	i++;
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  227  	if (i == xdp_ring->count)
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  228  		i = 0;
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  229  
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  230  	tx_buf->next_to_watch = tx_desc;
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  231  	xdp_ring->next_to_use = i;
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  232  
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  233  	return ICE_XDP_TX;
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  234  }
8a789a8138dfec Krzysztof Kazimierczak 2019-10-14  235  

:::::: The code at line 218 was first introduced by commit
:::::: 8a789a8138dfecdc09758b800a1808ec3fdc01b3 ice: Move common functions to ice_txrx_lib.c

:::::: TO: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59095 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20191015/2546220b/attachment-0001.bin>
