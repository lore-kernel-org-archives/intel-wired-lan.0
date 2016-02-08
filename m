From: kbuild test robot <fengguang.wu@intel.com>
Date: Mon, 8 Feb 2016 18:41:59 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 120/135]
 drivers/net/ethernet/intel/i40e/i40e_txrx.c:2445:17: error:
 'I40E_TX_FLAGS_TUNNEL' undeclared
Message-ID: <201602081858.dUjBEOox%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   97e62110c6b248642478de6cdf5f3c9f370837fd
commit: 9120d8b17f23cec8b7b37ba931054b4a8365c6fd [120/135] i40e/i40evf: Do not write to descriptor unless we complete
config: x86_64-rhel (attached as .config)
reproduce:
        git checkout 9120d8b17f23cec8b7b37ba931054b4a8365c6fd
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_txrx.c: In function 'i40e_tx_enable_csum':
>> drivers/net/ethernet/intel/i40e/i40e_txrx.c:2445:17: error: 'I40E_TX_FLAGS_TUNNEL' undeclared (first use in this function)
       *tx_flags |= I40E_TX_FLAGS_TUNNEL;
                    ^
   drivers/net/ethernet/intel/i40e/i40e_txrx.c:2445:17: note: each undeclared identifier is reported only once for each function it appears in

vim +/I40E_TX_FLAGS_TUNNEL +2445 drivers/net/ethernet/intel/i40e/i40e_txrx.c

  2439			ip.hdr = skb_inner_network_header(skb);
  2440	
  2441			/* define outer transport */
  2442			switch (l4_proto) {
  2443			case IPPROTO_UDP:
  2444				tunnel |= I40E_TXD_CTX_UDP_TUNNELING;
> 2445				*tx_flags |= I40E_TX_FLAGS_TUNNEL;
  2446				break;
  2447			case IPPROTO_GRE:
  2448				tunnel |= I40E_TXD_CTX_GRE_TUNNELING;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 36062 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160208/f225120b/attachment-0001.obj>
