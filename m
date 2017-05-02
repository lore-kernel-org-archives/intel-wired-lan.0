From: Duyck, Alexander H <alexander.h.duyck@intel.com>
Date: Tue, 2 May 2017 20:38:19 +0000
Subject: [Intel-wired-lan] [bug report] ixgbe: add XDP support for pass
 and drop actions
In-Reply-To: <20170502192900.k4qkz5japccbn7vs@mwanda>
References: <20170502192900.k4qkz5japccbn7vs@mwanda>
Message-ID: <1493757496.20114.31.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2017-05-02 at 22:29 +0300, Dan Carpenter wrote:
> Hello John Fastabend,
> 
> The patch 924708081629: "ixgbe: add XDP support for pass and drop
> actions" from Apr 24, 2017, leads to the following static checker
> warning:
> 
> 	drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2365 ixgbe_clean_rx_irq()
> 	error: 'skb' dereferencing possible ERR_PTR()
> 
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>   2326  
>   2327                  if (IS_ERR(skb)) {
>                             ^^^^^^^^^^
> Assume that this is true.

If this is true then ixgbe_cleanup_headers will also be true since
there is nothing that alters skb after the else statements in the check
below.

> 
>   2328                          if (PTR_ERR(skb) == -IXGBE_XDP_TX) {
>   2329                                  xdp_xmit = true;
>   2330                                  ixgbe_rx_buffer_flip(rx_ring, rx_buffer, size);
>   2331                          } else {
>   2332                                  rx_buffer->pagecnt_bias++;
>   2333                          }
>   2334                          total_rx_packets++;
>   2335                          total_rx_bytes += size;
>   2336                  } else if (skb) {
>   2337                          ixgbe_add_rx_frag(rx_ring, rx_buffer, skb, size);
>   2338                  } else if (ring_uses_build_skb(rx_ring)) {
>   2339                          skb = ixgbe_build_skb(rx_ring, rx_buffer,
>   2340                                                &xdp, rx_desc);
>   2341                  } else {
>   2342                          skb = ixgbe_construct_skb(rx_ring, rx_buffer,
>   2343                                                    &xdp, rx_desc);
>   2344                  }
>   2345  
>   2346                  /* exit if we failed to retrieve a buffer */
>   2347                  if (!skb) {
>   2348                          rx_ring->rx_stats.alloc_rx_buff_failed++;
>   2349                          rx_buffer->pagecnt_bias++;
>   2350                          break;
>   2351                  }
>   2352  
>   2353                  ixgbe_put_rx_buffer(rx_ring, rx_buffer, skb);
>   2354                  cleaned_count++;
>   2355  
>   2356                  /* place incomplete frames back on ring for completion */
>   2357                  if (ixgbe_is_non_eop(rx_ring, rx_desc, skb))
>   2358                          continue;
>   2359  
>   2360                  /* verify the packet layout is correct */
>   2361                  if (ixgbe_cleanup_headers(rx_ring, rx_desc, skb))
>   2362                          continue;
>   2363  
>   2364                  /* probably a little skewed due to removing CRC */
>   2365                  total_rx_bytes += skb->len;
>                                           ^^^^^^^^
> Then this is a potential Oops.  Possibly some of the earlier uses are
> wrong.  Or possibly we always hit a continue?  It's either buggy or
> there should probably be a comment explaining what's going on...

This is after ixgbe_cleanup_headers. Take a look in the code there. If
the value IS_ERR(skb) evaluates to true then the function returns true
so you won't execute the code.

> 
>   2366  
>   2367                  /* populate checksum, timestamp, VLAN, and protocol */
>   2368                  ixgbe_process_skb_fields(rx_ring, rx_desc, skb);
> 
> regards,
> dan carpenter
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
