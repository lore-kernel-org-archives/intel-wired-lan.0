From: kbuild test robot <lkp@intel.com>
Date: Wed, 10 Jul 2019 17:33:27 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 9/51]
 drivers/net/ethernet/intel/ice/ice_xsk.c:717:48: error: passing argument 2
 of 'xsk_umem_consume_tx' from incompatible pointer type
Message-ID: <201907101712.W52t6to1%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   46065ef1595f1bba9b1c9ed45cb501b95ea23259
commit: c2d44b271ae1b5311a3eb2cb8e1215f16f53485a [9/51] ice: Add support for AF_XDP
config: arm64-allyesconfig (attached as .config)
compiler: aarch64-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout c2d44b271ae1b5311a3eb2cb8e1215f16f53485a
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=arm64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/ice/ice_xsk.c: In function 'ice_xmit_zc':
>> drivers/net/ethernet/intel/ice/ice_xsk.c:717:48: error: passing argument 2 of 'xsk_umem_consume_tx' from incompatible pointer type [-Werror=incompatible-pointer-types]
      if (!xsk_umem_consume_tx(xdp_ring->xsk_umem, &dma, &len))
                                                   ^
   In file included from drivers/net/ethernet/intel/ice/ice.h:37:0,
                    from drivers/net/ethernet/intel/ice/ice_xsk.c:4:
   include/net/xdp_sock.h:84:6: note: expected 'struct xdp_desc *' but argument is of type 'dma_addr_t * {aka long long unsigned int *}'
    bool xsk_umem_consume_tx(struct xdp_umem *umem, struct xdp_desc *desc);
         ^~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/ice/ice_xsk.c:717:8: error: too many arguments to function 'xsk_umem_consume_tx'
      if (!xsk_umem_consume_tx(xdp_ring->xsk_umem, &dma, &len))
           ^~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/ethernet/intel/ice/ice.h:37:0,
                    from drivers/net/ethernet/intel/ice/ice_xsk.c:4:
   include/net/xdp_sock.h:84:6: note: declared here
    bool xsk_umem_consume_tx(struct xdp_umem *umem, struct xdp_desc *desc);
         ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/xsk_umem_consume_tx +717 drivers/net/ethernet/intel/ice/ice_xsk.c

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65747 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190710/71e3f938/attachment-0001.bin>
