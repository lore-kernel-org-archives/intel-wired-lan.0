From: kernel test robot <lkp@intel.com>
Date: Tue, 11 Aug 2020 04:23:05 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 8/33]
 drivers/net/ethernet/intel/i40e/i40e_txrx.c:1956:33: error: passing
 argument 1 of 'prefetch_page_address' from incompatible pointer type
Message-ID: <202008110403.RnGoxSxG%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   5cf0cbb14925b7131baa959b35a2267d6bbb6651
commit: c2b9f24be5de6d9737de68d2d75ae3bc81f9b7db [8/33] i40e: optimise prefetch page refcount
config: alpha-allyesconfig (attached as .config)
compiler: alpha-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout c2b9f24be5de6d9737de68d2d75ae3bc81f9b7db
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=alpha 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/intel/i40e/i40e_txrx.c:4:
   include/linux/prefetch.h:65:49: warning: 'struct page' declared inside parameter list will not be visible outside of this definition or declaration
      65 | static inline void prefetch_page_address(struct page *page)
         |                                                 ^~~~
   drivers/net/ethernet/intel/i40e/i40e_txrx.c: In function 'i40e_get_rx_buffer':
>> drivers/net/ethernet/intel/i40e/i40e_txrx.c:1956:33: error: passing argument 1 of 'prefetch_page_address' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1956 |  prefetch_page_address(rx_buffer->page);
         |                        ~~~~~~~~~^~~~~~
         |                                 |
         |                                 struct page *
   In file included from drivers/net/ethernet/intel/i40e/i40e_txrx.c:4:
   include/linux/prefetch.h:65:55: note: expected 'struct page *' but argument is of type 'struct page *'
      65 | static inline void prefetch_page_address(struct page *page)
         |                                          ~~~~~~~~~~~~~^~~~
   cc1: some warnings being treated as errors

vim +/prefetch_page_address +1956 drivers/net/ethernet/intel/i40e/i40e_txrx.c

  1941	
  1942	/**
  1943	 * i40e_get_rx_buffer - Fetch Rx buffer and synchronize data for use
  1944	 * @rx_ring: rx descriptor ring to transact packets on
  1945	 * @size: size of buffer to add to skb
  1946	 *
  1947	 * This function will pull an Rx buffer from the ring and synchronize it
  1948	 * for use by the CPU.
  1949	 */
  1950	static struct i40e_rx_buffer *i40e_get_rx_buffer(struct i40e_ring *rx_ring,
  1951							 const unsigned int size)
  1952	{
  1953		struct i40e_rx_buffer *rx_buffer;
  1954	
  1955		rx_buffer = i40e_rx_bi(rx_ring, rx_ring->next_to_clean);
> 1956		prefetch_page_address(rx_buffer->page);
  1957	
  1958		/* we are reusing so sync this buffer for CPU use */
  1959		dma_sync_single_range_for_cpu(rx_ring->dev,
  1960					      rx_buffer->dma,
  1961					      rx_buffer->page_offset,
  1962					      size,
  1963					      DMA_FROM_DEVICE);
  1964	
  1965		/* We have pulled a buffer for use, so decrement pagecnt_bias */
  1966		rx_buffer->pagecnt_bias--;
  1967	
  1968		return rx_buffer;
  1969	}
  1970	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65348 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200811/661adb49/attachment-0001.bin>
