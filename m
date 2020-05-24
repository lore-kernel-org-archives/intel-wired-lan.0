From: kbuild test robot <lkp@intel.com>
Date: Sun, 24 May 2020 19:16:54 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 50/99]
 drivers/net/ethernet/intel/ice/ice_base.c:421:39: error: 'struct xdp_umem'
 has no member named 'chunk_size_nohr'; did you mean 'chunk_size'?
Message-ID: <202005241935.mMMwwbiA%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   5950d1e508b225372208a78339e6434adf129852
commit: 307e0c99a4576106e2fb77e73ae82b514a3fd8ce [50/99] ice: Refactor ice_setup_rx_ctx
config: i386-allyesconfig (attached as .config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        git checkout 307e0c99a4576106e2fb77e73ae82b514a3fd8ce
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

drivers/net/ethernet/intel/ice/ice_base.c: In function 'ice_vsi_cfg_rxq':
>> drivers/net/ethernet/intel/ice/ice_base.c:421:39: error: 'struct xdp_umem' has no member named 'chunk_size_nohr'; did you mean 'chunk_size'?
ring->rx_buf_len = ring->xsk_umem->chunk_size_nohr -
^~~~~~~~~~~~~~~
chunk_size
>> drivers/net/ethernet/intel/ice/ice_base.c:423:8: error: 'struct ice_ring' has no member named 'zca'
ring->zca.free = ice_zca_free;
^~
>> drivers/net/ethernet/intel/ice/ice_base.c:423:21: error: 'ice_zca_free' undeclared (first use in this function); did you mean 'ice_get_res'?
ring->zca.free = ice_zca_free;
^~~~~~~~~~~~
ice_get_res
drivers/net/ethernet/intel/ice/ice_base.c:423:21: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/net/ethernet/intel/ice/ice_base.c:425:9: error: 'MEM_TYPE_ZERO_COPY' undeclared (first use in this function); did you mean 'MEM_TYPE_PAGE_POOL'?
MEM_TYPE_ZERO_COPY,
^~~~~~~~~~~~~~~~~~
MEM_TYPE_PAGE_POOL
drivers/net/ethernet/intel/ice/ice_base.c:426:14: error: 'struct ice_ring' has no member named 'zca'
&ring->zca);
^~
drivers/net/ethernet/intel/ice/ice_base.c:433:8: error: 'struct ice_ring' has no member named 'zca'
ring->zca.free = NULL;
^~
drivers/net/ethernet/intel/ice/ice_base.c:456:8: error: implicit declaration of function 'xsk_umem_has_addrs_rq'; did you mean 'xsk_umem_get_headroom'? [-Werror=implicit-function-declaration]
if (!xsk_umem_has_addrs_rq(ring->xsk_umem, num_bufs)) {
^~~~~~~~~~~~~~~~~~~~~
xsk_umem_get_headroom
drivers/net/ethernet/intel/ice/ice_base.c:464:9: error: implicit declaration of function 'ice_alloc_rx_bufs_slow_zc'; did you mean 'ice_alloc_rx_bufs_zc'? [-Werror=implicit-function-declaration]
err = ice_alloc_rx_bufs_slow_zc(ring, num_bufs);
^~~~~~~~~~~~~~~~~~~~~~~~~
ice_alloc_rx_bufs_zc
cc1: some warnings being treated as errors

vim +421 drivers/net/ethernet/intel/ice/ice_base.c

   396	
   397	/**
   398	 * ice_vsi_cfg_rxq - Configure an Rx queue
   399	 * @ring: the ring being configured
   400	 *
   401	 * Return 0 on success and a negative value on error.
   402	 */
   403	int ice_vsi_cfg_rxq(struct ice_ring *ring)
   404	{
   405		struct device *dev = ice_pf_to_dev(ring->vsi->back);
   406		u16 num_bufs = ICE_DESC_UNUSED(ring);
   407		int err;
   408	
   409		ring->rx_buf_len = ring->vsi->rx_buf_len;
   410	
   411		if (ring->vsi->type == ICE_VSI_PF) {
   412			if (!xdp_rxq_info_is_reg(&ring->xdp_rxq))
   413				/* coverity[check_return] */
   414				xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
   415						 ring->q_index);
   416	
   417			ring->xsk_umem = ice_xsk_umem(ring);
   418			if (ring->xsk_umem) {
   419				xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
   420	
 > 421				ring->rx_buf_len = ring->xsk_umem->chunk_size_nohr -
   422						   XDP_PACKET_HEADROOM;
 > 423				ring->zca.free = ice_zca_free;
   424				err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
 > 425								 MEM_TYPE_ZERO_COPY,
   426								 &ring->zca);
   427				if (err)
   428					return err;
   429	
   430				dev_info(dev, "Registered XDP mem model MEM_TYPE_ZERO_COPY on Rx ring %d\n",
   431					 ring->q_index);
   432			} else {
   433				ring->zca.free = NULL;
   434				if (!xdp_rxq_info_is_reg(&ring->xdp_rxq))
   435					/* coverity[check_return] */
   436					xdp_rxq_info_reg(&ring->xdp_rxq,
   437							 ring->netdev,
   438							 ring->q_index);
   439	
   440				err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
   441								 MEM_TYPE_PAGE_SHARED,
   442								 NULL);
   443				if (err)
   444					return err;
   445			}
   446		}
   447	
   448		err = ice_setup_rx_ctx(ring);
   449		if (err) {
   450			dev_err(dev, "ice_setup_rx_ctx failed for RxQ %d, err %d\n",
   451				ring->q_index, err);
   452			return err;
   453		}
   454	
   455		if (ring->xsk_umem) {
   456			if (!xsk_umem_has_addrs_rq(ring->xsk_umem, num_bufs)) {
   457				dev_warn(dev, "UMEM does not provide enough addresses to fill %d buffers on Rx ring %d\n",
   458					 num_bufs, ring->q_index);
   459				dev_warn(dev, "Change Rx ring/fill queue size to avoid performance issues\n");
   460	
   461				return 0;
   462			}
   463	
   464			err = ice_alloc_rx_bufs_slow_zc(ring, num_bufs);
   465			if (err) {
   466				u16 pf_q = ring->vsi->rxq_map[ring->q_index];
   467	
   468				dev_info(dev, "Failed to allocate some buffers on UMEM enabled Rx ring %d (pf_q %d)\n",
   469					 ring->q_index, pf_q);
   470			}
   471	
   472			return 0;
   473		}
   474	
   475		ice_alloc_rx_bufs(ring, num_bufs);
   476	
   477		return 0;
   478	}
   479	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 72601 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200524/f5174a28/attachment-0001.bin>
