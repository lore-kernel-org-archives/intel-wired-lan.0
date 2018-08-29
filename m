From: kbuild test robot <lkp@intel.com>
Date: Wed, 29 Aug 2018 12:55:36 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 46/47]
 drivers/net//ethernet/intel/i40e/i40e_xsk.c:709:32: warning: 'tx_desc' may
 be used uninitialized in this function
Message-ID: <201808291234.d7fWsl5p%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   f0fd160d93655114cc9999fd689e546acb7fb82b
commit: 3605612ea81dbc67e419f0d78a918df397e9bc61 [46/47] i40e: add AF_XDP zero-copy Tx support
config: mips-allyesconfig (attached as .config)
compiler: mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 3605612ea81dbc67e419f0d78a918df397e9bc61
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=mips 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers/net//ethernet/intel/i40e/i40e_xsk.c: In function 'i40e_clean_xdp_tx_irq':
>> drivers/net//ethernet/intel/i40e/i40e_xsk.c:709:32: warning: 'tx_desc' may be used uninitialized in this function [-Wmaybe-uninitialized]
      tx_desc->cmd_type_offset_bsz |= (I40E_TX_DESC_CMD_RS <<
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
           I40E_TXD_QW1_CMD_SHIFT);
           ~~~~~~~~~~~~~~~~~~~~~~~  
   drivers/net//ethernet/intel/i40e/i40e_xsk.c:673:23: note: 'tx_desc' was declared here
     struct i40e_tx_desc *tx_desc;
                          ^~~~~~~

vim +/tx_desc +709 drivers/net//ethernet/intel/i40e/i40e_xsk.c

   661	
   662	/**
   663	 * i40e_xmit_zc - Performs zero-copy Tx AF_XDP
   664	 * @xdp_ring: XDP Tx ring
   665	 * @budget: NAPI budget
   666	 *
   667	 * Returns true if the work is finished.
   668	 **/
   669	static bool i40e_xmit_zc(struct i40e_ring *xdp_ring, unsigned int budget)
   670	{
   671		unsigned int total_packets = 0;
   672		struct i40e_tx_buffer *tx_bi;
   673		struct i40e_tx_desc *tx_desc;
   674		bool work_done = true;
   675		dma_addr_t dma;
   676		u32 len;
   677	
   678		while (budget-- > 0) {
   679			if (!unlikely(I40E_DESC_UNUSED(xdp_ring))) {
   680				xdp_ring->tx_stats.tx_busy++;
   681				work_done = false;
   682				break;
   683			}
   684	
   685			if (!xsk_umem_consume_tx(xdp_ring->xsk_umem, &dma, &len))
   686				break;
   687	
   688			dma_sync_single_for_device(xdp_ring->dev, dma, len,
   689						   DMA_BIDIRECTIONAL);
   690	
   691			tx_bi = &xdp_ring->tx_bi[xdp_ring->next_to_use];
   692			tx_bi->bytecount = len;
   693	
   694			tx_desc = I40E_TX_DESC(xdp_ring, xdp_ring->next_to_use);
   695			tx_desc->buffer_addr = cpu_to_le64(dma);
   696			tx_desc->cmd_type_offset_bsz =
   697				build_ctob(I40E_TX_DESC_CMD_ICRC
   698					   | I40E_TX_DESC_CMD_EOP,
   699					   0, len, 0);
   700			total_packets++;
   701	
   702			xdp_ring->next_to_use++;
   703			if (xdp_ring->next_to_use == xdp_ring->count)
   704				xdp_ring->next_to_use = 0;
   705		}
   706	
   707		if (total_packets > 0) {
   708			/* Request an interrupt for the last frame and bump tail ptr. */
 > 709			tx_desc->cmd_type_offset_bsz |= (I40E_TX_DESC_CMD_RS <<
   710							 I40E_TXD_QW1_CMD_SHIFT);
   711			i40e_xdp_ring_update_tail(xdp_ring);
   712	
   713			xsk_umem_consume_tx_done(xdp_ring->xsk_umem);
   714		}
   715	
   716		return !!budget && work_done;
   717	}
   718	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 57507 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180829/5cda2d94/attachment-0001.bin>
