From: kbuild test robot <lkp@intel.com>
Date: Tue, 9 Jul 2019 14:49:49 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 9/51]
 drivers/net/ethernet/intel/ice/ice_xsk.c:717:3: note: in expansion of macro
 'if'
Message-ID: <201907091400.8uzMC5I2%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   46065ef1595f1bba9b1c9ed45cb501b95ea23259
commit: c2d44b271ae1b5311a3eb2cb8e1215f16f53485a [9/51] ice: Add support for AF_XDP
config: i386-randconfig-x013-201927 (attached as .config)
compiler: gcc-7 (Debian 7.4.0-6) 7.4.0
reproduce:
        git checkout c2d44b271ae1b5311a3eb2cb8e1215f16f53485a
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/export.h:45:0,
                    from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from drivers/net/ethernet/intel/ice/ice.h:9,
                    from drivers/net/ethernet/intel/ice/ice_xsk.c:4:
   drivers/net/ethernet/intel/ice/ice_xsk.c: In function 'ice_xmit_zc':
   drivers/net/ethernet/intel/ice/ice_xsk.c:717:48: error: passing argument 2 of 'xsk_umem_consume_tx' from incompatible pointer type [-Werror=incompatible-pointer-types]
      if (!xsk_umem_consume_tx(xdp_ring->xsk_umem, &dma, &len))
                                                   ^
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                       ^~~~
>> drivers/net/ethernet/intel/ice/ice_xsk.c:717:3: note: in expansion of macro 'if'
      if (!xsk_umem_consume_tx(xdp_ring->xsk_umem, &dma, &len))
      ^~
   In file included from drivers/net/ethernet/intel/ice/ice.h:37:0,
                    from drivers/net/ethernet/intel/ice/ice_xsk.c:4:
   include/net/xdp_sock.h:84:6: note: expected 'struct xdp_desc *' but argument is of type 'dma_addr_t * {aka unsigned int *}'
    bool xsk_umem_consume_tx(struct xdp_umem *umem, struct xdp_desc *desc);
         ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/export.h:45:0,
                    from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from drivers/net/ethernet/intel/ice/ice.h:9,
                    from drivers/net/ethernet/intel/ice/ice_xsk.c:4:
   drivers/net/ethernet/intel/ice/ice_xsk.c:717:8: error: too many arguments to function 'xsk_umem_consume_tx'
      if (!xsk_umem_consume_tx(xdp_ring->xsk_umem, &dma, &len))
           ^
   include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                       ^~~~
>> drivers/net/ethernet/intel/ice/ice_xsk.c:717:3: note: in expansion of macro 'if'
      if (!xsk_umem_consume_tx(xdp_ring->xsk_umem, &dma, &len))
      ^~
   In file included from drivers/net/ethernet/intel/ice/ice.h:37:0,
                    from drivers/net/ethernet/intel/ice/ice_xsk.c:4:
   include/net/xdp_sock.h:84:6: note: declared here
    bool xsk_umem_consume_tx(struct xdp_umem *umem, struct xdp_desc *desc);
         ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/export.h:45:0,
                    from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from drivers/net/ethernet/intel/ice/ice.h:9,
                    from drivers/net/ethernet/intel/ice/ice_xsk.c:4:
   drivers/net/ethernet/intel/ice/ice_xsk.c:717:48: error: passing argument 2 of 'xsk_umem_consume_tx' from incompatible pointer type [-Werror=incompatible-pointer-types]
      if (!xsk_umem_consume_tx(xdp_ring->xsk_umem, &dma, &len))
                                                   ^
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                ^~~~
>> drivers/net/ethernet/intel/ice/ice_xsk.c:717:3: note: in expansion of macro 'if'
      if (!xsk_umem_consume_tx(xdp_ring->xsk_umem, &dma, &len))
      ^~
   In file included from drivers/net/ethernet/intel/ice/ice.h:37:0,
                    from drivers/net/ethernet/intel/ice/ice_xsk.c:4:
   include/net/xdp_sock.h:84:6: note: expected 'struct xdp_desc *' but argument is of type 'dma_addr_t * {aka unsigned int *}'
    bool xsk_umem_consume_tx(struct xdp_umem *umem, struct xdp_desc *desc);
         ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/export.h:45:0,
                    from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from drivers/net/ethernet/intel/ice/ice.h:9,
                    from drivers/net/ethernet/intel/ice/ice_xsk.c:4:
   drivers/net/ethernet/intel/ice/ice_xsk.c:717:8: error: too many arguments to function 'xsk_umem_consume_tx'
      if (!xsk_umem_consume_tx(xdp_ring->xsk_umem, &dma, &len))
           ^
   include/linux/compiler.h:58:61: note: in definition of macro '__trace_if_var'
    #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                ^~~~
>> drivers/net/ethernet/intel/ice/ice_xsk.c:717:3: note: in expansion of macro 'if'
      if (!xsk_umem_consume_tx(xdp_ring->xsk_umem, &dma, &len))
      ^~
   In file included from drivers/net/ethernet/intel/ice/ice.h:37:0,
                    from drivers/net/ethernet/intel/ice/ice_xsk.c:4:
   include/net/xdp_sock.h:84:6: note: declared here
    bool xsk_umem_consume_tx(struct xdp_umem *umem, struct xdp_desc *desc);
         ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/export.h:45:0,
                    from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from drivers/net/ethernet/intel/ice/ice.h:9,
                    from drivers/net/ethernet/intel/ice/ice_xsk.c:4:
   drivers/net/ethernet/intel/ice/ice_xsk.c:717:48: error: passing argument 2 of 'xsk_umem_consume_tx' from incompatible pointer type [-Werror=incompatible-pointer-types]
      if (!xsk_umem_consume_tx(xdp_ring->xsk_umem, &dma, &len))
                                                   ^
   include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
     (cond) ?     \
      ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                               ^~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/ice/ice_xsk.c:717:3: note: in expansion of macro 'if'
      if (!xsk_umem_consume_tx(xdp_ring->xsk_umem, &dma, &len))
      ^~
   In file included from drivers/net/ethernet/intel/ice/ice.h:37:0,
                    from drivers/net/ethernet/intel/ice/ice_xsk.c:4:
   include/net/xdp_sock.h:84:6: note: expected 'struct xdp_desc *' but argument is of type 'dma_addr_t * {aka unsigned int *}'
    bool xsk_umem_consume_tx(struct xdp_umem *umem, struct xdp_desc *desc);
         ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/export.h:45:0,
                    from include/linux/linkage.h:7,
                    from include/linux/kernel.h:8,
                    from drivers/net/ethernet/intel/ice/ice.h:9,
                    from drivers/net/ethernet/intel/ice/ice_xsk.c:4:
   drivers/net/ethernet/intel/ice/ice_xsk.c:717:8: error: too many arguments to function 'xsk_umem_consume_tx'
      if (!xsk_umem_consume_tx(xdp_ring->xsk_umem, &dma, &len))
           ^
   include/linux/compiler.h:69:3: note: in definition of macro '__trace_if_value'
     (cond) ?     \
      ^~~~
   include/linux/compiler.h:56:28: note: in expansion of macro '__trace_if_var'
    #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                               ^~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/ice/ice_xsk.c:717:3: note: in expansion of macro 'if'
      if (!xsk_umem_consume_tx(xdp_ring->xsk_umem, &dma, &len))
      ^~
   In file included from drivers/net/ethernet/intel/ice/ice.h:37:0,
                    from drivers/net/ethernet/intel/ice/ice_xsk.c:4:
   include/net/xdp_sock.h:84:6: note: declared here
    bool xsk_umem_consume_tx(struct xdp_umem *umem, struct xdp_desc *desc);
         ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/if +717 drivers/net/ethernet/intel/ice/ice_xsk.c

   693	
   694	/**
   695	 * ice_xmit_zc - Completes AF_XDP entries, and cleans XDP entries
   696	 * @xdp_ring: XDP Tx ring
   697	 * @budget: used to determine if we are in netpoll
   698	 *
   699	 * Returns true if cleanup/transmission is done.
   700	 */
   701	static bool ice_xmit_zc(struct ice_ring *xdp_ring, int budget)
   702	{
   703		struct ice_tx_desc *tx_desc = NULL;
   704		bool work_done = true;
   705		dma_addr_t dma;
   706		u32 len;
   707	
   708		while (likely(budget-- > 0)) {
   709			struct ice_tx_buf *tx_buf;
   710	
   711			if (!unlikely(ICE_DESC_UNUSED(xdp_ring))) {
   712				xdp_ring->tx_stats.tx_busy++;
   713				work_done = false;
   714				break;
   715			}
   716	
 > 717			if (!xsk_umem_consume_tx(xdp_ring->xsk_umem, &dma, &len))
   718				break;
   719	
   720			dma_sync_single_for_device(xdp_ring->dev, dma, len,
   721						   DMA_BIDIRECTIONAL);
   722	
   723			tx_buf = &xdp_ring->tx_buf[xdp_ring->next_to_use];
   724			tx_buf->bytecount = len;
   725	
   726			tx_desc = ICE_TX_DESC(xdp_ring, xdp_ring->next_to_use);
   727			tx_desc->buf_addr = cpu_to_le64(dma);
   728			tx_desc->cmd_type_offset_bsz =
   729				ice_build_ctob(ICE_TX_DESC_CMD_EOP | ICE_TX_DESC_CMD_RS,
   730					       0, len, 0);
   731	
   732			xdp_ring->next_to_use++;
   733	
   734			if (xdp_ring->next_to_use == xdp_ring->count)
   735				xdp_ring->next_to_use = 0;
   736		}
   737	
   738		if (tx_desc) {
   739			ice_xdp_ring_update_tail(xdp_ring);
   740			xsk_umem_consume_tx_done(xdp_ring->xsk_umem);
   741		}
   742	
   743		return !!budget && work_done;
   744	}
   745	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 35333 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190709/e5b6014d/attachment-0001.bin>
