From: kbuild test robot <fengguang.wu@intel.com>
Date: Mon, 17 Apr 2017 08:23:47 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 36/50]
 drivers/net//ethernet/intel/i40e/i40e_txrx.c:1344:8: error: 'struct
 sk_buff' has no member named 'offload_fwd_mark'
Message-ID: <201704170845.WeyzO0Tw%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   d1a889819a33af9fc4367b1e689d3f18208ba5e5
commit: 75c12c58551b239afcd5cbdfb23d7475a9bc2af0 [36/50] i40e: Add TX and RX support over port netdev's in switchdev mode
config: powerpc-defconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 75c12c58551b239afcd5cbdfb23d7475a9bc2af0
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   drivers/net//ethernet/intel/i40e/i40e_txrx.c: In function 'i40e_handle_lpbk_skb':
>> drivers/net//ethernet/intel/i40e/i40e_txrx.c:1344:8: error: 'struct sk_buff' has no member named 'offload_fwd_mark'
       nskb->offload_fwd_mark = 1;
           ^~

vim +1344 drivers/net//ethernet/intel/i40e/i40e_txrx.c

  1338			vf = &pf->vf[vf_id];
  1339			if (ether_addr_equal(eth->h_source,
  1340					     vf->default_lan_addr.addr)) {
  1341				nskb = skb_clone(skb, GFP_ATOMIC);
  1342				if (!nskb)
  1343					break;
> 1344				nskb->offload_fwd_mark = 1;
  1345				nskb->dev = vf->port_netdev;
  1346				napi_gro_receive(&q_vector->napi, nskb);
  1347				break;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23158 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170417/cd291102/attachment-0001.bin>
