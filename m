From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 26 Jun 2020 12:46:46 +0300
Subject: [Intel-wired-lan] [PATCH 1/1] igb: add XDP support
In-Reply-To: <20200625155014.6zwfoqqyhsvwu2gc@SvensMacBookAir.sven.lan>
Message-ID: <20200626094646.GI2549@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Sven,

url:    https://github.com/0day-ci/linux/commits/Sven-Auhagen/igb-add-XDP-support/20200626-052800
base:    48778464bb7d346b47157d21ffde2af6b2d39110
config: x86_64-randconfig-m001-20200624 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-13) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/net/ethernet/intel/igb/igb_main.c:8776 igb_clean_rx_irq() error: 'skb' dereferencing possible ERR_PTR()

# https://github.com/0day-ci/linux/commit/a15be27894f18e2bdb3b0958b1132af85e34e61c
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout a15be27894f18e2bdb3b0958b1132af85e34e61c
vim +/skb +8776 drivers/net/ethernet/intel/igb/igb_main.c

57ba34c9b068f3 drivers/net/ethernet/intel/igb/igb_main.c Eric W. Biederman 2014-03-14  8697  	while (likely(total_packets < budget)) {
2e334eee9bef61 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2012-09-25  8698  		union e1000_adv_rx_desc *rx_desc;
e014272672b964 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2017-02-06  8699  		struct igb_rx_buffer *rx_buffer;
e014272672b964 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2017-02-06  8700  		unsigned int size;
1a1c225b946303 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2012-09-25  8701  
2e334eee9bef61 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2012-09-25  8702  		/* return some buffers to hardware, one@a time is too slow */
2e334eee9bef61 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2012-09-25  8703  		if (cleaned_count >= IGB_RX_BUFFER_WRITE) {
2e334eee9bef61 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2012-09-25  8704  			igb_alloc_rx_buffers(rx_ring, cleaned_count);
2e334eee9bef61 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2012-09-25  8705  			cleaned_count = 0;
2e334eee9bef61 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2012-09-25  8706  		}
1a1c225b946303 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2012-09-25  8707  
2e334eee9bef61 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2012-09-25  8708  		rx_desc = IGB_RX_DESC(rx_ring, rx_ring->next_to_clean);
e014272672b964 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2017-02-06  8709  		size = le16_to_cpu(rx_desc->wb.upper.length);
e014272672b964 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2017-02-06  8710  		if (!size)
1a1c225b946303 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2012-09-25  8711  			break;
9d5c824399dea8 drivers/net/igb/igb_main.c                Auke Kok          2008-01-24  8712  
74e238eada5735 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2013-02-02  8713  		/* This memory barrier is needed to keep us from reading
74e238eada5735 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2013-02-02  8714  		 * any other fields out of the rx_desc until we know the
124b74c18e0e31 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2014-12-11  8715  		 * descriptor has been written back
74e238eada5735 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2013-02-02  8716  		 */
124b74c18e0e31 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2014-12-11  8717  		dma_rmb();
74e238eada5735 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2013-02-02  8718  
e014272672b964 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2017-02-06  8719  		rx_buffer = igb_get_rx_buffer(rx_ring, size);
e014272672b964 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2017-02-06  8720  
2e334eee9bef61 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2012-09-25  8721  		/* retrieve a buffer from the ring */
a15be27894f18e drivers/net/ethernet/intel/igb/igb_main.c Sven Auhagen      2020-06-25  8722  		if (!skb) {
a15be27894f18e drivers/net/ethernet/intel/igb/igb_main.c Sven Auhagen      2020-06-25  8723  			xdp.data = page_address(rx_buffer->page) +
a15be27894f18e drivers/net/ethernet/intel/igb/igb_main.c Sven Auhagen      2020-06-25  8724  				   rx_buffer->page_offset;
a15be27894f18e drivers/net/ethernet/intel/igb/igb_main.c Sven Auhagen      2020-06-25  8725  			xdp.data_meta = xdp.data;
a15be27894f18e drivers/net/ethernet/intel/igb/igb_main.c Sven Auhagen      2020-06-25  8726  			xdp.data_hard_start = xdp.data -
a15be27894f18e drivers/net/ethernet/intel/igb/igb_main.c Sven Auhagen      2020-06-25  8727  					      igb_rx_offset(rx_ring);
a15be27894f18e drivers/net/ethernet/intel/igb/igb_main.c Sven Auhagen      2020-06-25  8728  			xdp.data_end = xdp.data + size;
a15be27894f18e drivers/net/ethernet/intel/igb/igb_main.c Sven Auhagen      2020-06-25  8729  #if (PAGE_SIZE > 4096)
a15be27894f18e drivers/net/ethernet/intel/igb/igb_main.c Sven Auhagen      2020-06-25  8730  			/* At larger PAGE_SIZE, frame_sz depend on len size */
a15be27894f18e drivers/net/ethernet/intel/igb/igb_main.c Sven Auhagen      2020-06-25  8731  			xdp.frame_sz = igb_rx_frame_truesize(rx_ring, size);
a15be27894f18e drivers/net/ethernet/intel/igb/igb_main.c Sven Auhagen      2020-06-25  8732  #endif
a15be27894f18e drivers/net/ethernet/intel/igb/igb_main.c Sven Auhagen      2020-06-25  8733  			skb = igb_run_xdp(adapter, rx_ring, &xdp);
a15be27894f18e drivers/net/ethernet/intel/igb/igb_main.c Sven Auhagen      2020-06-25  8734  		}
a15be27894f18e drivers/net/ethernet/intel/igb/igb_main.c Sven Auhagen      2020-06-25  8735  
a15be27894f18e drivers/net/ethernet/intel/igb/igb_main.c Sven Auhagen      2020-06-25  8736  		if (IS_ERR(skb)) {
                                                                                                                   ^^^
This is an error pointer.

a15be27894f18e drivers/net/ethernet/intel/igb/igb_main.c Sven Auhagen      2020-06-25  8737  			unsigned int xdp_res = -PTR_ERR(skb);
a15be27894f18e drivers/net/ethernet/intel/igb/igb_main.c Sven Auhagen      2020-06-25  8738  
a15be27894f18e drivers/net/ethernet/intel/igb/igb_main.c Sven Auhagen      2020-06-25  8739  			if (xdp_res & (IGB_XDP_TX | IGB_XDP_REDIR)) {
a15be27894f18e drivers/net/ethernet/intel/igb/igb_main.c Sven Auhagen      2020-06-25  8740  				xdp_xmit |= xdp_res;
a15be27894f18e drivers/net/ethernet/intel/igb/igb_main.c Sven Auhagen      2020-06-25  8741  				igb_rx_buffer_flip(rx_ring, rx_buffer, size);
a15be27894f18e drivers/net/ethernet/intel/igb/igb_main.c Sven Auhagen      2020-06-25  8742  			} else {
a15be27894f18e drivers/net/ethernet/intel/igb/igb_main.c Sven Auhagen      2020-06-25  8743  				rx_buffer->pagecnt_bias++;
a15be27894f18e drivers/net/ethernet/intel/igb/igb_main.c Sven Auhagen      2020-06-25  8744  			}
a15be27894f18e drivers/net/ethernet/intel/igb/igb_main.c Sven Auhagen      2020-06-25  8745  			total_packets++;
a15be27894f18e drivers/net/ethernet/intel/igb/igb_main.c Sven Auhagen      2020-06-25  8746  			total_bytes += size;
a15be27894f18e drivers/net/ethernet/intel/igb/igb_main.c Sven Auhagen      2020-06-25  8747  		} else if (skb)
e014272672b964 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2017-02-06  8748  			igb_add_rx_frag(rx_ring, rx_buffer, skb, size);
b1bb2eb0a0deb0 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2017-02-06  8749  		else if (ring_uses_build_skb(rx_ring))
a15be27894f18e drivers/net/ethernet/intel/igb/igb_main.c Sven Auhagen      2020-06-25  8750  			skb = igb_build_skb(rx_ring, rx_buffer, &xdp, rx_desc);
e014272672b964 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2017-02-06  8751  		else
e014272672b964 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2017-02-06  8752  			skb = igb_construct_skb(rx_ring, rx_buffer,
a15be27894f18e drivers/net/ethernet/intel/igb/igb_main.c Sven Auhagen      2020-06-25  8753  						&xdp, rx_desc);
9d5c824399dea8 drivers/net/igb/igb_main.c                Auke Kok          2008-01-24  8754  
2e334eee9bef61 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2012-09-25  8755  		/* exit if we failed to retrieve a buffer */
e014272672b964 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2017-02-06  8756  		if (!skb) {
                                                                                                            ^^^^
Should this be an IS_ERR_OR_NULL() check?

e014272672b964 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2017-02-06  8757  			rx_ring->rx_stats.alloc_failed++;
e014272672b964 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2017-02-06  8758  			rx_buffer->pagecnt_bias++;
2e334eee9bef61 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2012-09-25  8759  			break;
e014272672b964 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2017-02-06  8760  		}
cbc8e55f6fdae2 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2012-09-25  8761  
e014272672b964 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2017-02-06  8762  		igb_put_rx_buffer(rx_ring, rx_buffer);
2e334eee9bef61 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2012-09-25  8763  		cleaned_count++;
9d5c824399dea8 drivers/net/igb/igb_main.c                Auke Kok          2008-01-24  8764  
2e334eee9bef61 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2012-09-25  8765  		/* fetch next buffer in frame if non-eop */
2e334eee9bef61 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2012-09-25  8766  		if (igb_is_non_eop(rx_ring, rx_desc))
2e334eee9bef61 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2012-09-25  8767  			continue;
44390ca6cb3d4d drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2011-08-26  8768  
1a1c225b946303 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2012-09-25  8769  		/* verify the packet layout is correct */
1a1c225b946303 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2012-09-25  8770  		if (igb_cleanup_headers(rx_ring, rx_desc, skb)) {
                                                                                                                                                  ^^^
Dereferenced inside the function call.

1a1c225b946303 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2012-09-25  8771  			skb = NULL;
1a1c225b946303 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2012-09-25  8772  			continue;
9d5c824399dea8 drivers/net/igb/igb_main.c                Auke Kok          2008-01-24  8773  		}
9d5c824399dea8 drivers/net/igb/igb_main.c                Auke Kok          2008-01-24  8774  
db2ee5bdf5c833 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2012-09-25  8775  		/* probably a little skewed due to removing CRC */
3ceb90fd489885 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2011-08-26 @8776  		total_bytes += skb->len;
3ceb90fd489885 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2011-08-26  8777  
db2ee5bdf5c833 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2012-09-25  8778  		/* populate checksum, timestamp, VLAN, and protocol */
db2ee5bdf5c833 drivers/net/ethernet/intel/igb/igb_main.c Alexander Duyck   2012-09-25  8779  		igb_process_skb_fields(rx_ring, rx_desc, skb);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 33424 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200626/a9f5bc21/attachment-0001.bin>
