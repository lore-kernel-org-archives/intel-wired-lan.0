From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 7 Jan 2017 02:30:49 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 85/85]
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:1955:46: error: 'rx_ring'
 undeclared
Message-ID: <201701070247.g4y7cmDF%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   95e7fea4a31500cf82efff684e242990951c2d8e
commit: 95e7fea4a31500cf82efff684e242990951c2d8e [85/85] ixgbe: Add function for checking to see if we can reuse page
config: alpha-allyesconfig (attached as .config)
compiler: alpha-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 95e7fea4a31500cf82efff684e242990951c2d8e
        # save the attached .config to linux build tree
        make.cross ARCH=alpha 

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:60:0:
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_can_reuse_rx_page':
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:1955:46: error: 'rx_ring' undeclared (first use in this function)
     unsigned int last_offset = ixgbe_rx_pg_size(rx_ring) -
                                                 ^
   drivers/net/ethernet/intel/ixgbe/ixgbe.h:363:65: note: in definition of macro 'ixgbe_rx_pg_size'
    #define ixgbe_rx_pg_size(_ring) (PAGE_SIZE << ixgbe_rx_pg_order(_ring))
                                                                    ^~~~~
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:1955:46: note: each undeclared identifier is reported only once for each function it appears in
     unsigned int last_offset = ixgbe_rx_pg_size(rx_ring) -
                                                 ^
   drivers/net/ethernet/intel/ixgbe/ixgbe.h:363:65: note: in definition of macro 'ixgbe_rx_pg_size'
    #define ixgbe_rx_pg_size(_ring) (PAGE_SIZE << ixgbe_rx_pg_order(_ring))
                                                                    ^~~~~

vim +/rx_ring +1955 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c

  1949	
  1950	static bool ixgbe_can_reuse_rx_page(struct ixgbe_rx_buffer *rx_buffer,
  1951					    struct page *page,
  1952					    const unsigned int truesize)
  1953	{
  1954	#if (PAGE_SIZE >= 8192)
> 1955		unsigned int last_offset = ixgbe_rx_pg_size(rx_ring) -
  1956					   ixgbe_rx_bufsz(rx_ring);
  1957	#endif
  1958		/* avoid re-using remote pages */

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 48633 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170107/48370dfa/attachment-0001.bin>
