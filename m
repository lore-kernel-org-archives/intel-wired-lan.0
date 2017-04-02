From: kbuild test robot <fengguang.wu@intel.com>
Date: Sun, 2 Apr 2017 17:08:30 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 48/52]
 drivers/net/ethernet/intel/i40e/i40e_txrx.c:1335:8: error: 'struct sk_buff'
 has no member named 'offload_fwd_mark'
Message-ID: <201704021728.BuNF3iFp%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Sridhar,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   611576e4d243e7f03e7cf5f14546474cad90cfb0
commit: 7d12ba37fafc0c69d5606f2cdf429efadac331e0 [48/52] i40e: Add TX and RX support over port netdev's in switchdev mode
config: x86_64-rhel (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 7d12ba37fafc0c69d5606f2cdf429efadac331e0
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_txrx.c: In function 'i40e_handle_lpbk_skb':
>> drivers/net/ethernet/intel/i40e/i40e_txrx.c:1335:8: error: 'struct sk_buff' has no member named 'offload_fwd_mark'
       nskb->offload_fwd_mark = 1;
           ^~

vim +1335 drivers/net/ethernet/intel/i40e/i40e_txrx.c

  1329			vf = &pf->vf[vf_id];
  1330			if (ether_addr_equal(eth->h_source,
  1331					     vf->default_lan_addr.addr)) {
  1332				nskb = skb_clone(skb, GFP_ATOMIC);
  1333				if (!nskb)
  1334					break;
> 1335				nskb->offload_fwd_mark = 1;
  1336				nskb->dev = vf->port_netdev;
  1337				napi_gro_receive(&q_vector->napi, nskb);
  1338				break;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 38876 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170402/bf2b6eb2/attachment-0001.bin>
