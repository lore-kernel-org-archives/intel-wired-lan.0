From: kbuild test robot <lkp@intel.com>
Date: Tue, 29 Jan 2019 16:24:35 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 24/26]
 include/net/xdp.h:111:6: error: implicit declaration of function 'unlikely';
 did you mean 'inline'?
Message-ID: <201901291634.dgYxCoMs%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   0877d96a712abecbec128a65bb335bd1a21a73f8
commit: 6f20ba0a6c9292ca36b484990dd1f8f25ee7154f [24/26] i40e: replace switch-statement with if-clause
config: alpha-allmodconfig (attached as .config)
compiler: alpha-linux-gnu-gcc (Debian 8.2.0-11) 8.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 6f20ba0a6c9292ca36b484990dd1f8f25ee7154f
        # save the attached .config to linux build tree
        GCC_VERSION=8.2.0 make.cross ARCH=alpha 

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/intel/i40e/i40e_txrx.c:5:
   include/net/xdp.h: In function 'convert_to_xdp_frame':
>> include/net/xdp.h:111:6: error: implicit declaration of function 'unlikely'; did you mean 'inline'? [-Werror=implicit-function-declaration]
     if (unlikely((headroom - metasize) < sizeof(*xdp_frame)))
         ^~~~~~~~
         inline
   cc1: some warnings being treated as errors

vim +111 include/net/xdp.h

b0d1beef Bj?rn T?pel            2018-08-28   95  
c0048cff Jesper Dangaard Brouer 2018-04-17   96  /* Convert xdp_buff to xdp_frame */
c0048cff Jesper Dangaard Brouer 2018-04-17   97  static inline
c0048cff Jesper Dangaard Brouer 2018-04-17   98  struct xdp_frame *convert_to_xdp_frame(struct xdp_buff *xdp)
c0048cff Jesper Dangaard Brouer 2018-04-17   99  {
c0048cff Jesper Dangaard Brouer 2018-04-17  100  	struct xdp_frame *xdp_frame;
c0048cff Jesper Dangaard Brouer 2018-04-17  101  	int metasize;
c0048cff Jesper Dangaard Brouer 2018-04-17  102  	int headroom;
c0048cff Jesper Dangaard Brouer 2018-04-17  103  
02b55e56 Bj?rn T?pel            2018-06-04  104  	if (xdp->rxq->mem.type == MEM_TYPE_ZERO_COPY)
b0d1beef Bj?rn T?pel            2018-08-28  105  		return xdp_convert_zc_to_xdp_frame(xdp);
02b55e56 Bj?rn T?pel            2018-06-04  106  
c0048cff Jesper Dangaard Brouer 2018-04-17  107  	/* Assure headroom is available for storing info */
c0048cff Jesper Dangaard Brouer 2018-04-17  108  	headroom = xdp->data - xdp->data_hard_start;
c0048cff Jesper Dangaard Brouer 2018-04-17  109  	metasize = xdp->data - xdp->data_meta;
c0048cff Jesper Dangaard Brouer 2018-04-17  110  	metasize = metasize > 0 ? metasize : 0;
c0048cff Jesper Dangaard Brouer 2018-04-17 @111  	if (unlikely((headroom - metasize) < sizeof(*xdp_frame)))
c0048cff Jesper Dangaard Brouer 2018-04-17  112  		return NULL;
c0048cff Jesper Dangaard Brouer 2018-04-17  113  
c0048cff Jesper Dangaard Brouer 2018-04-17  114  	/* Store info in top of packet */
c0048cff Jesper Dangaard Brouer 2018-04-17  115  	xdp_frame = xdp->data_hard_start;
c0048cff Jesper Dangaard Brouer 2018-04-17  116  
c0048cff Jesper Dangaard Brouer 2018-04-17  117  	xdp_frame->data = xdp->data;
c0048cff Jesper Dangaard Brouer 2018-04-17  118  	xdp_frame->len  = xdp->data_end - xdp->data;
c0048cff Jesper Dangaard Brouer 2018-04-17  119  	xdp_frame->headroom = headroom - sizeof(*xdp_frame);
c0048cff Jesper Dangaard Brouer 2018-04-17  120  	xdp_frame->metasize = metasize;
c0048cff Jesper Dangaard Brouer 2018-04-17  121  
c0048cff Jesper Dangaard Brouer 2018-04-17  122  	/* rxq only valid until napi_schedule ends, convert to xdp_mem_info */
c0048cff Jesper Dangaard Brouer 2018-04-17  123  	xdp_frame->mem = xdp->rxq->mem;
c0048cff Jesper Dangaard Brouer 2018-04-17  124  
c0048cff Jesper Dangaard Brouer 2018-04-17  125  	return xdp_frame;
c0048cff Jesper Dangaard Brouer 2018-04-17  126  }
c0048cff Jesper Dangaard Brouer 2018-04-17  127  

:::::: The code at line 111 was first introduced by commit
:::::: c0048cff8abb69c956ce1277d17a3f7a14e41522 xdp: introduce a new xdp_frame type

:::::: TO: Jesper Dangaard Brouer <brouer@redhat.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 55488 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190129/c93369cc/attachment-0001.bin>
