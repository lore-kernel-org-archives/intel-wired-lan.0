From: kbuild test robot <lkp@intel.com>
Date: Fri, 16 Aug 2019 17:21:12 +0800
Subject: [Intel-wired-lan] [PATCH bpf-next 3/5] i40e: Enable
 XDP_SKIP_BPF option for AF_XDP sockets
In-Reply-To: <1565840783-8269-4-git-send-email-sridhar.samudrala@intel.com>
References: <1565840783-8269-4-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <201908161723.TSR15kHq%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Sridhar,

I love your patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/0day-ci/linux/commits/Sridhar-Samudrala/xsk-Convert-bool-zc-field-in-struct-xdp_umem-to-a-u32-bitmap/20190816-144642
base:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: x86_64-lkp (attached as .config)
compiler: gcc-7 (Debian 7.4.0-10) 7.4.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_txrx.c: In function 'i40e_run_xdp':
>> drivers/net/ethernet/intel/i40e/i40e_txrx.c:2215:9: error: implicit declaration of function 'xsk_umem_rcv'; did you mean 'xsk_rcv'? [-Werror=implicit-function-declaration]
      err = xsk_umem_rcv(umem, xdp);
            ^~~~~~~~~~~~
            xsk_rcv
   drivers/net/ethernet/intel/i40e/i40e_txrx.c: In function 'i40e_finalize_xdp_rx':
>> drivers/net/ethernet/intel/i40e/i40e_txrx.c:2322:4: error: implicit declaration of function 'xsk_umem_flush'; did you mean 'xsk_umem_fq_reuse'? [-Werror=implicit-function-declaration]
       xsk_umem_flush(umem);
       ^~~~~~~~~~~~~~
       xsk_umem_fq_reuse
   cc1: some warnings being treated as errors
--
   drivers/net/ethernet/intel/i40e/i40e_xsk.c: In function 'i40e_run_xdp_zc':
>> drivers/net/ethernet/intel/i40e/i40e_xsk.c:199:9: error: implicit declaration of function 'xsk_umem_rcv'; did you mean 'xsk_rcv'? [-Werror=implicit-function-declaration]
      err = xsk_umem_rcv(rx_ring->xsk_umem, xdp);
            ^~~~~~~~~~~~
            xsk_rcv
   cc1: some warnings being treated as errors

vim +2215 drivers/net/ethernet/intel/i40e/i40e_txrx.c

  2190	
  2191	/**
  2192	 * i40e_run_xdp - run an XDP program
  2193	 * @rx_ring: Rx ring being processed
  2194	 * @xdp: XDP buffer containing the frame
  2195	 **/
  2196	static struct sk_buff *i40e_run_xdp(struct i40e_ring *rx_ring,
  2197					    struct xdp_buff *xdp)
  2198	{
  2199		int err, result = I40E_XDP_PASS;
  2200		struct i40e_ring *xdp_ring;
  2201		struct bpf_prog *xdp_prog;
  2202		struct xdp_umem *umem;
  2203		u32 act;
  2204	
  2205		rcu_read_lock();
  2206		xdp_prog = READ_ONCE(rx_ring->xdp_prog);
  2207	
  2208		if (!xdp_prog)
  2209			goto xdp_out;
  2210	
  2211		prefetchw(xdp->data_hard_start); /* xdp_frame write */
  2212	
  2213		umem = xdp_get_umem_from_qid(rx_ring->netdev, rx_ring->queue_index);
  2214		if (xsk_umem_skip_bpf(umem)) {
> 2215			err = xsk_umem_rcv(umem, xdp);
  2216			result = !err ? I40E_XDP_REDIR : I40E_XDP_CONSUMED;
  2217			goto xdp_out;
  2218		}
  2219	
  2220		act = bpf_prog_run_xdp(xdp_prog, xdp);
  2221		switch (act) {
  2222		case XDP_PASS:
  2223			break;
  2224		case XDP_TX:
  2225			xdp_ring = rx_ring->vsi->xdp_rings[rx_ring->queue_index];
  2226			result = i40e_xmit_xdp_tx_ring(xdp, xdp_ring);
  2227			break;
  2228		case XDP_REDIRECT:
  2229			err = xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
  2230			result = !err ? I40E_XDP_REDIR : I40E_XDP_CONSUMED;
  2231			break;
  2232		default:
  2233			bpf_warn_invalid_xdp_action(act);
  2234			/* fall through */
  2235		case XDP_ABORTED:
  2236			trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
  2237			/* fall through -- handle aborts by dropping packet */
  2238		case XDP_DROP:
  2239			result = I40E_XDP_CONSUMED;
  2240			break;
  2241		}
  2242	xdp_out:
  2243		rcu_read_unlock();
  2244		return ERR_PTR(-result);
  2245	}
  2246	
  2247	/**
  2248	 * i40e_rx_buffer_flip - adjusted rx_buffer to point to an unused region
  2249	 * @rx_ring: Rx ring
  2250	 * @rx_buffer: Rx buffer to adjust
  2251	 * @size: Size of adjustment
  2252	 **/
  2253	static void i40e_rx_buffer_flip(struct i40e_ring *rx_ring,
  2254					struct i40e_rx_buffer *rx_buffer,
  2255					unsigned int size)
  2256	{
  2257	#if (PAGE_SIZE < 8192)
  2258		unsigned int truesize = i40e_rx_pg_size(rx_ring) / 2;
  2259	
  2260		rx_buffer->page_offset ^= truesize;
  2261	#else
  2262		unsigned int truesize = SKB_DATA_ALIGN(i40e_rx_offset(rx_ring) + size);
  2263	
  2264		rx_buffer->page_offset += truesize;
  2265	#endif
  2266	}
  2267	
  2268	/**
  2269	 * i40e_xdp_ring_update_tail - Updates the XDP Tx ring tail register
  2270	 * @xdp_ring: XDP Tx ring
  2271	 *
  2272	 * This function updates the XDP Tx ring tail register.
  2273	 **/
  2274	void i40e_xdp_ring_update_tail(struct i40e_ring *xdp_ring)
  2275	{
  2276		/* Force memory writes to complete before letting h/w
  2277		 * know there are new descriptors to fetch.
  2278		 */
  2279		wmb();
  2280		writel_relaxed(xdp_ring->next_to_use, xdp_ring->tail);
  2281	}
  2282	
  2283	/**
  2284	 * i40e_update_rx_stats - Update Rx ring statistics
  2285	 * @rx_ring: rx descriptor ring
  2286	 * @total_rx_bytes: number of bytes received
  2287	 * @total_rx_packets: number of packets received
  2288	 *
  2289	 * This function updates the Rx ring statistics.
  2290	 **/
  2291	void i40e_update_rx_stats(struct i40e_ring *rx_ring,
  2292				  unsigned int total_rx_bytes,
  2293				  unsigned int total_rx_packets)
  2294	{
  2295		u64_stats_update_begin(&rx_ring->syncp);
  2296		rx_ring->stats.packets += total_rx_packets;
  2297		rx_ring->stats.bytes += total_rx_bytes;
  2298		u64_stats_update_end(&rx_ring->syncp);
  2299		rx_ring->q_vector->rx.total_packets += total_rx_packets;
  2300		rx_ring->q_vector->rx.total_bytes += total_rx_bytes;
  2301	}
  2302	
  2303	/**
  2304	 * i40e_finalize_xdp_rx - Bump XDP Tx tail and/or flush redirect map
  2305	 * @rx_ring: Rx ring
  2306	 * @xdp_res: Result of the receive batch
  2307	 *
  2308	 * This function bumps XDP Tx tail and/or flush redirect map, and
  2309	 * should be called when a batch of packets has been processed in the
  2310	 * napi loop.
  2311	 **/
  2312	void i40e_finalize_xdp_rx(struct i40e_ring *rx_ring, unsigned int xdp_res)
  2313	{
  2314		if (xdp_res & I40E_XDP_REDIR) {
  2315			struct xdp_umem *umem;
  2316	
  2317			umem = rx_ring->xsk_umem;
  2318			if (!umem)
  2319				umem = xdp_get_umem_from_qid(rx_ring->netdev,
  2320							     rx_ring->queue_index);
  2321			if (xsk_umem_skip_bpf(umem))
> 2322				xsk_umem_flush(umem);
  2323			else
  2324				xdp_do_flush_map();
  2325		}
  2326	
  2327		if (xdp_res & I40E_XDP_TX) {
  2328			struct i40e_ring *xdp_ring =
  2329				rx_ring->vsi->xdp_rings[rx_ring->queue_index];
  2330	
  2331			i40e_xdp_ring_update_tail(xdp_ring);
  2332		}
  2333	}
  2334	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 27706 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190816/62e36905/attachment-0001.bin>
