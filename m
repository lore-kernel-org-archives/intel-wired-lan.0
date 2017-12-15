From: kbuild test robot <lkp@intel.com>
Date: Sat, 16 Dec 2017 05:18:16 +0800
Subject: [Intel-wired-lan] [PATCH v2 next-queue 08/10] ixgbe: process
 the Tx ipsec offload
In-Reply-To: <1513121823-27944-9-git-send-email-shannon.nelson@oracle.com>
References: <1513121823-27944-9-git-send-email-shannon.nelson@oracle.com>
Message-ID: <201712160511.N8znZ3n1%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Shannon,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v4.15-rc3]
[also build test ERROR on next-20171215]
[cannot apply to jkirsher-next-queue/dev-queue]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Shannon-Nelson/ixgbe-Add-ipsec-offload/20171216-024335
config: i386-randconfig-b0-12160414 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_xmit_frame_ring':
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8563:9: error: 'struct sk_buff' has no member named 'sp'
     if (skb->sp && !ixgbe_ipsec_tx(tx_ring, first, &ipsec_tx))
            ^

vim +8563 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c

  8562	
> 8563		if (skb->sp && !ixgbe_ipsec_tx(tx_ring, first, &ipsec_tx))
  8564			goto out_drop;
  8565		tso = ixgbe_tso(tx_ring, first, &hdr_len);
  8566		if (tso < 0)
  8567			goto out_drop;
  8568		else if (!tso)
  8569			ixgbe_tx_csum(tx_ring, first, &ipsec_tx);
  8570	
  8571		/* add the ATR filter if ATR is on */
  8572		if (test_bit(__IXGBE_TX_FDIR_INIT_DONE, &tx_ring->state))
  8573			ixgbe_atr(tx_ring, first);
  8574	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 31558 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20171216/3c08fe2c/attachment-0001.bin>
