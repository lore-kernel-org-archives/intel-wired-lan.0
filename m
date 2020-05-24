From: kbuild test robot <lkp@intel.com>
Date: Sun, 24 May 2020 18:41:49 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 49/99]
 drivers/net/ethernet/intel/ice/ice_base.c:432:8: error: implicit
 declaration of function 'xsk_umem_has_addrs_rq';
 did you mean 'xsk_umem_get_headroom'?
Message-ID: <202005241823.aF92KNWa%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   5950d1e508b225372208a78339e6434adf129852
commit: ee9a9330eddc09067644982f3981dc21ab863451 [49/99] ice: Check UMEM FQ size when allocating bufs
config: i386-allyesconfig (attached as .config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        git checkout ee9a9330eddc09067644982f3981dc21ab863451
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

drivers/net/ethernet/intel/ice/ice_base.c: In function 'ice_setup_rx_ctx':
>> drivers/net/ethernet/intel/ice/ice_base.c:432:8: error: implicit declaration of function 'xsk_umem_has_addrs_rq'; did you mean 'xsk_umem_get_headroom'? [-Werror=implicit-function-declaration]
if (!xsk_umem_has_addrs_rq(ring->xsk_umem, num_bufs)) {
^~~~~~~~~~~~~~~~~~~~~
xsk_umem_get_headroom
>> drivers/net/ethernet/intel/ice/ice_base.c:440:9: error: implicit declaration of function 'ice_alloc_rx_bufs_slow_zc'; did you mean 'ice_alloc_rx_bufs_zc'? [-Werror=implicit-function-declaration]
err = ice_alloc_rx_bufs_slow_zc(ring, num_bufs);
^~~~~~~~~~~~~~~~~~~~~~~~~
ice_alloc_rx_bufs_zc
cc1: some warnings being treated as errors

vim +432 drivers/net/ethernet/intel/ice/ice_base.c

   275	
   276	/**
   277	 * ice_setup_rx_ctx - Configure a receive ring context
   278	 * @ring: The Rx ring to configure
   279	 *
   280	 * Configure the Rx descriptor ring in RLAN context.
   281	 */
   282	int ice_setup_rx_ctx(struct ice_ring *ring)
   283	{
   284		struct device *dev = ice_pf_to_dev(ring->vsi->back);
   285		int chain_len = ICE_MAX_CHAINED_RX_BUFS;
   286		u16 num_bufs = ICE_DESC_UNUSED(ring);
   287		struct ice_vsi *vsi = ring->vsi;
   288		u32 rxdid = ICE_RXDID_FLEX_NIC;
   289		struct ice_rlan_ctx rlan_ctx;
   290		struct ice_hw *hw;
   291		u32 regval;
   292		u16 pf_q;
   293		int err;
   294	
   295		hw = &vsi->back->hw;
   296	
   297		/* what is Rx queue number in global space of 2K Rx queues */
   298		pf_q = vsi->rxq_map[ring->q_index];
   299	
   300		/* clear the context structure first */
   301		memset(&rlan_ctx, 0, sizeof(rlan_ctx));
   302	
   303		ring->rx_buf_len = vsi->rx_buf_len;
   304	
   305		if (ring->vsi->type == ICE_VSI_PF) {
   306			if (!xdp_rxq_info_is_reg(&ring->xdp_rxq))
   307				/* coverity[check_return] */
   308				xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
   309						 ring->q_index);
   310	
   311			ring->xsk_umem = ice_xsk_umem(ring);
   312			if (ring->xsk_umem) {
   313				xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
   314	
   315				ring->rx_buf_len =
   316					xsk_umem_get_rx_frame_size(ring->xsk_umem);
   317				/* For AF_XDP ZC, we disallow packets to span on
   318				 * multiple buffers, thus letting us skip that
   319				 * handling in the fast-path.
   320				 */
   321				chain_len = 1;
   322				err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
   323								 MEM_TYPE_XSK_BUFF_POOL,
   324								 NULL);
   325				if (err)
   326					return err;
   327				xsk_buff_set_rxq_info(ring->xsk_umem, &ring->xdp_rxq);
   328	
   329				dev_info(dev, "Registered XDP mem model MEM_TYPE_ZERO_COPY on Rx ring %d\n",
   330					 ring->q_index);
   331			} else {
   332				if (!xdp_rxq_info_is_reg(&ring->xdp_rxq))
   333					/* coverity[check_return] */
   334					xdp_rxq_info_reg(&ring->xdp_rxq,
   335							 ring->netdev,
   336							 ring->q_index);
   337	
   338				err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
   339								 MEM_TYPE_PAGE_SHARED,
   340								 NULL);
   341				if (err)
   342					return err;
   343			}
   344		}
   345		/* Receive Queue Base Address.
   346		 * Indicates the starting address of the descriptor queue defined in
   347		 * 128 Byte units.
   348		 */
   349		rlan_ctx.base = ring->dma >> 7;
   350	
   351		rlan_ctx.qlen = ring->count;
   352	
   353		/* Receive Packet Data Buffer Size.
   354		 * The Packet Data Buffer Size is defined in 128 byte units.
   355		 */
   356		rlan_ctx.dbuf = ring->rx_buf_len >> ICE_RLAN_CTX_DBUF_S;
   357	
   358		/* use 32 byte descriptors */
   359		rlan_ctx.dsize = 1;
   360	
   361		/* Strip the Ethernet CRC bytes before the packet is posted to host
   362		 * memory.
   363		 */
   364		rlan_ctx.crcstrip = 1;
   365	
   366		/* L2TSEL flag defines the reported L2 Tags in the receive descriptor */
   367		rlan_ctx.l2tsel = 1;
   368	
   369		rlan_ctx.dtype = ICE_RX_DTYPE_NO_SPLIT;
   370		rlan_ctx.hsplit_0 = ICE_RLAN_RX_HSPLIT_0_NO_SPLIT;
   371		rlan_ctx.hsplit_1 = ICE_RLAN_RX_HSPLIT_1_NO_SPLIT;
   372	
   373		/* This controls whether VLAN is stripped from inner headers
   374		 * The VLAN in the inner L2 header is stripped to the receive
   375		 * descriptor if enabled by this flag.
   376		 */
   377		rlan_ctx.showiv = 0;
   378	
   379		/* Max packet size for this queue - must not be set to a larger value
   380		 * than 5 x DBUF
   381		 */
   382		rlan_ctx.rxmax = min_t(u32, vsi->max_frame,
   383				       chain_len * ring->rx_buf_len);
   384	
   385		/* Rx queue threshold in units of 64 */
   386		rlan_ctx.lrxqthresh = 1;
   387	
   388		 /* Enable Flexible Descriptors in the queue context which
   389		  * allows this driver to select a specific receive descriptor format
   390		  */
   391		regval = rd32(hw, QRXFLXP_CNTXT(pf_q));
   392		if (vsi->type != ICE_VSI_VF) {
   393			regval |= (rxdid << QRXFLXP_CNTXT_RXDID_IDX_S) &
   394				QRXFLXP_CNTXT_RXDID_IDX_M;
   395	
   396			/* increasing context priority to pick up profile ID;
   397			 * default is 0x01; setting to 0x03 to ensure profile
   398			 * is programming if prev context is of same priority
   399			 */
   400			regval |= (0x03 << QRXFLXP_CNTXT_RXDID_PRIO_S) &
   401				QRXFLXP_CNTXT_RXDID_PRIO_M;
   402	
   403		} else {
   404			regval &= ~(QRXFLXP_CNTXT_RXDID_IDX_M |
   405				    QRXFLXP_CNTXT_RXDID_PRIO_M |
   406				    QRXFLXP_CNTXT_TS_M);
   407		}
   408		wr32(hw, QRXFLXP_CNTXT(pf_q), regval);
   409	
   410		/* Absolute queue number out of 2K needs to be passed */
   411		err = ice_write_rxq_ctx(hw, &rlan_ctx, pf_q);
   412		if (err) {
   413			dev_err(dev, "Failed to set LAN Rx queue context for absolute Rx queue %d error: %d\n",
   414				pf_q, err);
   415			return -EIO;
   416		}
   417	
   418		if (vsi->type == ICE_VSI_VF)
   419			return 0;
   420	
   421		/* configure Rx buffer alignment */
   422		if (!vsi->netdev || test_bit(ICE_FLAG_LEGACY_RX, vsi->back->flags))
   423			ice_clear_ring_build_skb_ena(ring);
   424		else
   425			ice_set_ring_build_skb_ena(ring);
   426	
   427		/* init queue specific tail register */
   428		ring->tail = hw->hw_addr + QRX_TAIL(pf_q);
   429		writel(0, ring->tail);
   430	
   431		if (ring->xsk_umem) {
 > 432			if (!xsk_umem_has_addrs_rq(ring->xsk_umem, num_bufs)) {
   433				dev_warn(dev, "UMEM does not provide enough addresses to fill %d buffers on Rx ring %d\n",
   434					 num_bufs, ring->q_index);
   435				dev_warn(dev, "Change Rx ring/fill queue size to avoid performance issues\n");
   436	
   437				return 0;
   438			}
   439	
 > 440			err = ice_alloc_rx_bufs_slow_zc(ring, num_bufs);
   441			if (err)
   442				dev_info(dev, "Failed to allocate some buffers on UMEM enabled Rx ring %d (pf_q %d)\n",
   443					 ring->q_index, pf_q);
   444			return 0;
   445		}
   446	
   447		ice_alloc_rx_bufs(ring, num_bufs);
   448	
   449		return 0;
   450	}
   451	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 72601 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200524/38139aaa/attachment-0001.bin>
