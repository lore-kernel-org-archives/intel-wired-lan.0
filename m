From: kbuild test robot <lkp@intel.com>
Date: Thu, 7 Jun 2018 23:31:40 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 20/20]
 drivers/net/ethernet/intel/i40e/i40e_xsk.c:330:29: warning: cast from
 pointer to integer of different size
Message-ID: <201806072337.r2NWb4Ec%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   5d74b2e4f75d0c1a8be2a395a8b5ddba661ecccf
commit: 5d74b2e4f75d0c1a8be2a395a8b5ddba661ecccf [20/20] i40e: implement AF_XDP zero-copy support for Rx
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        git checkout 5d74b2e4f75d0c1a8be2a395a8b5ddba661ecccf
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_xsk.c: In function 'i40e_reuse_rx_buffer_zc':
>> drivers/net/ethernet/intel/i40e/i40e_xsk.c:330:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     new_buff->addr  = (void *)((u64)old_buff->addr & mask);
                                ^
>> drivers/net/ethernet/intel/i40e/i40e_xsk.c:330:20: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     new_buff->addr  = (void *)((u64)old_buff->addr & mask);
                       ^

vim +330 drivers/net/ethernet/intel/i40e/i40e_xsk.c

   313	
   314	static void i40e_reuse_rx_buffer_zc(struct i40e_ring *rx_ring,
   315					    struct i40e_rx_buffer *old_buff)
   316	{
   317		u64 mask = rx_ring->xsk_umem->props.chunk_mask;
   318		u64 hr = rx_ring->xsk_umem->headroom;
   319		u16 nta = rx_ring->next_to_alloc;
   320		struct i40e_rx_buffer *new_buff;
   321	
   322		new_buff = &rx_ring->rx_bi[nta];
   323	
   324		/* update, and store next to alloc */
   325		nta++;
   326		rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
   327	
   328		/* transfer page from old buffer to new buffer */
   329		new_buff->dma		= old_buff->dma & mask;
 > 330		new_buff->addr		= (void *)((u64)old_buff->addr & mask);
   331		new_buff->handle	= old_buff->handle & mask;
   332	
   333		new_buff->dma += hr + XDP_PACKET_HEADROOM;
   334		new_buff->addr += hr + XDP_PACKET_HEADROOM;
   335		new_buff->handle += hr;
   336	}
   337	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 63203 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180607/00e1b505/attachment-0001.bin>
