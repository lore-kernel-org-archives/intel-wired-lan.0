From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 19 Dec 2017 17:19:15 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 73/86]
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8467:11: error: 'struct
 sk_buff' has no member named 'sp'; did you mean 'sk'?
Message-ID: <201712191701.4RTL7BhP%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   5c54325b75aa66e6f3fd313c513d543eab3fc7f6
commit: eab2fe699d9ed618b41d4b47122dc177e835a3a0 [73/86] ixgbe: process the Tx ipsec offload
config: x86_64-kexec (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        git checkout eab2fe699d9ed618b41d4b47122dc177e835a3a0
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_xmit_frame_ring':
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8467:11: error: 'struct sk_buff' has no member named 'sp'; did you mean 'sk'?
     if (skb->sp && !ixgbe_ipsec_tx(tx_ring, first, &ipsec_tx))
              ^~
              sk

vim +8467 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c

  8466	
> 8467		if (skb->sp && !ixgbe_ipsec_tx(tx_ring, first, &ipsec_tx))
  8468			goto out_drop;
  8469		tso = ixgbe_tso(tx_ring, first, &hdr_len);
  8470		if (tso < 0)
  8471			goto out_drop;
  8472		else if (!tso)
  8473			ixgbe_tx_csum(tx_ring, first, &ipsec_tx);
  8474	
  8475		/* add the ATR filter if ATR is on */
  8476		if (test_bit(__IXGBE_TX_FDIR_INIT_DONE, &tx_ring->state))
  8477			ixgbe_atr(tx_ring, first);
  8478	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 26299 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20171219/ff575559/attachment-0001.bin>
