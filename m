From: kbuild test robot <lkp@intel.com>
Date: Sat, 7 Sep 2019 04:18:32 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 1/59]
 drivers/net/ethernet/intel/i40e/i40e_xsk.c:162:9: error: implicit
 declaration of function 'i40e_xsk_async_xmit'; did you mean 'i40e_xdp_xmit'?
Message-ID: <201909070429.jJfLFta2%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   c5bdb6a05e9839b64e8e0db33644df1338ae856c
commit: 25f7137ac8e6238b0d70dfca86fd568492234f51 [1/59] i40e: fix potential RX buffer starvation for AF_XDP
config: x86_64-allyesconfig (attached as .config)
compiler: gcc-7 (Debian 7.4.0-11) 7.4.0
reproduce:
        git checkout 25f7137ac8e6238b0d70dfca86fd568492234f51
        # save the attached .config to linux build tree
        make ARCH=x86_64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_xsk.c: In function 'i40e_xsk_umem_disable':
>> drivers/net/ethernet/intel/i40e/i40e_xsk.c:162:9: error: implicit declaration of function 'i40e_xsk_async_xmit'; did you mean 'i40e_xdp_xmit'? [-Werror=implicit-function-declaration]
      err = i40e_xsk_async_xmit(vsi->netdev, qid);
            ^~~~~~~~~~~~~~~~~~~
            i40e_xdp_xmit
   cc1: some warnings being treated as errors

vim +162 drivers/net/ethernet/intel/i40e/i40e_xsk.c

   126	
   127	/**
   128	 * i40e_xsk_umem_disable - Disassociate a UMEM from a certain ring/qid
   129	 * @vsi: Current VSI
   130	 * @qid: Rx ring to associate UMEM to
   131	 *
   132	 * Returns 0 on success, <0 on failure
   133	 **/
   134	static int i40e_xsk_umem_disable(struct i40e_vsi *vsi, u16 qid)
   135	{
   136		struct net_device *netdev = vsi->netdev;
   137		struct xdp_umem *umem;
   138		bool if_running;
   139		int err;
   140	
   141		umem = xdp_get_umem_from_qid(netdev, qid);
   142		if (!umem)
   143			return -EINVAL;
   144	
   145		if_running = netif_running(vsi->netdev) && i40e_enabled_xdp_vsi(vsi);
   146	
   147		if (if_running) {
   148			err = i40e_queue_pair_disable(vsi, qid);
   149			if (err)
   150				return err;
   151		}
   152	
   153		clear_bit(qid, vsi->af_xdp_zc_qps);
   154		i40e_xsk_umem_dma_unmap(vsi, umem);
   155	
   156		if (if_running) {
   157			err = i40e_queue_pair_enable(vsi, qid);
   158			if (err)
   159				return err;
   160	
   161			/* Kick start the NAPI context so that receiving will start */
 > 162			err = i40e_xsk_async_xmit(vsi->netdev, qid);
   163			if (err)
   164				return err;
   165		}
   166	
   167		return 0;
   168	}
   169	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 69573 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190907/8326842d/attachment-0001.bin>
