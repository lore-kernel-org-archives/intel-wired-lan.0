From: kbuild test robot <lkp@intel.com>
Date: Sat, 7 Jan 2017 21:06:30 +0800
Subject: [Intel-wired-lan] [next PATCH 04/11] ixgbe: Update code to
 better handle incrementing page count
In-Reply-To: <20170106160654.1501.10742.stgit@localhost.localdomain>
Message-ID: <201701072130.c6VZ6o03%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Alexander,

[auto build test ERROR on jkirsher-next-queue/dev-queue]
[also build test ERROR on v4.10-rc2 next-20170106]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Alexander-Duyck/ixgbe-Add-support-for-writable-pages-and-build_skb/20170107-193738
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
config: alpha-allyesconfig (attached as .config)
compiler: alpha-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=alpha 

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:60:0:
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_can_reuse_rx_page':
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:1960:46: error: 'rx_ring' undeclared (first use in this function)
     unsigned int last_offset = ixgbe_rx_pg_size(rx_ring) -
                                                 ^
   drivers/net/ethernet/intel/ixgbe/ixgbe.h:371:65: note: in definition of macro 'ixgbe_rx_pg_size'
    #define ixgbe_rx_pg_size(_ring) (PAGE_SIZE << ixgbe_rx_pg_order(_ring))
                                                                    ^~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:1960:46: note: each undeclared identifier is reported only once for each function it appears in
     unsigned int last_offset = ixgbe_rx_pg_size(rx_ring) -
                                                 ^
   drivers/net/ethernet/intel/ixgbe/ixgbe.h:371:65: note: in definition of macro 'ixgbe_rx_pg_size'
    #define ixgbe_rx_pg_size(_ring) (PAGE_SIZE << ixgbe_rx_pg_order(_ring))
                                                                    ^~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_fetch_rx_buffer':
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2124:3: error: implicit declaration of function '__page_frag_cache_drain' [-Werror=implicit-function-declaration]
      __page_frag_cache_drain(page,
      ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/__page_frag_cache_drain +2124 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c

  1954	
  1955	static bool ixgbe_can_reuse_rx_page(struct ixgbe_rx_buffer *rx_buffer,
  1956					    struct page *page,
  1957					    const unsigned int truesize)
  1958	{
  1959	#if (PAGE_SIZE >= 8192)
> 1960		unsigned int last_offset = ixgbe_rx_pg_size(rx_ring) -
  1961					   ixgbe_rx_bufsz(rx_ring);
  1962	#endif
  1963		unsigned int pagecnt_bias = rx_buffer->pagecnt_bias--;
  1964	
  1965		/* avoid re-using remote pages */
  1966		if (unlikely(ixgbe_page_is_reserved(page)))
  1967			return false;
  1968	
  1969	#if (PAGE_SIZE < 8192)
  1970		/* if we are only owner of page we can reuse it */
  1971		if (unlikely(page_count(page) != pagecnt_bias))
  1972			return false;
  1973	
  1974		/* flip page offset to other buffer */
  1975		rx_buffer->page_offset ^= truesize;
  1976	#else
  1977		/* move offset up to the next cache line */
  1978		rx_buffer->page_offset += truesize;
  1979	
  1980		if (rx_buffer->page_offset > last_offset)
  1981			return false;
  1982	#endif
  1983	
  1984		/* If we have drained the page fragment pool we need to update
  1985		 * the pagecnt_bias and page count so that we fully restock the
  1986		 * number of references the driver holds.
  1987		 */
  1988		if (unlikely(pagecnt_bias == 1)) {
  1989			page_ref_add(page, USHRT_MAX);
  1990			rx_buffer->pagecnt_bias = USHRT_MAX;
  1991		}
  1992	
  1993		return true;
  1994	}
  1995	
  1996	/**
  1997	 * ixgbe_add_rx_frag - Add contents of Rx buffer to sk_buff
  1998	 * @rx_ring: rx descriptor ring to transact packets on
  1999	 * @rx_buffer: buffer containing page to add
  2000	 * @rx_desc: descriptor containing length of buffer written by hardware
  2001	 * @skb: sk_buff to place the data into
  2002	 *
  2003	 * This function will add the data contained in rx_buffer->page to the skb.
  2004	 * This is done either through a direct copy if the data in the buffer is
  2005	 * less than the skb header size, otherwise it will just attach the page as
  2006	 * a frag to the skb.
  2007	 *
  2008	 * The function will then update the page offset if necessary and return
  2009	 * true if the buffer can be reused by the adapter.
  2010	 **/
  2011	static bool ixgbe_add_rx_frag(struct ixgbe_ring *rx_ring,
  2012				      struct ixgbe_rx_buffer *rx_buffer,
  2013				      unsigned int size,
  2014				      struct sk_buff *skb)
  2015	{
  2016		struct page *page = rx_buffer->page;
  2017		unsigned char *va = page_address(page) + rx_buffer->page_offset;
  2018	#if (PAGE_SIZE < 8192)
  2019		unsigned int truesize = ixgbe_rx_bufsz(rx_ring);
  2020	#else
  2021		unsigned int truesize = ALIGN(size, L1_CACHE_BYTES);
  2022	#endif
  2023	
  2024		if (unlikely(skb_is_nonlinear(skb)))
  2025			goto add_tail_frag;
  2026	
  2027		if (size <= IXGBE_RX_HDR_SIZE) {
  2028			memcpy(__skb_put(skb, size), va, ALIGN(size, sizeof(long)));
  2029	
  2030			/* page is not reserved, we can reuse buffer as-is */
  2031			if (likely(!ixgbe_page_is_reserved(page)))
  2032				return true;
  2033	
  2034			/* this page cannot be reused so discard it */
  2035			return false;
  2036		}
  2037	
  2038	add_tail_frag:
  2039		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page,
  2040				rx_buffer->page_offset, size, truesize);
  2041	
  2042		return ixgbe_can_reuse_rx_page(rx_buffer, page, truesize);
  2043	}
  2044	
  2045	static struct sk_buff *ixgbe_fetch_rx_buffer(struct ixgbe_ring *rx_ring,
  2046						     union ixgbe_adv_rx_desc *rx_desc)
  2047	{
  2048		unsigned int size = le16_to_cpu(rx_desc->wb.upper.length);
  2049		struct ixgbe_rx_buffer *rx_buffer;
  2050		struct sk_buff *skb;
  2051		struct page *page;
  2052	
  2053		rx_buffer = &rx_ring->rx_buffer_info[rx_ring->next_to_clean];
  2054		page = rx_buffer->page;
  2055		prefetchw(page);
  2056	
  2057		skb = rx_buffer->skb;
  2058	
  2059		if (likely(!skb)) {
  2060			void *page_addr = page_address(page) +
  2061					  rx_buffer->page_offset;
  2062	
  2063			/* prefetch first cache line of first page */
  2064			prefetch(page_addr);
  2065	#if L1_CACHE_BYTES < 128
  2066			prefetch(page_addr + L1_CACHE_BYTES);
  2067	#endif
  2068	
  2069			/* allocate a skb to store the frags */
  2070			skb = napi_alloc_skb(&rx_ring->q_vector->napi,
  2071					     IXGBE_RX_HDR_SIZE);
  2072			if (unlikely(!skb)) {
  2073				rx_ring->rx_stats.alloc_rx_buff_failed++;
  2074				return NULL;
  2075			}
  2076	
  2077			/*
  2078			 * we will be copying header into skb->data in
  2079			 * pskb_may_pull so it is in our interest to prefetch
  2080			 * it now to avoid a possible cache miss
  2081			 */
  2082			prefetchw(skb->data);
  2083	
  2084			/*
  2085			 * Delay unmapping of the first packet. It carries the
  2086			 * header information, HW may still access the header
  2087			 * after the writeback.  Only unmap it when EOP is
  2088			 * reached
  2089			 */
  2090			if (likely(ixgbe_test_staterr(rx_desc, IXGBE_RXD_STAT_EOP)))
  2091				goto dma_sync;
  2092	
  2093			IXGBE_CB(skb)->dma = rx_buffer->dma;
  2094		} else {
  2095			if (ixgbe_test_staterr(rx_desc, IXGBE_RXD_STAT_EOP))
  2096				ixgbe_dma_sync_frag(rx_ring, skb);
  2097	
  2098	dma_sync:
  2099			/* we are reusing so sync this buffer for CPU use */
  2100			dma_sync_single_range_for_cpu(rx_ring->dev,
  2101						      rx_buffer->dma,
  2102						      rx_buffer->page_offset,
  2103						      size,
  2104						      DMA_FROM_DEVICE);
  2105	
  2106			rx_buffer->skb = NULL;
  2107		}
  2108	
  2109		/* pull page into skb */
  2110		if (ixgbe_add_rx_frag(rx_ring, rx_buffer, size, skb)) {
  2111			/* hand second half of page back to the ring */
  2112			ixgbe_reuse_rx_page(rx_ring, rx_buffer);
  2113		} else {
  2114			if (IXGBE_CB(skb)->dma == rx_buffer->dma) {
  2115				/* the page has been released from the ring */
  2116				IXGBE_CB(skb)->page_released = true;
  2117			} else {
  2118				/* we are not reusing the buffer so unmap it */
  2119				dma_unmap_page_attrs(rx_ring->dev, rx_buffer->dma,
  2120						     ixgbe_rx_pg_size(rx_ring),
  2121						     DMA_FROM_DEVICE,
  2122						     IXGBE_RX_DMA_ATTR);
  2123			}
> 2124			__page_frag_cache_drain(page,
  2125						rx_buffer->pagecnt_bias);
  2126		}
  2127	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 48633 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170107/ab8fc1ad/attachment-0001.bin>
