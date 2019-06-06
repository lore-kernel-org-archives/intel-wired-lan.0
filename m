From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Thu, 6 Jun 2019 07:52:20 +0200
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 579/633]
 drivers/net/ethernet/realtek/r8169_main.c:5861:17: sparse: sparse:
 incorrect type in assignment (different base types)
In-Reply-To: <201906060718.W0btEpe4%lkp@intel.com>
References: <201906060718.W0btEpe4%lkp@intel.com>
Message-ID: <5f79bb27-6c18-f534-8b0e-798541280969@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 06.06.2019 01:41, kbuild test robot wrote:
> Hi Heiner,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
> head:   a879fe85e4b103e65a85527bbaeaa51a15ce9d8c
> commit: 25e992a4603cd5284127e2a6fda6b05bd58d12ed [579/633] r8169: rename r8169.c to r8169_main.c
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
>         git checkout 25e992a4603cd5284127e2a6fda6b05bd58d12ed
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
Thanks for reporting. The issue itself isn't new, seems like renaming the source code file
triggered some more thorough checking. I submitted a fix.

> 
> sparse warnings: (new ones prefixed by >>)
> 
>>> drivers/net/ethernet/realtek/r8169_main.c:5861:17: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int @@    got restricted __le32unsigned int @@
>>> drivers/net/ethernet/realtek/r8169_main.c:5861:17: sparse:    expected unsigned int
>>> drivers/net/ethernet/realtek/r8169_main.c:5861:17: sparse:    got restricted __le32 [usertype]
>    include/linux/netdevice.h:3889:20: sparse: sparse: shift count is negative (-1)
> 
> vim +5861 drivers/net/ethernet/realtek/r8169_main.c
> 
> 87945b6d8 drivers/net/ethernet/realtek/r8169.c Heiner Kallweit   2019-05-31  5841  
> 61357325f drivers/net/r8169.c                  Stephen Hemminger 2009-08-31  5842  static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
> 61357325f drivers/net/r8169.c                  Stephen Hemminger 2009-08-31  5843  				      struct net_device *dev)
> ^1da177e4 drivers/net/r8169.c                  Linus Torvalds    2005-04-16  5844  {
> ^1da177e4 drivers/net/r8169.c                  Linus Torvalds    2005-04-16  5845  	struct rtl8169_private *tp = netdev_priv(dev);
> 3eafe5070 drivers/net/r8169.c                  Stanislaw Gruszka 2010-10-20  5846  	unsigned int entry = tp->cur_tx % NUM_TX_DESC;
> ^1da177e4 drivers/net/r8169.c                  Linus Torvalds    2005-04-16  5847  	struct TxDesc *txd = tp->TxDescArray + entry;
> 1e1205b7d drivers/net/ethernet/realtek/r8169.c Heiner Kallweit   2018-03-20  5848  	struct device *d = tp_to_dev(tp);
> ^1da177e4 drivers/net/r8169.c                  Linus Torvalds    2005-04-16  5849  	dma_addr_t mapping;
> 734c14098 drivers/net/ethernet/realtek/r8169.c Heiner Kallweit   2018-11-22  5850  	u32 opts[2], len;
> 3eafe5070 drivers/net/r8169.c                  Stanislaw Gruszka 2010-10-20  5851  	int frags;
> ^1da177e4 drivers/net/r8169.c                  Linus Torvalds    2005-04-16  5852  
> 76085c9e7 drivers/net/ethernet/realtek/r8169.c Heiner Kallweit   2018-11-22  5853  	if (unlikely(!rtl_tx_slots_avail(tp, skb_shinfo(skb)->nr_frags))) {
> bf82c189a drivers/net/r8169.c                  Joe Perches       2010-02-09  5854  		netif_err(tp, drv, dev, "BUG! Tx Ring full when queue awake!\n");
> 3eafe5070 drivers/net/r8169.c                  Stanislaw Gruszka 2010-10-20  5855  		goto err_stop_0;
> ^1da177e4 drivers/net/r8169.c                  Linus Torvalds    2005-04-16  5856  	}
> ^1da177e4 drivers/net/r8169.c                  Linus Torvalds    2005-04-16  5857  
> ^1da177e4 drivers/net/r8169.c                  Linus Torvalds    2005-04-16  5858  	if (unlikely(le32_to_cpu(txd->opts1) & DescOwn))
> 3eafe5070 drivers/net/r8169.c                  Stanislaw Gruszka 2010-10-20  5859  		goto err_stop_0;
> ^1da177e4 drivers/net/r8169.c                  Linus Torvalds    2005-04-16  5860  
> b423e9ae4 drivers/net/ethernet/realtek/r8169.c fran?ois romieu   2013-05-18 @5861  	opts[1] = cpu_to_le32(rtl8169_tx_vlan_tag(skb));
> b423e9ae4 drivers/net/ethernet/realtek/r8169.c fran?ois romieu   2013-05-18  5862  	opts[0] = DescOwn;
> b423e9ae4 drivers/net/ethernet/realtek/r8169.c fran?ois romieu   2013-05-18  5863  
> 87945b6d8 drivers/net/ethernet/realtek/r8169.c Heiner Kallweit   2019-05-31  5864  	if (rtl_chip_supports_csum_v2(tp)) {
> 87945b6d8 drivers/net/ethernet/realtek/r8169.c Heiner Kallweit   2019-05-31  5865  		if (!rtl8169_tso_csum_v2(tp, skb, opts)) {
> e974604b4 drivers/net/ethernet/realtek/r8169.c hayeswang         2014-07-11  5866  			r8169_csum_workaround(tp, skb);
> e974604b4 drivers/net/ethernet/realtek/r8169.c hayeswang         2014-07-11  5867  			return NETDEV_TX_OK;
> e974604b4 drivers/net/ethernet/realtek/r8169.c hayeswang         2014-07-11  5868  		}
> 87945b6d8 drivers/net/ethernet/realtek/r8169.c Heiner Kallweit   2019-05-31  5869  	} else {
> 87945b6d8 drivers/net/ethernet/realtek/r8169.c Heiner Kallweit   2019-05-31  5870  		rtl8169_tso_csum_v1(skb, opts);
> 87945b6d8 drivers/net/ethernet/realtek/r8169.c Heiner Kallweit   2019-05-31  5871  	}
> b423e9ae4 drivers/net/ethernet/realtek/r8169.c fran?ois romieu   2013-05-18  5872  
> ^1da177e4 drivers/net/r8169.c                  Linus Torvalds    2005-04-16  5873  	len = skb_headlen(skb);
> 48addcc9e drivers/net/r8169.c                  Stanislaw Gruszka 2010-10-20  5874  	mapping = dma_map_single(d, skb->data, len, DMA_TO_DEVICE);
> d827d86b6 drivers/net/r8169.c                  Stanislaw Gruszka 2010-10-20  5875  	if (unlikely(dma_mapping_error(d, mapping))) {
> d827d86b6 drivers/net/r8169.c                  Stanislaw Gruszka 2010-10-20  5876  		if (net_ratelimit())
> d827d86b6 drivers/net/r8169.c                  Stanislaw Gruszka 2010-10-20  5877  			netif_err(tp, drv, dev, "Failed to map TX DMA!\n");
> 3eafe5070 drivers/net/r8169.c                  Stanislaw Gruszka 2010-10-20  5878  		goto err_dma_0;
> d827d86b6 drivers/net/r8169.c                  Stanislaw Gruszka 2010-10-20  5879  	}
> ^1da177e4 drivers/net/r8169.c                  Linus Torvalds    2005-04-16  5880  
> ^1da177e4 drivers/net/r8169.c                  Linus Torvalds    2005-04-16  5881  	tp->tx_skb[entry].len = len;
> ^1da177e4 drivers/net/r8169.c                  Linus Torvalds    2005-04-16  5882  	txd->addr = cpu_to_le64(mapping);
> ^1da177e4 drivers/net/r8169.c                  Linus Torvalds    2005-04-16  5883  
> 2b7b43185 drivers/net/r8169.c                  Francois Romieu   2011-04-18  5884  	frags = rtl8169_xmit_frags(tp, skb, opts);
> 3eafe5070 drivers/net/r8169.c                  Stanislaw Gruszka 2010-10-20  5885  	if (frags < 0)
> 3eafe5070 drivers/net/r8169.c                  Stanislaw Gruszka 2010-10-20  5886  		goto err_dma_1;
> 3eafe5070 drivers/net/r8169.c                  Stanislaw Gruszka 2010-10-20  5887  	else if (frags)
> 2b7b43185 drivers/net/r8169.c                  Francois Romieu   2011-04-18  5888  		opts[0] |= FirstFrag;
> 3eafe5070 drivers/net/r8169.c                  Stanislaw Gruszka 2010-10-20  5889  	else {
> 2b7b43185 drivers/net/r8169.c                  Francois Romieu   2011-04-18  5890  		opts[0] |= FirstFrag | LastFrag;
> 3eafe5070 drivers/net/r8169.c                  Stanislaw Gruszka 2010-10-20  5891  		tp->tx_skb[entry].skb = skb;
> 3eafe5070 drivers/net/r8169.c                  Stanislaw Gruszka 2010-10-20  5892  	}
> 3eafe5070 drivers/net/r8169.c                  Stanislaw Gruszka 2010-10-20  5893  
> 2b7b43185 drivers/net/r8169.c                  Francois Romieu   2011-04-18  5894  	txd->opts2 = cpu_to_le32(opts[1]);
> 2b7b43185 drivers/net/r8169.c                  Francois Romieu   2011-04-18  5895  
> 0255d5927 drivers/net/ethernet/realtek/r8169.c Heiner Kallweit   2019-02-10  5896  	netdev_sent_queue(dev, skb->len);
> 0255d5927 drivers/net/ethernet/realtek/r8169.c Heiner Kallweit   2019-02-10  5897  
> 5047fb5d1 drivers/net/ethernet/realtek/r8169.c Richard Cochran   2012-03-10  5898  	skb_tx_timestamp(skb);
> 5047fb5d1 drivers/net/ethernet/realtek/r8169.c Richard Cochran   2012-03-10  5899  
> a07501387 drivers/net/ethernet/realtek/r8169.c Alexander Duyck   2014-12-11  5900  	/* Force memory writes to complete before releasing descriptor */
> a07501387 drivers/net/ethernet/realtek/r8169.c Alexander Duyck   2014-12-11  5901  	dma_wmb();
> ^1da177e4 drivers/net/r8169.c                  Linus Torvalds    2005-04-16  5902  
> 734c14098 drivers/net/ethernet/realtek/r8169.c Heiner Kallweit   2018-11-22  5903  	txd->opts1 = rtl8169_get_txd_opts1(opts[0], len, entry);
> ^1da177e4 drivers/net/r8169.c                  Linus Torvalds    2005-04-16  5904  
> a07501387 drivers/net/ethernet/realtek/r8169.c Alexander Duyck   2014-12-11  5905  	/* Force all memory writes to complete before notifying device */
> 4c020a961 drivers/net/r8169.c                  David Dillow      2010-03-03  5906  	wmb();
> ^1da177e4 drivers/net/r8169.c                  Linus Torvalds    2005-04-16  5907  
> a07501387 drivers/net/ethernet/realtek/r8169.c Alexander Duyck   2014-12-11  5908  	tp->cur_tx += frags + 1;
> a07501387 drivers/net/ethernet/realtek/r8169.c Alexander Duyck   2014-12-11  5909  
> 2e6eedb48 drivers/net/ethernet/realtek/r8169.c Heiner Kallweit   2018-11-25  5910  	RTL_W8(tp, TxPoll, NPQ);
> da78dbff2 drivers/net/ethernet/realtek/r8169.c Francois Romieu   2012-01-26  5911  
> 0255d5927 drivers/net/ethernet/realtek/r8169.c Heiner Kallweit   2019-02-10  5912  	if (!rtl_tx_slots_avail(tp, MAX_SKB_FRAGS)) {
> 0255d5927 drivers/net/ethernet/realtek/r8169.c Heiner Kallweit   2019-02-10  5913  		/* Avoid wrongly optimistic queue wake-up: rtl_tx thread must
> 0255d5927 drivers/net/ethernet/realtek/r8169.c Heiner Kallweit   2019-02-10  5914  		 * not miss a ring update when it notices a stopped queue.
> 0255d5927 drivers/net/ethernet/realtek/r8169.c Heiner Kallweit   2019-02-10  5915  		 */
> 0255d5927 drivers/net/ethernet/realtek/r8169.c Heiner Kallweit   2019-02-10  5916  		smp_wmb();
> 0255d5927 drivers/net/ethernet/realtek/r8169.c Heiner Kallweit   2019-02-10  5917  		netif_stop_queue(dev);
> ae1f23fb4 drivers/net/ethernet/realtek/r8169.c Francois Romieu   2012-01-31  5918  		/* Sync with rtl_tx:
> ae1f23fb4 drivers/net/ethernet/realtek/r8169.c Francois Romieu   2012-01-31  5919  		 * - publish queue status and cur_tx ring index (write barrier)
> ae1f23fb4 drivers/net/ethernet/realtek/r8169.c Francois Romieu   2012-01-31  5920  		 * - refresh dirty_tx ring index (read barrier).
> ae1f23fb4 drivers/net/ethernet/realtek/r8169.c Francois Romieu   2012-01-31  5921  		 * May the current thread have a pessimistic view of the ring
> ae1f23fb4 drivers/net/ethernet/realtek/r8169.c Francois Romieu   2012-01-31  5922  		 * status and forget to wake up queue, a racing rtl_tx thread
> ae1f23fb4 drivers/net/ethernet/realtek/r8169.c Francois Romieu   2012-01-31  5923  		 * can't.
> ae1f23fb4 drivers/net/ethernet/realtek/r8169.c Francois Romieu   2012-01-31  5924  		 */
> 1e874e041 drivers/net/ethernet/realtek/r8169.c Francois Romieu   2012-01-27  5925  		smp_mb();
> 76085c9e7 drivers/net/ethernet/realtek/r8169.c Heiner Kallweit   2018-11-22  5926  		if (rtl_tx_slots_avail(tp, MAX_SKB_FRAGS))
> 601ed4d6d drivers/net/ethernet/realtek/r8169.c Heiner Kallweit   2019-03-21  5927  			netif_start_queue(dev);
> ^1da177e4 drivers/net/r8169.c                  Linus Torvalds    2005-04-16  5928  	}
> ^1da177e4 drivers/net/r8169.c                  Linus Torvalds    2005-04-16  5929  
> 61357325f drivers/net/r8169.c                  Stephen Hemminger 2009-08-31  5930  	return NETDEV_TX_OK;
> ^1da177e4 drivers/net/r8169.c                  Linus Torvalds    2005-04-16  5931  
> 3eafe5070 drivers/net/r8169.c                  Stanislaw Gruszka 2010-10-20  5932  err_dma_1:
> 48addcc9e drivers/net/r8169.c                  Stanislaw Gruszka 2010-10-20  5933  	rtl8169_unmap_tx_skb(d, tp->tx_skb + entry, txd);
> 3eafe5070 drivers/net/r8169.c                  Stanislaw Gruszka 2010-10-20  5934  err_dma_0:
> 989c9ba10 drivers/net/ethernet/realtek/r8169.c Eric W. Biederman 2014-03-11  5935  	dev_kfree_skb_any(skb);
> 3eafe5070 drivers/net/r8169.c                  Stanislaw Gruszka 2010-10-20  5936  	dev->stats.tx_dropped++;
> 3eafe5070 drivers/net/r8169.c                  Stanislaw Gruszka 2010-10-20  5937  	return NETDEV_TX_OK;
> 3eafe5070 drivers/net/r8169.c                  Stanislaw Gruszka 2010-10-20  5938  
> 3eafe5070 drivers/net/r8169.c                  Stanislaw Gruszka 2010-10-20  5939  err_stop_0:
> ^1da177e4 drivers/net/r8169.c                  Linus Torvalds    2005-04-16  5940  	netif_stop_queue(dev);
> cebf8cc79 drivers/net/r8169.c                  Francois Romieu   2007-10-18  5941  	dev->stats.tx_dropped++;
> 61357325f drivers/net/r8169.c                  Stephen Hemminger 2009-08-31  5942  	return NETDEV_TX_BUSY;
> ^1da177e4 drivers/net/r8169.c                  Linus Torvalds    2005-04-16  5943  }
> ^1da177e4 drivers/net/r8169.c                  Linus Torvalds    2005-04-16  5944  
> 
> :::::: The code at line 5861 was first introduced by commit
> :::::: b423e9ae49d78ea3f53b131c8d5a6087aed16fd6 r8169: fix offloaded tx checksum for small packets.
> 
> :::::: TO: fran?ois romieu <romieu@fr.zoreil.com>
> :::::: CC: David S. Miller <davem@davemloft.net>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

