From: kbuild test robot <lkp@intel.com>
Date: Wed, 24 Jul 2019 12:32:18 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 13/116]
 drivers/net/ethernet/aeroflex/greth.c:113:36: error: 'skb_frag_t {aka
 struct bio_vec}' has no member named 'size'
Message-ID: <201907241211.vApPKNPg%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   09fa75bee73107b57bfc290a4b8d5289544ccfb3
commit: 8842d285bafa9ff7719f4107b6545a11dcd41995 [13/116] net: Convert skb_frag_t to bio_vec
config: sparc64-allmodconfig (attached as .config)
compiler: sparc64-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 8842d285bafa9ff7719f4107b6545a11dcd41995
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=sparc64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/ethernet/aeroflex/greth.c: In function 'greth_print_tx_packet':
>> drivers/net/ethernet/aeroflex/greth.c:113:36: error: 'skb_frag_t {aka struct bio_vec}' has no member named 'size'
              skb_shinfo(skb)->frags[i].size, true);
                                       ^

vim +113 drivers/net/ethernet/aeroflex/greth.c

d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15    95  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15    96  static void greth_print_tx_packet(struct sk_buff *skb)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15    97  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15    98  	int i;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15    99  	int length;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   100  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   101  	if (skb_shinfo(skb)->nr_frags == 0)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   102  		length = skb->len;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   103  	else
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   104  		length = skb_headlen(skb);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   105  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   106  	print_hex_dump(KERN_DEBUG, "TX: ", DUMP_PREFIX_OFFSET, 16, 1,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   107  			skb->data, length, true);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   108  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   109  	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   110  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   111  		print_hex_dump(KERN_DEBUG, "TX: ", DUMP_PREFIX_OFFSET, 16, 1,
ab7e11d9d0293ef drivers/net/ethernet/aeroflex/greth.c Ian Campbell       2011-08-29   112  			       skb_frag_address(&skb_shinfo(skb)->frags[i]),
ab7e11d9d0293ef drivers/net/ethernet/aeroflex/greth.c Ian Campbell       2011-08-29  @113  			       skb_shinfo(skb)->frags[i].size, true);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   114  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   115  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   116  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   117  static inline void greth_enable_tx(struct greth_private *greth)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   118  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   119  	wmb();
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   120  	GRETH_REGORIN(greth->regs->control, GRETH_TXEN);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   121  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   122  
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   123  static inline void greth_enable_tx_and_irq(struct greth_private *greth)
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   124  {
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   125  	wmb(); /* BDs must been written to memory before enabling TX */
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   126  	GRETH_REGORIN(greth->regs->control, GRETH_TXEN | GRETH_TXI);
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   127  }
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   128  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   129  static inline void greth_disable_tx(struct greth_private *greth)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   130  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   131  	GRETH_REGANDIN(greth->regs->control, ~GRETH_TXEN);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   132  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   133  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   134  static inline void greth_enable_rx(struct greth_private *greth)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   135  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   136  	wmb();
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   137  	GRETH_REGORIN(greth->regs->control, GRETH_RXEN);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   138  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   139  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   140  static inline void greth_disable_rx(struct greth_private *greth)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   141  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   142  	GRETH_REGANDIN(greth->regs->control, ~GRETH_RXEN);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   143  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   144  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   145  static inline void greth_enable_irqs(struct greth_private *greth)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   146  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   147  	GRETH_REGORIN(greth->regs->control, GRETH_RXI | GRETH_TXI);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   148  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   149  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   150  static inline void greth_disable_irqs(struct greth_private *greth)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   151  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   152  	GRETH_REGANDIN(greth->regs->control, ~(GRETH_RXI|GRETH_TXI));
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   153  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   154  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   155  static inline void greth_write_bd(u32 *bd, u32 val)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   156  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   157  	__raw_writel(cpu_to_be32(val), bd);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   158  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   159  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   160  static inline u32 greth_read_bd(u32 *bd)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   161  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   162  	return be32_to_cpu(__raw_readl(bd));
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   163  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   164  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   165  static void greth_clean_rings(struct greth_private *greth)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   166  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   167  	int i;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   168  	struct greth_bd *rx_bdp = greth->rx_bd_base;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   169  	struct greth_bd *tx_bdp = greth->tx_bd_base;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   170  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   171  	if (greth->gbit_mac) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   172  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   173  		/* Free and unmap RX buffers */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   174  		for (i = 0; i < GRETH_RXBD_NUM; i++, rx_bdp++) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   175  			if (greth->rx_skbuff[i] != NULL) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   176  				dev_kfree_skb(greth->rx_skbuff[i]);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   177  				dma_unmap_single(greth->dev,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   178  						 greth_read_bd(&rx_bdp->addr),
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   179  						 MAX_FRAME_SIZE+NET_IP_ALIGN,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   180  						 DMA_FROM_DEVICE);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   181  			}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   182  		}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   183  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   184  		/* TX buffers */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   185  		while (greth->tx_free < GRETH_TXBD_NUM) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   186  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   187  			struct sk_buff *skb = greth->tx_skbuff[greth->tx_last];
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   188  			int nr_frags = skb_shinfo(skb)->nr_frags;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   189  			tx_bdp = greth->tx_bd_base + greth->tx_last;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   190  			greth->tx_last = NEXT_TX(greth->tx_last);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   191  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   192  			dma_unmap_single(greth->dev,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   193  					 greth_read_bd(&tx_bdp->addr),
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   194  					 skb_headlen(skb),
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   195  					 DMA_TO_DEVICE);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   196  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   197  			for (i = 0; i < nr_frags; i++) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   198  				skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   199  				tx_bdp = greth->tx_bd_base + greth->tx_last;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   200  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   201  				dma_unmap_page(greth->dev,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   202  					       greth_read_bd(&tx_bdp->addr),
9e903e085262ffb drivers/net/ethernet/aeroflex/greth.c Eric Dumazet       2011-10-18   203  					       skb_frag_size(frag),
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   204  					       DMA_TO_DEVICE);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   205  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   206  				greth->tx_last = NEXT_TX(greth->tx_last);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   207  			}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   208  			greth->tx_free += nr_frags+1;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   209  			dev_kfree_skb(skb);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   210  		}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   211  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   212  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   213  	} else { /* 10/100 Mbps MAC */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   214  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   215  		for (i = 0; i < GRETH_RXBD_NUM; i++, rx_bdp++) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   216  			kfree(greth->rx_bufs[i]);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   217  			dma_unmap_single(greth->dev,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   218  					 greth_read_bd(&rx_bdp->addr),
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   219  					 MAX_FRAME_SIZE,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   220  					 DMA_FROM_DEVICE);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   221  		}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   222  		for (i = 0; i < GRETH_TXBD_NUM; i++, tx_bdp++) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   223  			kfree(greth->tx_bufs[i]);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   224  			dma_unmap_single(greth->dev,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   225  					 greth_read_bd(&tx_bdp->addr),
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   226  					 MAX_FRAME_SIZE,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   227  					 DMA_TO_DEVICE);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   228  		}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   229  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   230  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   231  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   232  static int greth_init_rings(struct greth_private *greth)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   233  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   234  	struct sk_buff *skb;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   235  	struct greth_bd *rx_bd, *tx_bd;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   236  	u32 dma_addr;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   237  	int i;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   238  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   239  	rx_bd = greth->rx_bd_base;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   240  	tx_bd = greth->tx_bd_base;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   241  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   242  	/* Initialize descriptor rings and buffers */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   243  	if (greth->gbit_mac) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   244  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   245  		for (i = 0; i < GRETH_RXBD_NUM; i++) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   246  			skb = netdev_alloc_skb(greth->netdev, MAX_FRAME_SIZE+NET_IP_ALIGN);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   247  			if (skb == NULL) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   248  				if (netif_msg_ifup(greth))
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   249  					dev_err(greth->dev, "Error allocating DMA ring.\n");
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   250  				goto cleanup;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   251  			}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   252  			skb_reserve(skb, NET_IP_ALIGN);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   253  			dma_addr = dma_map_single(greth->dev,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   254  						  skb->data,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   255  						  MAX_FRAME_SIZE+NET_IP_ALIGN,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   256  						  DMA_FROM_DEVICE);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   257  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   258  			if (dma_mapping_error(greth->dev, dma_addr)) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   259  				if (netif_msg_ifup(greth))
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   260  					dev_err(greth->dev, "Could not create initial DMA mapping\n");
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   261  				goto cleanup;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   262  			}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   263  			greth->rx_skbuff[i] = skb;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   264  			greth_write_bd(&rx_bd[i].addr, dma_addr);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   265  			greth_write_bd(&rx_bd[i].stat, GRETH_BD_EN | GRETH_BD_IE);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   266  		}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   267  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   268  	} else {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   269  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   270  		/* 10/100 MAC uses a fixed set of buffers and copy to/from SKBs */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   271  		for (i = 0; i < GRETH_RXBD_NUM; i++) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   272  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   273  			greth->rx_bufs[i] = kmalloc(MAX_FRAME_SIZE, GFP_KERNEL);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   274  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   275  			if (greth->rx_bufs[i] == NULL) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   276  				if (netif_msg_ifup(greth))
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   277  					dev_err(greth->dev, "Error allocating DMA ring.\n");
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   278  				goto cleanup;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   279  			}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   280  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   281  			dma_addr = dma_map_single(greth->dev,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   282  						  greth->rx_bufs[i],
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   283  						  MAX_FRAME_SIZE,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   284  						  DMA_FROM_DEVICE);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   285  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   286  			if (dma_mapping_error(greth->dev, dma_addr)) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   287  				if (netif_msg_ifup(greth))
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   288  					dev_err(greth->dev, "Could not create initial DMA mapping\n");
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   289  				goto cleanup;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   290  			}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   291  			greth_write_bd(&rx_bd[i].addr, dma_addr);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   292  			greth_write_bd(&rx_bd[i].stat, GRETH_BD_EN | GRETH_BD_IE);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   293  		}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   294  		for (i = 0; i < GRETH_TXBD_NUM; i++) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   295  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   296  			greth->tx_bufs[i] = kmalloc(MAX_FRAME_SIZE, GFP_KERNEL);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   297  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   298  			if (greth->tx_bufs[i] == NULL) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   299  				if (netif_msg_ifup(greth))
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   300  					dev_err(greth->dev, "Error allocating DMA ring.\n");
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   301  				goto cleanup;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   302  			}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   303  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   304  			dma_addr = dma_map_single(greth->dev,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   305  						  greth->tx_bufs[i],
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   306  						  MAX_FRAME_SIZE,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   307  						  DMA_TO_DEVICE);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   308  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   309  			if (dma_mapping_error(greth->dev, dma_addr)) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   310  				if (netif_msg_ifup(greth))
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   311  					dev_err(greth->dev, "Could not create initial DMA mapping\n");
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   312  				goto cleanup;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   313  			}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   314  			greth_write_bd(&tx_bd[i].addr, dma_addr);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   315  			greth_write_bd(&tx_bd[i].stat, 0);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   316  		}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   317  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   318  	greth_write_bd(&rx_bd[GRETH_RXBD_NUM - 1].stat,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   319  		       greth_read_bd(&rx_bd[GRETH_RXBD_NUM - 1].stat) | GRETH_BD_WR);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   320  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   321  	/* Initialize pointers. */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   322  	greth->rx_cur = 0;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   323  	greth->tx_next = 0;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   324  	greth->tx_last = 0;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   325  	greth->tx_free = GRETH_TXBD_NUM;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   326  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   327  	/* Initialize descriptor base address */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   328  	GRETH_REGSAVE(greth->regs->tx_desc_p, greth->tx_bd_base_phys);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   329  	GRETH_REGSAVE(greth->regs->rx_desc_p, greth->rx_bd_base_phys);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   330  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   331  	return 0;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   332  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   333  cleanup:
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   334  	greth_clean_rings(greth);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   335  	return -ENOMEM;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   336  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   337  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   338  static int greth_open(struct net_device *dev)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   339  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   340  	struct greth_private *greth = netdev_priv(dev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   341  	int err;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   342  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   343  	err = greth_init_rings(greth);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   344  	if (err) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   345  		if (netif_msg_ifup(greth))
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   346  			dev_err(&dev->dev, "Could not allocate memory for DMA rings\n");
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   347  		return err;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   348  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   349  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   350  	err = request_irq(greth->irq, greth_interrupt, 0, "eth", (void *) dev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   351  	if (err) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   352  		if (netif_msg_ifup(greth))
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   353  			dev_err(&dev->dev, "Could not allocate interrupt %d\n", dev->irq);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   354  		greth_clean_rings(greth);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   355  		return err;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   356  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   357  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   358  	if (netif_msg_ifup(greth))
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   359  		dev_dbg(&dev->dev, " starting queue\n");
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   360  	netif_start_queue(dev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   361  
bbe9e637330abe5 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   362  	GRETH_REGSAVE(greth->regs->status, 0xFF);
bbe9e637330abe5 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   363  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   364  	napi_enable(&greth->napi);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   365  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   366  	greth_enable_irqs(greth);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   367  	greth_enable_tx(greth);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   368  	greth_enable_rx(greth);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   369  	return 0;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   370  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   371  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   372  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   373  static int greth_close(struct net_device *dev)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   374  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   375  	struct greth_private *greth = netdev_priv(dev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   376  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   377  	napi_disable(&greth->napi);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   378  
bbe9e637330abe5 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   379  	greth_disable_irqs(greth);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   380  	greth_disable_tx(greth);
bbe9e637330abe5 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   381  	greth_disable_rx(greth);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   382  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   383  	netif_stop_queue(dev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   384  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   385  	free_irq(greth->irq, (void *) dev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   386  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   387  	greth_clean_rings(greth);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   388  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   389  	return 0;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   390  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   391  
41a655ba5654e47 drivers/net/greth.c                   kirjanov at gmail.com 2010-02-24   392  static netdev_tx_t
41a655ba5654e47 drivers/net/greth.c                   kirjanov at gmail.com 2010-02-24   393  greth_start_xmit(struct sk_buff *skb, struct net_device *dev)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   394  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   395  	struct greth_private *greth = netdev_priv(dev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   396  	struct greth_bd *bdp;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   397  	int err = NETDEV_TX_OK;
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   398  	u32 status, dma_addr, ctrl;
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   399  	unsigned long flags;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   400  
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   401  	/* Clean TX Ring */
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   402  	greth_clean_tx(greth->netdev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   403  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   404  	if (unlikely(greth->tx_free <= 0)) {
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   405  		spin_lock_irqsave(&greth->devlock, flags);/*save from poll/irq*/
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   406  		ctrl = GRETH_REGLOAD(greth->regs->control);
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   407  		/* Enable TX IRQ only if not already in poll() routine */
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   408  		if (ctrl & GRETH_RXI)
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   409  			GRETH_REGSAVE(greth->regs->control, ctrl | GRETH_TXI);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   410  		netif_stop_queue(dev);
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   411  		spin_unlock_irqrestore(&greth->devlock, flags);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   412  		return NETDEV_TX_BUSY;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   413  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   414  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   415  	if (netif_msg_pktdata(greth))
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   416  		greth_print_tx_packet(skb);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   417  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   418  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   419  	if (unlikely(skb->len > MAX_FRAME_SIZE)) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   420  		dev->stats.tx_errors++;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   421  		goto out;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   422  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   423  
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   424  	bdp = greth->tx_bd_base + greth->tx_next;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   425  	dma_addr = greth_read_bd(&bdp->addr);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   426  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   427  	memcpy((unsigned char *) phys_to_virt(dma_addr), skb->data, skb->len);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   428  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   429  	dma_sync_single_for_device(greth->dev, dma_addr, skb->len, DMA_TO_DEVICE);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   430  
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   431  	status = GRETH_BD_EN | GRETH_BD_IE | (skb->len & GRETH_BD_LEN);
6af29a963cecf42 drivers/net/greth.c                   Daniel Hellstrom   2011-09-08   432  	greth->tx_bufs_length[greth->tx_next] = skb->len & GRETH_BD_LEN;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   433  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   434  	/* Wrap around descriptor ring */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   435  	if (greth->tx_next == GRETH_TXBD_NUM_MASK) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   436  		status |= GRETH_BD_WR;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   437  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   438  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   439  	greth->tx_next = NEXT_TX(greth->tx_next);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   440  	greth->tx_free--;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   441  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   442  	/* Write descriptor control word and enable transmission */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   443  	greth_write_bd(&bdp->stat, status);
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   444  	spin_lock_irqsave(&greth->devlock, flags); /*save from poll/irq*/
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   445  	greth_enable_tx(greth);
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   446  	spin_unlock_irqrestore(&greth->devlock, flags);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   447  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   448  out:
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   449  	dev_kfree_skb(skb);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   450  	return err;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   451  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   452  
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   453  static inline u16 greth_num_free_bds(u16 tx_last, u16 tx_next)
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   454  {
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   455  	if (tx_next < tx_last)
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   456  		return (tx_last - tx_next) - 1;
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   457  	else
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   458  		return GRETH_TXBD_NUM - (tx_next - tx_last) - 1;
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   459  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   460  
41a655ba5654e47 drivers/net/greth.c                   kirjanov at gmail.com 2010-02-24   461  static netdev_tx_t
41a655ba5654e47 drivers/net/greth.c                   kirjanov@gmail.com 2010-02-24   462  greth_start_xmit_gbit(struct sk_buff *skb, struct net_device *dev)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   463  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   464  	struct greth_private *greth = netdev_priv(dev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   465  	struct greth_bd *bdp;
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   466  	u32 status, dma_addr;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   467  	int curr_tx, nr_frags, i, err = NETDEV_TX_OK;
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   468  	unsigned long flags;
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   469  	u16 tx_last;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   470  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   471  	nr_frags = skb_shinfo(skb)->nr_frags;
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   472  	tx_last = greth->tx_last;
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   473  	rmb(); /* tx_last is updated by the poll task */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   474  
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   475  	if (greth_num_free_bds(tx_last, greth->tx_next) < nr_frags + 1) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   476  		netif_stop_queue(dev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   477  		err = NETDEV_TX_BUSY;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   478  		goto out;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   479  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   480  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   481  	if (netif_msg_pktdata(greth))
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   482  		greth_print_tx_packet(skb);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   483  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   484  	if (unlikely(skb->len > MAX_FRAME_SIZE)) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   485  		dev->stats.tx_errors++;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   486  		goto out;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   487  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   488  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   489  	/* Save skb pointer. */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   490  	greth->tx_skbuff[greth->tx_next] = skb;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   491  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   492  	/* Linear buf */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   493  	if (nr_frags != 0)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   494  		status = GRETH_TXBD_MORE;
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   495  	else
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   496  		status = GRETH_BD_IE;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   497  
d706f00f6514682 drivers/net/greth.c                   Daniel Hellstrom   2011-09-09   498  	if (skb->ip_summed == CHECKSUM_PARTIAL)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   499  		status |= GRETH_TXBD_CSALL;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   500  	status |= skb_headlen(skb) & GRETH_BD_LEN;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   501  	if (greth->tx_next == GRETH_TXBD_NUM_MASK)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   502  		status |= GRETH_BD_WR;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   503  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   504  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   505  	bdp = greth->tx_bd_base + greth->tx_next;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   506  	greth_write_bd(&bdp->stat, status);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   507  	dma_addr = dma_map_single(greth->dev, skb->data, skb_headlen(skb), DMA_TO_DEVICE);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   508  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   509  	if (unlikely(dma_mapping_error(greth->dev, dma_addr)))
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   510  		goto map_error;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   511  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   512  	greth_write_bd(&bdp->addr, dma_addr);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   513  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   514  	curr_tx = NEXT_TX(greth->tx_next);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   515  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   516  	/* Frags */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   517  	for (i = 0; i < nr_frags; i++) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   518  		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   519  		greth->tx_skbuff[curr_tx] = NULL;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   520  		bdp = greth->tx_bd_base + curr_tx;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   521  
d706f00f6514682 drivers/net/greth.c                   Daniel Hellstrom   2011-09-09   522  		status = GRETH_BD_EN;
d706f00f6514682 drivers/net/greth.c                   Daniel Hellstrom   2011-09-09   523  		if (skb->ip_summed == CHECKSUM_PARTIAL)
d706f00f6514682 drivers/net/greth.c                   Daniel Hellstrom   2011-09-09   524  			status |= GRETH_TXBD_CSALL;
9e903e085262ffb drivers/net/ethernet/aeroflex/greth.c Eric Dumazet       2011-10-18   525  		status |= skb_frag_size(frag) & GRETH_BD_LEN;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   526  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   527  		/* Wrap around descriptor ring */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   528  		if (curr_tx == GRETH_TXBD_NUM_MASK)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   529  			status |= GRETH_BD_WR;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   530  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   531  		/* More fragments left */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   532  		if (i < nr_frags - 1)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   533  			status |= GRETH_TXBD_MORE;
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   534  		else
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   535  			status |= GRETH_BD_IE; /* enable IRQ on last fragment */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   536  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   537  		greth_write_bd(&bdp->stat, status);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   538  
9e903e085262ffb drivers/net/ethernet/aeroflex/greth.c Eric Dumazet       2011-10-18   539  		dma_addr = skb_frag_dma_map(greth->dev, frag, 0, skb_frag_size(frag),
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   540  					    DMA_TO_DEVICE);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   541  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   542  		if (unlikely(dma_mapping_error(greth->dev, dma_addr)))
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   543  			goto frag_map_error;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   544  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   545  		greth_write_bd(&bdp->addr, dma_addr);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   546  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   547  		curr_tx = NEXT_TX(curr_tx);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   548  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   549  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   550  	wmb();
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   551  
2a2bc012b98729c drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   552  	/* Enable the descriptor chain by enabling the first descriptor */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   553  	bdp = greth->tx_bd_base + greth->tx_next;
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   554  	greth_write_bd(&bdp->stat,
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   555  		       greth_read_bd(&bdp->stat) | GRETH_BD_EN);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   556  
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   557  	spin_lock_irqsave(&greth->devlock, flags); /*save from poll/irq*/
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   558  	greth->tx_next = curr_tx;
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   559  	greth_enable_tx_and_irq(greth);
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   560  	spin_unlock_irqrestore(&greth->devlock, flags);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   561  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   562  	return NETDEV_TX_OK;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   563  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   564  frag_map_error:
2a2bc012b98729c drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   565  	/* Unmap SKB mappings that succeeded and disable descriptor */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   566  	for (i = 0; greth->tx_next + i != curr_tx; i++) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   567  		bdp = greth->tx_bd_base + greth->tx_next + i;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   568  		dma_unmap_single(greth->dev,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   569  				 greth_read_bd(&bdp->addr),
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   570  				 greth_read_bd(&bdp->stat) & GRETH_BD_LEN,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   571  				 DMA_TO_DEVICE);
2a2bc012b98729c drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   572  		greth_write_bd(&bdp->stat, 0);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   573  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   574  map_error:
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   575  	if (net_ratelimit())
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   576  		dev_warn(greth->dev, "Could not create TX DMA mapping\n");
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   577  	dev_kfree_skb(skb);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   578  out:
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   579  	return err;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   580  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   581  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   582  static irqreturn_t greth_interrupt(int irq, void *dev_id)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   583  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   584  	struct net_device *dev = dev_id;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   585  	struct greth_private *greth;
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   586  	u32 status, ctrl;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   587  	irqreturn_t retval = IRQ_NONE;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   588  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   589  	greth = netdev_priv(dev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   590  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   591  	spin_lock(&greth->devlock);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   592  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   593  	/* Get the interrupt events that caused us to be here. */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   594  	status = GRETH_REGLOAD(greth->regs->status);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   595  
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   596  	/* Must see if interrupts are enabled also, INT_TX|INT_RX flags may be
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   597  	 * set regardless of whether IRQ is enabled or not. Especially
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   598  	 * important when shared IRQ.
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   599  	 */
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   600  	ctrl = GRETH_REGLOAD(greth->regs->control);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   601  
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   602  	/* Handle rx and tx interrupts through poll */
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   603  	if (((status & (GRETH_INT_RE | GRETH_INT_RX)) && (ctrl & GRETH_RXI)) ||
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   604  	    ((status & (GRETH_INT_TE | GRETH_INT_TX)) && (ctrl & GRETH_TXI))) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   605  		retval = IRQ_HANDLED;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   606  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   607  		/* Disable interrupts and schedule poll() */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   608  		greth_disable_irqs(greth);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   609  		napi_schedule(&greth->napi);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   610  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   611  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   612  	spin_unlock(&greth->devlock);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   613  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   614  	return retval;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   615  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   616  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   617  static void greth_clean_tx(struct net_device *dev)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   618  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   619  	struct greth_private *greth;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   620  	struct greth_bd *bdp;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   621  	u32 stat;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   622  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   623  	greth = netdev_priv(dev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   624  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   625  	while (1) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   626  		bdp = greth->tx_bd_base + greth->tx_last;
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   627  		GRETH_REGSAVE(greth->regs->status, GRETH_INT_TE | GRETH_INT_TX);
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   628  		mb();
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   629  		stat = greth_read_bd(&bdp->stat);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   630  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   631  		if (unlikely(stat & GRETH_BD_EN))
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   632  			break;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   633  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   634  		if (greth->tx_free == GRETH_TXBD_NUM)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   635  			break;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   636  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   637  		/* Check status for errors */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   638  		if (unlikely(stat & GRETH_TXBD_STATUS)) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   639  			dev->stats.tx_errors++;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   640  			if (stat & GRETH_TXBD_ERR_AL)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   641  				dev->stats.tx_aborted_errors++;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   642  			if (stat & GRETH_TXBD_ERR_UE)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   643  				dev->stats.tx_fifo_errors++;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   644  		}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   645  		dev->stats.tx_packets++;
6af29a963cecf42 drivers/net/greth.c                   Daniel Hellstrom   2011-09-08   646  		dev->stats.tx_bytes += greth->tx_bufs_length[greth->tx_last];
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   647  		greth->tx_last = NEXT_TX(greth->tx_last);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   648  		greth->tx_free++;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   649  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   650  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   651  	if (greth->tx_free > 0) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   652  		netif_wake_queue(dev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   653  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   654  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   655  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   656  static inline void greth_update_tx_stats(struct net_device *dev, u32 stat)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   657  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   658  	/* Check status for errors */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   659  	if (unlikely(stat & GRETH_TXBD_STATUS)) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   660  		dev->stats.tx_errors++;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   661  		if (stat & GRETH_TXBD_ERR_AL)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   662  			dev->stats.tx_aborted_errors++;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   663  		if (stat & GRETH_TXBD_ERR_UE)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   664  			dev->stats.tx_fifo_errors++;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   665  		if (stat & GRETH_TXBD_ERR_LC)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   666  			dev->stats.tx_aborted_errors++;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   667  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   668  	dev->stats.tx_packets++;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   669  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   670  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   671  static void greth_clean_tx_gbit(struct net_device *dev)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   672  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   673  	struct greth_private *greth;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   674  	struct greth_bd *bdp, *bdp_last_frag;
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   675  	struct sk_buff *skb = NULL;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   676  	u32 stat;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   677  	int nr_frags, i;
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   678  	u16 tx_last;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   679  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   680  	greth = netdev_priv(dev);
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   681  	tx_last = greth->tx_last;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   682  
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   683  	while (tx_last != greth->tx_next) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   684  
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   685  		skb = greth->tx_skbuff[tx_last];
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   686  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   687  		nr_frags = skb_shinfo(skb)->nr_frags;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   688  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   689  		/* We only clean fully completed SKBs */
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   690  		bdp_last_frag = greth->tx_bd_base + SKIP_TX(tx_last, nr_frags);
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   691  
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   692  		GRETH_REGSAVE(greth->regs->status, GRETH_INT_TE | GRETH_INT_TX);
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   693  		mb();
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   694  		stat = greth_read_bd(&bdp_last_frag->stat);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   695  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   696  		if (stat & GRETH_BD_EN)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   697  			break;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   698  
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   699  		greth->tx_skbuff[tx_last] = NULL;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   700  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   701  		greth_update_tx_stats(dev, stat);
6af29a963cecf42 drivers/net/greth.c                   Daniel Hellstrom   2011-09-08   702  		dev->stats.tx_bytes += skb->len;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   703  
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   704  		bdp = greth->tx_bd_base + tx_last;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   705  
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   706  		tx_last = NEXT_TX(tx_last);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   707  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   708  		dma_unmap_single(greth->dev,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   709  				 greth_read_bd(&bdp->addr),
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   710  				 skb_headlen(skb),
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   711  				 DMA_TO_DEVICE);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   712  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   713  		for (i = 0; i < nr_frags; i++) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   714  			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   715  			bdp = greth->tx_bd_base + tx_last;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   716  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   717  			dma_unmap_page(greth->dev,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   718  				       greth_read_bd(&bdp->addr),
9e903e085262ffb drivers/net/ethernet/aeroflex/greth.c Eric Dumazet       2011-10-18   719  				       skb_frag_size(frag),
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   720  				       DMA_TO_DEVICE);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   721  
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   722  			tx_last = NEXT_TX(tx_last);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   723  		}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   724  		dev_kfree_skb(skb);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   725  	}
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   726  	if (skb) { /* skb is set only if the above while loop was entered */
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   727  		wmb();
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   728  		greth->tx_last = tx_last;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   729  
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   730  		if (netif_queue_stopped(dev) &&
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   731  		    (greth_num_free_bds(tx_last, greth->tx_next) >
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   732  		    (MAX_SKB_FRAGS+1)))
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   733  			netif_wake_queue(dev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   734  	}
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   735  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   736  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   737  static int greth_rx(struct net_device *dev, int limit)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   738  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   739  	struct greth_private *greth;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   740  	struct greth_bd *bdp;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   741  	struct sk_buff *skb;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   742  	int pkt_len;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   743  	int bad, count;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   744  	u32 status, dma_addr;
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   745  	unsigned long flags;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   746  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   747  	greth = netdev_priv(dev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   748  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   749  	for (count = 0; count < limit; ++count) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   750  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   751  		bdp = greth->rx_bd_base + greth->rx_cur;
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   752  		GRETH_REGSAVE(greth->regs->status, GRETH_INT_RE | GRETH_INT_RX);
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   753  		mb();
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   754  		status = greth_read_bd(&bdp->stat);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   755  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   756  		if (unlikely(status & GRETH_BD_EN)) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   757  			break;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   758  		}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   759  
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   760  		dma_addr = greth_read_bd(&bdp->addr);
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   761  		bad = 0;
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   762  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   763  		/* Check status for errors. */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   764  		if (unlikely(status & GRETH_RXBD_STATUS)) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   765  			if (status & GRETH_RXBD_ERR_FT) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   766  				dev->stats.rx_length_errors++;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   767  				bad = 1;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   768  			}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   769  			if (status & (GRETH_RXBD_ERR_AE | GRETH_RXBD_ERR_OE)) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   770  				dev->stats.rx_frame_errors++;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   771  				bad = 1;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   772  			}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   773  			if (status & GRETH_RXBD_ERR_CRC) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   774  				dev->stats.rx_crc_errors++;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   775  				bad = 1;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   776  			}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   777  		}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   778  		if (unlikely(bad)) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   779  			dev->stats.rx_errors++;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   780  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   781  		} else {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   782  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   783  			pkt_len = status & GRETH_BD_LEN;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   784  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   785  			skb = netdev_alloc_skb(dev, pkt_len + NET_IP_ALIGN);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   786  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   787  			if (unlikely(skb == NULL)) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   788  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   789  				if (net_ratelimit())
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   790  					dev_warn(&dev->dev, "low on memory - " "packet dropped\n");
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   791  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   792  				dev->stats.rx_dropped++;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   793  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   794  			} else {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   795  				skb_reserve(skb, NET_IP_ALIGN);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   796  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   797  				dma_sync_single_for_cpu(greth->dev,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   798  							dma_addr,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   799  							pkt_len,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   800  							DMA_FROM_DEVICE);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   801  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   802  				if (netif_msg_pktdata(greth))
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   803  					greth_print_rx_packet(phys_to_virt(dma_addr), pkt_len);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   804  
59ae1d127ac0ae4 drivers/net/ethernet/aeroflex/greth.c Johannes Berg      2017-06-16   805  				skb_put_data(skb, phys_to_virt(dma_addr),
59ae1d127ac0ae4 drivers/net/ethernet/aeroflex/greth.c Johannes Berg      2017-06-16   806  					     pkt_len);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   807  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   808  				skb->protocol = eth_type_trans(skb, dev);
6af29a963cecf42 drivers/net/greth.c                   Daniel Hellstrom   2011-09-08   809  				dev->stats.rx_bytes += pkt_len;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   810  				dev->stats.rx_packets++;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   811  				netif_receive_skb(skb);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   812  			}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   813  		}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   814  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   815  		status = GRETH_BD_EN | GRETH_BD_IE;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   816  		if (greth->rx_cur == GRETH_RXBD_NUM_MASK) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   817  			status |= GRETH_BD_WR;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   818  		}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   819  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   820  		wmb();
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   821  		greth_write_bd(&bdp->stat, status);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   822  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   823  		dma_sync_single_for_device(greth->dev, dma_addr, MAX_FRAME_SIZE, DMA_FROM_DEVICE);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   824  
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   825  		spin_lock_irqsave(&greth->devlock, flags); /* save from XMIT */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   826  		greth_enable_rx(greth);
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   827  		spin_unlock_irqrestore(&greth->devlock, flags);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   828  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   829  		greth->rx_cur = NEXT_RX(greth->rx_cur);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   830  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   831  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   832  	return count;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   833  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   834  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   835  static inline int hw_checksummed(u32 status)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   836  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   837  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   838  	if (status & GRETH_RXBD_IP_FRAG)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   839  		return 0;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   840  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   841  	if (status & GRETH_RXBD_IP && status & GRETH_RXBD_IP_CSERR)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   842  		return 0;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   843  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   844  	if (status & GRETH_RXBD_UDP && status & GRETH_RXBD_UDP_CSERR)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   845  		return 0;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   846  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   847  	if (status & GRETH_RXBD_TCP && status & GRETH_RXBD_TCP_CSERR)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   848  		return 0;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   849  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   850  	return 1;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   851  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   852  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   853  static int greth_rx_gbit(struct net_device *dev, int limit)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   854  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   855  	struct greth_private *greth;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   856  	struct greth_bd *bdp;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   857  	struct sk_buff *skb, *newskb;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   858  	int pkt_len;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   859  	int bad, count = 0;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   860  	u32 status, dma_addr;
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   861  	unsigned long flags;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   862  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   863  	greth = netdev_priv(dev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   864  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   865  	for (count = 0; count < limit; ++count) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   866  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   867  		bdp = greth->rx_bd_base + greth->rx_cur;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   868  		skb = greth->rx_skbuff[greth->rx_cur];
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   869  		GRETH_REGSAVE(greth->regs->status, GRETH_INT_RE | GRETH_INT_RX);
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   870  		mb();
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   871  		status = greth_read_bd(&bdp->stat);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   872  		bad = 0;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   873  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   874  		if (status & GRETH_BD_EN)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   875  			break;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   876  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   877  		/* Check status for errors. */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   878  		if (unlikely(status & GRETH_RXBD_STATUS)) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   879  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   880  			if (status & GRETH_RXBD_ERR_FT) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   881  				dev->stats.rx_length_errors++;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   882  				bad = 1;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   883  			} else if (status &
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   884  				   (GRETH_RXBD_ERR_AE | GRETH_RXBD_ERR_OE | GRETH_RXBD_ERR_LE)) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   885  				dev->stats.rx_frame_errors++;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   886  				bad = 1;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   887  			} else if (status & GRETH_RXBD_ERR_CRC) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   888  				dev->stats.rx_crc_errors++;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   889  				bad = 1;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   890  			}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   891  		}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   892  
b669e7f0580f3c0 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   893  		/* Allocate new skb to replace current, not needed if the
b669e7f0580f3c0 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   894  		 * current skb can be reused */
b669e7f0580f3c0 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   895  		if (!bad && (newskb=netdev_alloc_skb(dev, MAX_FRAME_SIZE + NET_IP_ALIGN))) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   896  			skb_reserve(newskb, NET_IP_ALIGN);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   897  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   898  			dma_addr = dma_map_single(greth->dev,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   899  						      newskb->data,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   900  						      MAX_FRAME_SIZE + NET_IP_ALIGN,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   901  						      DMA_FROM_DEVICE);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   902  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   903  			if (!dma_mapping_error(greth->dev, dma_addr)) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   904  				/* Process the incoming frame. */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   905  				pkt_len = status & GRETH_BD_LEN;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   906  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   907  				dma_unmap_single(greth->dev,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   908  						 greth_read_bd(&bdp->addr),
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   909  						 MAX_FRAME_SIZE + NET_IP_ALIGN,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   910  						 DMA_FROM_DEVICE);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   911  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   912  				if (netif_msg_pktdata(greth))
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   913  					greth_print_rx_packet(phys_to_virt(greth_read_bd(&bdp->addr)), pkt_len);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   914  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   915  				skb_put(skb, pkt_len);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   916  
131ae329702755d drivers/net/greth.c                   Micha?? Miros??aw    2011-04-17   917  				if (dev->features & NETIF_F_RXCSUM && hw_checksummed(status))
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   918  					skb->ip_summed = CHECKSUM_UNNECESSARY;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   919  				else
bc8acf2c8c3e43f drivers/net/greth.c                   Eric Dumazet       2010-09-02   920  					skb_checksum_none_assert(skb);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   921  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   922  				skb->protocol = eth_type_trans(skb, dev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   923  				dev->stats.rx_packets++;
6af29a963cecf42 drivers/net/greth.c                   Daniel Hellstrom   2011-09-08   924  				dev->stats.rx_bytes += pkt_len;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   925  				netif_receive_skb(skb);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   926  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   927  				greth->rx_skbuff[greth->rx_cur] = newskb;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   928  				greth_write_bd(&bdp->addr, dma_addr);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   929  			} else {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   930  				if (net_ratelimit())
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   931  					dev_warn(greth->dev, "Could not create DMA mapping, dropping packet\n");
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   932  				dev_kfree_skb(newskb);
b669e7f0580f3c0 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   933  				/* reusing current skb, so it is a drop */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   934  				dev->stats.rx_dropped++;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   935  			}
b669e7f0580f3c0 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   936  		} else if (bad) {
b669e7f0580f3c0 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   937  			/* Bad Frame transfer, the skb is reused */
b669e7f0580f3c0 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   938  			dev->stats.rx_dropped++;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   939  		} else {
b669e7f0580f3c0 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   940  			/* Failed Allocating a new skb. This is rather stupid
b669e7f0580f3c0 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   941  			 * but the current "filled" skb is reused, as if
b669e7f0580f3c0 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   942  			 * transfer failure. One could argue that RX descriptor
b669e7f0580f3c0 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   943  			 * table handling should be divided into cleaning and
b669e7f0580f3c0 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   944  			 * filling as the TX part of the driver
b669e7f0580f3c0 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   945  			 */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   946  			if (net_ratelimit())
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   947  				dev_warn(greth->dev, "Could not allocate SKB, dropping packet\n");
b669e7f0580f3c0 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   948  			/* reusing current skb, so it is a drop */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   949  			dev->stats.rx_dropped++;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   950  		}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   951  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   952  		status = GRETH_BD_EN | GRETH_BD_IE;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   953  		if (greth->rx_cur == GRETH_RXBD_NUM_MASK) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   954  			status |= GRETH_BD_WR;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   955  		}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   956  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   957  		wmb();
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   958  		greth_write_bd(&bdp->stat, status);
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   959  		spin_lock_irqsave(&greth->devlock, flags);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   960  		greth_enable_rx(greth);
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   961  		spin_unlock_irqrestore(&greth->devlock, flags);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   962  		greth->rx_cur = NEXT_RX(greth->rx_cur);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   963  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   964  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   965  	return count;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   966  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   967  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   968  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   969  static int greth_poll(struct napi_struct *napi, int budget)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   970  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   971  	struct greth_private *greth;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   972  	int work_done = 0;
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   973  	unsigned long flags;
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   974  	u32 mask, ctrl;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   975  	greth = container_of(napi, struct greth_private, napi);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   976  
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   977  restart_txrx_poll:
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   978  	if (greth->gbit_mac) {
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   979  		greth_clean_tx_gbit(greth->netdev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   980  		work_done += greth_rx_gbit(greth->netdev, budget - work_done);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   981  	} else {
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   982  		if (netif_queue_stopped(greth->netdev))
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   983  			greth_clean_tx(greth->netdev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   984  		work_done += greth_rx(greth->netdev, budget - work_done);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   985  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   986  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   987  	if (work_done < budget) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   988  
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   989  		spin_lock_irqsave(&greth->devlock, flags);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15   990  
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   991  		ctrl = GRETH_REGLOAD(greth->regs->control);
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   992  		if ((greth->gbit_mac && (greth->tx_last != greth->tx_next)) ||
e1743a16a043f3d drivers/net/ethernet/aeroflex/greth.c Daniel Hellstrom   2014-09-05   993  		    (!greth->gbit_mac && netif_queue_stopped(greth->netdev))) {
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   994  			GRETH_REGSAVE(greth->regs->control,
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   995  					ctrl | GRETH_TXI | GRETH_RXI);
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   996  			mask = GRETH_INT_RX | GRETH_INT_RE |
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   997  			       GRETH_INT_TX | GRETH_INT_TE;
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   998  		} else {
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14   999  			GRETH_REGSAVE(greth->regs->control, ctrl | GRETH_RXI);
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14  1000  			mask = GRETH_INT_RX | GRETH_INT_RE;
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14  1001  		}
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14  1002  
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14  1003  		if (GRETH_REGLOAD(greth->regs->status) & mask) {
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14  1004  			GRETH_REGSAVE(greth->regs->control, ctrl);
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14  1005  			spin_unlock_irqrestore(&greth->devlock, flags);
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14  1006  			goto restart_txrx_poll;
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14  1007  		} else {
32e19300a4f6705 drivers/net/ethernet/aeroflex/greth.c Eric Dumazet       2017-02-04  1008  			napi_complete_done(napi, work_done);
0f73f2c5a3ebb95 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14  1009  			spin_unlock_irqrestore(&greth->devlock, flags);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1010  		}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1011  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1012  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1013  	return work_done;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1014  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1015  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1016  static int greth_set_mac_add(struct net_device *dev, void *p)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1017  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1018  	struct sockaddr *addr = p;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1019  	struct greth_private *greth;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1020  	struct greth_regs *regs;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1021  
6e03718c852a7b2 drivers/net/greth.c                   kirjanov at gmail.com 2010-02-19  1022  	greth = netdev_priv(dev);
6469933605a3ecd drivers/net/ethernet/aeroflex/greth.c Joe Perches        2012-06-04  1023  	regs = greth->regs;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1024  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1025  	if (!is_valid_ether_addr(addr->sa_data))
504f9b5a6bb5336 drivers/net/ethernet/aeroflex/greth.c Danny Kukawka      2012-02-21  1026  		return -EADDRNOTAVAIL;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1027  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1028  	memcpy(dev->dev_addr, addr->sa_data, dev->addr_len);
9b9cfe7cf663c16 drivers/net/greth.c                   Kristoffer Glembo  2011-07-04  1029  	GRETH_REGSAVE(regs->esa_msb, dev->dev_addr[0] << 8 | dev->dev_addr[1]);
9b9cfe7cf663c16 drivers/net/greth.c                   Kristoffer Glembo  2011-07-04  1030  	GRETH_REGSAVE(regs->esa_lsb, dev->dev_addr[2] << 24 | dev->dev_addr[3] << 16 |
9b9cfe7cf663c16 drivers/net/greth.c                   Kristoffer Glembo  2011-07-04  1031  		      dev->dev_addr[4] << 8 | dev->dev_addr[5]);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1032  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1033  	return 0;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1034  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1035  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1036  static u32 greth_hash_get_index(__u8 *addr)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1037  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1038  	return (ether_crc(6, addr)) & 0x3F;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1039  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1040  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1041  static void greth_set_hash_filter(struct net_device *dev)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1042  {
22bedad3ce112d5 drivers/net/greth.c                   Jiri Pirko         2010-04-01  1043  	struct netdev_hw_addr *ha;
6e03718c852a7b2 drivers/net/greth.c                   kirjanov at gmail.com 2010-02-19  1044  	struct greth_private *greth = netdev_priv(dev);
6469933605a3ecd drivers/net/ethernet/aeroflex/greth.c Joe Perches        2012-06-04  1045  	struct greth_regs *regs = greth->regs;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1046  	u32 mc_filter[2];
6e03718c852a7b2 drivers/net/greth.c                   kirjanov at gmail.com 2010-02-19  1047  	unsigned int bitnr;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1048  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1049  	mc_filter[0] = mc_filter[1] = 0;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1050  
22bedad3ce112d5 drivers/net/greth.c                   Jiri Pirko         2010-04-01  1051  	netdev_for_each_mc_addr(ha, dev) {
22bedad3ce112d5 drivers/net/greth.c                   Jiri Pirko         2010-04-01  1052  		bitnr = greth_hash_get_index(ha->addr);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1053  		mc_filter[bitnr >> 5] |= 1 << (bitnr & 31);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1054  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1055  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1056  	GRETH_REGSAVE(regs->hash_msb, mc_filter[1]);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1057  	GRETH_REGSAVE(regs->hash_lsb, mc_filter[0]);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1058  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1059  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1060  static void greth_set_multicast_list(struct net_device *dev)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1061  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1062  	int cfg;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1063  	struct greth_private *greth = netdev_priv(dev);
6469933605a3ecd drivers/net/ethernet/aeroflex/greth.c Joe Perches        2012-06-04  1064  	struct greth_regs *regs = greth->regs;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1065  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1066  	cfg = GRETH_REGLOAD(regs->control);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1067  	if (dev->flags & IFF_PROMISC)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1068  		cfg |= GRETH_CTRL_PR;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1069  	else
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1070  		cfg &= ~GRETH_CTRL_PR;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1071  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1072  	if (greth->multicast) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1073  		if (dev->flags & IFF_ALLMULTI) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1074  			GRETH_REGSAVE(regs->hash_msb, -1);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1075  			GRETH_REGSAVE(regs->hash_lsb, -1);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1076  			cfg |= GRETH_CTRL_MCEN;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1077  			GRETH_REGSAVE(regs->control, cfg);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1078  			return;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1079  		}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1080  
6e03718c852a7b2 drivers/net/greth.c                   kirjanov at gmail.com 2010-02-19  1081  		if (netdev_mc_empty(dev)) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1082  			cfg &= ~GRETH_CTRL_MCEN;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1083  			GRETH_REGSAVE(regs->control, cfg);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1084  			return;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1085  		}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1086  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1087  		/* Setup multicast filter */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1088  		greth_set_hash_filter(dev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1089  		cfg |= GRETH_CTRL_MCEN;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1090  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1091  	GRETH_REGSAVE(regs->control, cfg);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1092  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1093  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1094  static u32 greth_get_msglevel(struct net_device *dev)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1095  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1096  	struct greth_private *greth = netdev_priv(dev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1097  	return greth->msg_enable;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1098  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1099  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1100  static void greth_set_msglevel(struct net_device *dev, u32 value)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1101  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1102  	struct greth_private *greth = netdev_priv(dev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1103  	greth->msg_enable = value;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1104  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1105  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1106  static int greth_get_regs_len(struct net_device *dev)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1107  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1108  	return sizeof(struct greth_regs);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1109  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1110  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1111  static void greth_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *info)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1112  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1113  	struct greth_private *greth = netdev_priv(dev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1114  
7826d43f2db45c9 drivers/net/ethernet/aeroflex/greth.c Jiri Pirko         2013-01-06  1115  	strlcpy(info->driver, dev_driver_string(greth->dev),
7826d43f2db45c9 drivers/net/ethernet/aeroflex/greth.c Jiri Pirko         2013-01-06  1116  		sizeof(info->driver));
7826d43f2db45c9 drivers/net/ethernet/aeroflex/greth.c Jiri Pirko         2013-01-06  1117  	strlcpy(info->version, "revision: 1.0", sizeof(info->version));
7826d43f2db45c9 drivers/net/ethernet/aeroflex/greth.c Jiri Pirko         2013-01-06  1118  	strlcpy(info->bus_info, greth->dev->bus->name, sizeof(info->bus_info));
7826d43f2db45c9 drivers/net/ethernet/aeroflex/greth.c Jiri Pirko         2013-01-06  1119  	strlcpy(info->fw_version, "N/A", sizeof(info->fw_version));
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1120  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1121  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1122  static void greth_get_regs(struct net_device *dev, struct ethtool_regs *regs, void *p)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1123  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1124  	int i;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1125  	struct greth_private *greth = netdev_priv(dev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1126  	u32 __iomem *greth_regs = (u32 __iomem *) greth->regs;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1127  	u32 *buff = p;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1128  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1129  	for (i = 0; i < sizeof(struct greth_regs) / sizeof(u32); i++)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1130  		buff[i] = greth_read_bd(&greth_regs[i]);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1131  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1132  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1133  static const struct ethtool_ops greth_ethtool_ops = {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1134  	.get_msglevel		= greth_get_msglevel,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1135  	.set_msglevel		= greth_set_msglevel,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1136  	.get_drvinfo		= greth_get_drvinfo,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1137  	.get_regs_len           = greth_get_regs_len,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1138  	.get_regs               = greth_get_regs,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1139  	.get_link		= ethtool_op_get_link,
72582fdb92457a1 drivers/net/ethernet/aeroflex/greth.c Philippe Reynes    2016-07-30  1140  	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
72582fdb92457a1 drivers/net/ethernet/aeroflex/greth.c Philippe Reynes    2016-07-30  1141  	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1142  };
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1143  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1144  static struct net_device_ops greth_netdev_ops = {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1145  	.ndo_open		= greth_open,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1146  	.ndo_stop		= greth_close,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1147  	.ndo_start_xmit		= greth_start_xmit,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1148  	.ndo_set_mac_address	= greth_set_mac_add,
6e03718c852a7b2 drivers/net/greth.c                   kirjanov@gmail.com 2010-02-19  1149  	.ndo_validate_addr	= eth_validate_addr,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1150  };
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1151  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1152  static inline int wait_for_mdio(struct greth_private *greth)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1153  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1154  	unsigned long timeout = jiffies + 4*HZ/100;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1155  	while (GRETH_REGLOAD(greth->regs->mdio) & GRETH_MII_BUSY) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1156  		if (time_after(jiffies, timeout))
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1157  			return 0;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1158  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1159  	return 1;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1160  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1161  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1162  static int greth_mdio_read(struct mii_bus *bus, int phy, int reg)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1163  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1164  	struct greth_private *greth = bus->priv;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1165  	int data;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1166  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1167  	if (!wait_for_mdio(greth))
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1168  		return -EBUSY;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1169  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1170  	GRETH_REGSAVE(greth->regs->mdio, ((phy & 0x1F) << 11) | ((reg & 0x1F) << 6) | 2);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1171  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1172  	if (!wait_for_mdio(greth))
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1173  		return -EBUSY;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1174  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1175  	if (!(GRETH_REGLOAD(greth->regs->mdio) & GRETH_MII_NVALID)) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1176  		data = (GRETH_REGLOAD(greth->regs->mdio) >> 16) & 0xFFFF;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1177  		return data;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1178  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1179  	} else {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1180  		return -1;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1181  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1182  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1183  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1184  static int greth_mdio_write(struct mii_bus *bus, int phy, int reg, u16 val)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1185  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1186  	struct greth_private *greth = bus->priv;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1187  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1188  	if (!wait_for_mdio(greth))
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1189  		return -EBUSY;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1190  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1191  	GRETH_REGSAVE(greth->regs->mdio,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1192  		      ((val & 0xFFFF) << 16) | ((phy & 0x1F) << 11) | ((reg & 0x1F) << 6) | 1);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1193  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1194  	if (!wait_for_mdio(greth))
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1195  		return -EBUSY;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1196  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1197  	return 0;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1198  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1199  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1200  static void greth_link_change(struct net_device *dev)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1201  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1202  	struct greth_private *greth = netdev_priv(dev);
65752dda4b52573 drivers/net/ethernet/aeroflex/greth.c Philippe Reynes    2016-07-30  1203  	struct phy_device *phydev = dev->phydev;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1204  	unsigned long flags;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1205  	int status_change = 0;
2436af8ca7a6c46 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14  1206  	u32 ctrl;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1207  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1208  	spin_lock_irqsave(&greth->devlock, flags);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1209  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1210  	if (phydev->link) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1211  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1212  		if ((greth->speed != phydev->speed) || (greth->duplex != phydev->duplex)) {
2436af8ca7a6c46 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14  1213  			ctrl = GRETH_REGLOAD(greth->regs->control) &
2436af8ca7a6c46 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14  1214  			       ~(GRETH_CTRL_FD | GRETH_CTRL_SP | GRETH_CTRL_GB);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1215  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1216  			if (phydev->duplex)
2436af8ca7a6c46 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14  1217  				ctrl |= GRETH_CTRL_FD;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1218  
2436af8ca7a6c46 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14  1219  			if (phydev->speed == SPEED_100)
2436af8ca7a6c46 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14  1220  				ctrl |= GRETH_CTRL_SP;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1221  			else if (phydev->speed == SPEED_1000)
2436af8ca7a6c46 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14  1222  				ctrl |= GRETH_CTRL_GB;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1223  
2436af8ca7a6c46 drivers/net/greth.c                   Daniel Hellstrom   2011-01-14  1224  			GRETH_REGSAVE(greth->regs->control, ctrl);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1225  			greth->speed = phydev->speed;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1226  			greth->duplex = phydev->duplex;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1227  			status_change = 1;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1228  		}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1229  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1230  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1231  	if (phydev->link != greth->link) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1232  		if (!phydev->link) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1233  			greth->speed = 0;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1234  			greth->duplex = -1;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1235  		}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1236  		greth->link = phydev->link;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1237  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1238  		status_change = 1;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1239  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1240  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1241  	spin_unlock_irqrestore(&greth->devlock, flags);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1242  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1243  	if (status_change) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1244  		if (phydev->link)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1245  			pr_debug("%s: link up (%d/%s)\n",
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1246  				dev->name, phydev->speed,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1247  				DUPLEX_FULL == phydev->duplex ? "Full" : "Half");
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1248  		else
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1249  			pr_debug("%s: link down\n", dev->name);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1250  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1251  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1252  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1253  static int greth_mdio_probe(struct net_device *dev)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1254  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1255  	struct greth_private *greth = netdev_priv(dev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1256  	struct phy_device *phy = NULL;
6e03718c852a7b2 drivers/net/greth.c                   kirjanov at gmail.com 2010-02-19  1257  	int ret;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1258  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1259  	/* Find the first PHY */
6e03718c852a7b2 drivers/net/greth.c                   kirjanov at gmail.com 2010-02-19  1260  	phy = phy_find_first(greth->mdio);
6e03718c852a7b2 drivers/net/greth.c                   kirjanov at gmail.com 2010-02-19  1261  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1262  	if (!phy) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1263  		if (netif_msg_probe(greth))
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1264  			dev_err(&dev->dev, "no PHY found\n");
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1265  		return -ENXIO;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1266  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1267  
6e03718c852a7b2 drivers/net/greth.c                   kirjanov at gmail.com 2010-02-19  1268  	ret = phy_connect_direct(dev, phy, &greth_link_change,
f9a8f83b04e0c36 drivers/net/ethernet/aeroflex/greth.c Florian Fainelli   2013-01-14  1269  				 greth->gbit_mac ? PHY_INTERFACE_MODE_GMII : PHY_INTERFACE_MODE_MII);
6e03718c852a7b2 drivers/net/greth.c                   kirjanov at gmail.com 2010-02-19  1270  	if (ret) {
6e03718c852a7b2 drivers/net/greth.c                   kirjanov at gmail.com 2010-02-19  1271  		if (netif_msg_ifup(greth))
6e03718c852a7b2 drivers/net/greth.c                   kirjanov at gmail.com 2010-02-19  1272  			dev_err(&dev->dev, "could not attach to PHY\n");
6e03718c852a7b2 drivers/net/greth.c                   kirjanov at gmail.com 2010-02-19  1273  		return ret;
6e03718c852a7b2 drivers/net/greth.c                   kirjanov at gmail.com 2010-02-19  1274  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1275  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1276  	if (greth->gbit_mac)
58056c1e1b0e495 drivers/net/ethernet/aeroflex/greth.c Andrew Lunn        2018-09-12  1277  		phy_set_max_speed(phy, SPEED_1000);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1278  	else
58056c1e1b0e495 drivers/net/ethernet/aeroflex/greth.c Andrew Lunn        2018-09-12  1279  		phy_set_max_speed(phy, SPEED_100);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1280  
3c1bcc8614db108 drivers/net/ethernet/aeroflex/greth.c Andrew Lunn        2018-11-10  1281  	linkmode_copy(phy->advertising, phy->supported);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1282  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1283  	greth->link = 0;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1284  	greth->speed = 0;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1285  	greth->duplex = -1;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1286  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1287  	return 0;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1288  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1289  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1290  static int greth_mdio_init(struct greth_private *greth)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1291  {
b1ac6b7b4061f6c drivers/net/ethernet/aeroflex/greth.c Sam Ravnborg       2016-04-24  1292  	int ret;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1293  	unsigned long timeout;
65752dda4b52573 drivers/net/ethernet/aeroflex/greth.c Philippe Reynes    2016-07-30  1294  	struct net_device *ndev = greth->netdev;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1295  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1296  	greth->mdio = mdiobus_alloc();
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1297  	if (!greth->mdio) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1298  		return -ENOMEM;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1299  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1300  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1301  	greth->mdio->name = "greth-mdio";
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1302  	snprintf(greth->mdio->id, MII_BUS_ID_SIZE, "%s-%d", greth->mdio->name, greth->irq);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1303  	greth->mdio->read = greth_mdio_read;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1304  	greth->mdio->write = greth_mdio_write;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1305  	greth->mdio->priv = greth;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1306  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1307  	ret = mdiobus_register(greth->mdio);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1308  	if (ret) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1309  		goto error;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1310  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1311  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1312  	ret = greth_mdio_probe(greth->netdev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1313  	if (ret) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1314  		if (netif_msg_probe(greth))
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1315  			dev_err(&greth->netdev->dev, "failed to probe MDIO bus\n");
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1316  		goto unreg_mdio;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1317  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1318  
65752dda4b52573 drivers/net/ethernet/aeroflex/greth.c Philippe Reynes    2016-07-30  1319  	phy_start(ndev->phydev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1320  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1321  	/* If Ethernet debug link is used make autoneg happen right away */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1322  	if (greth->edcl && greth_edcl == 1) {
65752dda4b52573 drivers/net/ethernet/aeroflex/greth.c Philippe Reynes    2016-07-30  1323  		phy_start_aneg(ndev->phydev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1324  		timeout = jiffies + 6*HZ;
65752dda4b52573 drivers/net/ethernet/aeroflex/greth.c Philippe Reynes    2016-07-30  1325  		while (!phy_aneg_done(ndev->phydev) &&
65752dda4b52573 drivers/net/ethernet/aeroflex/greth.c Philippe Reynes    2016-07-30  1326  		       time_before(jiffies, timeout)) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1327  		}
65752dda4b52573 drivers/net/ethernet/aeroflex/greth.c Philippe Reynes    2016-07-30  1328  		phy_read_status(ndev->phydev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1329  		greth_link_change(greth->netdev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1330  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1331  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1332  	return 0;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1333  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1334  unreg_mdio:
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1335  	mdiobus_unregister(greth->mdio);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1336  error:
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1337  	mdiobus_free(greth->mdio);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1338  	return ret;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1339  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1340  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1341  /* Initialize the GRETH MAC */
c0c0e29d8c94fb4 drivers/net/ethernet/aeroflex/greth.c Bill Pemberton     2012-12-03  1342  static int greth_of_probe(struct platform_device *ofdev)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1343  {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1344  	struct net_device *dev;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1345  	struct greth_private *greth;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1346  	struct greth_regs *regs;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1347  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1348  	int i;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1349  	int err;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1350  	int tmp;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1351  	unsigned long timeout;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1352  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1353  	dev = alloc_etherdev(sizeof(struct greth_private));
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1354  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1355  	if (dev == NULL)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1356  		return -ENOMEM;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1357  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1358  	greth = netdev_priv(dev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1359  	greth->netdev = dev;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1360  	greth->dev = &ofdev->dev;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1361  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1362  	if (greth_debug > 0)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1363  		greth->msg_enable = greth_debug;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1364  	else
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1365  		greth->msg_enable = GRETH_DEF_MSG_ENABLE;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1366  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1367  	spin_lock_init(&greth->devlock);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1368  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1369  	greth->regs = of_ioremap(&ofdev->resource[0], 0,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1370  				 resource_size(&ofdev->resource[0]),
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1371  				 "grlib-greth regs");
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1372  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1373  	if (greth->regs == NULL) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1374  		if (netif_msg_probe(greth))
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1375  			dev_err(greth->dev, "ioremap failure.\n");
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1376  		err = -EIO;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1377  		goto error1;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1378  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1379  
6469933605a3ecd drivers/net/ethernet/aeroflex/greth.c Joe Perches        2012-06-04  1380  	regs = greth->regs;
19e4875fb21a69f drivers/net/greth.c                   Grant Likely       2010-08-08  1381  	greth->irq = ofdev->archdata.irqs[0];
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1382  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1383  	dev_set_drvdata(greth->dev, dev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1384  	SET_NETDEV_DEV(dev, greth->dev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1385  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1386  	if (netif_msg_probe(greth))
72e60278d7e4a60 drivers/net/ethernet/aeroflex/greth.c Masanari Iida      2012-02-09  1387  		dev_dbg(greth->dev, "resetting controller.\n");
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1388  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1389  	/* Reset the controller. */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1390  	GRETH_REGSAVE(regs->control, GRETH_RESET);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1391  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1392  	/* Wait for MAC to reset itself */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1393  	timeout = jiffies + HZ/100;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1394  	while (GRETH_REGLOAD(regs->control) & GRETH_RESET) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1395  		if (time_after(jiffies, timeout)) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1396  			err = -EIO;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1397  			if (netif_msg_probe(greth))
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1398  				dev_err(greth->dev, "timeout when waiting for reset.\n");
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1399  			goto error2;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1400  		}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1401  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1402  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1403  	/* Get default PHY address  */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1404  	greth->phyaddr = (GRETH_REGLOAD(regs->mdio) >> 11) & 0x1F;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1405  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1406  	/* Check if we have GBIT capable MAC */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1407  	tmp = GRETH_REGLOAD(regs->control);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1408  	greth->gbit_mac = (tmp >> 27) & 1;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1409  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1410  	/* Check for multicast capability */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1411  	greth->multicast = (tmp >> 25) & 1;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1412  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1413  	greth->edcl = (tmp >> 31) & 1;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1414  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1415  	/* If we have EDCL we disable the EDCL speed-duplex FSM so
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1416  	 * it doesn't interfere with the software */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1417  	if (greth->edcl != 0)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1418  		GRETH_REGORIN(regs->control, GRETH_CTRL_DISDUPLEX);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1419  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1420  	/* Check if MAC can handle MDIO interrupts */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1421  	greth->mdio_int_en = (tmp >> 26) & 1;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1422  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1423  	err = greth_mdio_init(greth);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1424  	if (err) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1425  		if (netif_msg_probe(greth))
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1426  			dev_err(greth->dev, "failed to register MDIO bus\n");
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1427  		goto error2;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1428  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1429  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1430  	/* Allocate TX descriptor ring in coherent memory */
750afb08ca71310 drivers/net/ethernet/aeroflex/greth.c Luis Chamberlain   2019-01-04  1431  	greth->tx_bd_base = dma_alloc_coherent(greth->dev, 1024,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1432  					       &greth->tx_bd_base_phys,
ede23fa8161c1a0 drivers/net/ethernet/aeroflex/greth.c Joe Perches        2013-08-26  1433  					       GFP_KERNEL);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1434  	if (!greth->tx_bd_base) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1435  		err = -ENOMEM;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1436  		goto error3;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1437  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1438  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1439  	/* Allocate RX descriptor ring in coherent memory */
750afb08ca71310 drivers/net/ethernet/aeroflex/greth.c Luis Chamberlain   2019-01-04  1440  	greth->rx_bd_base = dma_alloc_coherent(greth->dev, 1024,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1441  					       &greth->rx_bd_base_phys,
ede23fa8161c1a0 drivers/net/ethernet/aeroflex/greth.c Joe Perches        2013-08-26  1442  					       GFP_KERNEL);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1443  	if (!greth->rx_bd_base) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1444  		err = -ENOMEM;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1445  		goto error4;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1446  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1447  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1448  	/* Get MAC address from: module param, OF property or ID prom */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1449  	for (i = 0; i < 6; i++) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1450  		if (macaddr[i] != 0)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1451  			break;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1452  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1453  	if (i == 6) {
726bceca81ba099 drivers/net/ethernet/aeroflex/greth.c Tobias Klauser     2017-03-21  1454  		const u8 *addr;
726bceca81ba099 drivers/net/ethernet/aeroflex/greth.c Tobias Klauser     2017-03-21  1455  
726bceca81ba099 drivers/net/ethernet/aeroflex/greth.c Tobias Klauser     2017-03-21  1456  		addr = of_get_mac_address(ofdev->dev.of_node);
a51645f70f6384a drivers/net/ethernet/aeroflex/greth.c Petr ??tetiar       2019-05-06  1457  		if (!IS_ERR(addr)) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1458  			for (i = 0; i < 6; i++)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1459  				macaddr[i] = (unsigned int) addr[i];
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1460  		} else {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1461  #ifdef CONFIG_SPARC
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1462  			for (i = 0; i < 6; i++)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1463  				macaddr[i] = (unsigned int) idprom->id_ethaddr[i];
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1464  #endif
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1465  		}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1466  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1467  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1468  	for (i = 0; i < 6; i++)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1469  		dev->dev_addr[i] = macaddr[i];
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1470  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1471  	macaddr[5]++;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1472  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1473  	if (!is_valid_ether_addr(&dev->dev_addr[0])) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1474  		if (netif_msg_probe(greth))
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1475  			dev_err(greth->dev, "no valid ethernet address, aborting.\n");
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1476  		err = -EINVAL;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1477  		goto error5;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1478  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1479  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1480  	GRETH_REGSAVE(regs->esa_msb, dev->dev_addr[0] << 8 | dev->dev_addr[1]);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1481  	GRETH_REGSAVE(regs->esa_lsb, dev->dev_addr[2] << 24 | dev->dev_addr[3] << 16 |
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1482  		      dev->dev_addr[4] << 8 | dev->dev_addr[5]);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1483  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1484  	/* Clear all pending interrupts except PHY irq */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1485  	GRETH_REGSAVE(regs->status, 0xFF);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1486  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1487  	if (greth->gbit_mac) {
131ae329702755d drivers/net/greth.c                   Micha?? Miros??aw    2011-04-17  1488  		dev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM |
131ae329702755d drivers/net/greth.c                   Micha?? Miros??aw    2011-04-17  1489  			NETIF_F_RXCSUM;
131ae329702755d drivers/net/greth.c                   Micha?? Miros??aw    2011-04-17  1490  		dev->features = dev->hw_features | NETIF_F_HIGHDMA;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1491  		greth_netdev_ops.ndo_start_xmit = greth_start_xmit_gbit;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1492  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1493  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1494  	if (greth->multicast) {
afc4b13df143122 drivers/net/ethernet/aeroflex/greth.c Jiri Pirko         2011-08-16  1495  		greth_netdev_ops.ndo_set_rx_mode = greth_set_multicast_list;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1496  		dev->flags |= IFF_MULTICAST;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1497  	} else {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1498  		dev->flags &= ~IFF_MULTICAST;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1499  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1500  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1501  	dev->netdev_ops = &greth_netdev_ops;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1502  	dev->ethtool_ops = &greth_ethtool_ops;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1503  
cb5d991a9910456 drivers/net/greth.c                   Tobias Klauser     2010-08-17  1504  	err = register_netdev(dev);
cb5d991a9910456 drivers/net/greth.c                   Tobias Klauser     2010-08-17  1505  	if (err) {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1506  		if (netif_msg_probe(greth))
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1507  			dev_err(greth->dev, "netdevice registration failed.\n");
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1508  		goto error5;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1509  	}
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1510  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1511  	/* setup NAPI */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1512  	netif_napi_add(dev, &greth->napi, greth_poll, 64);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1513  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1514  	return 0;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1515  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1516  error5:
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1517  	dma_free_coherent(greth->dev, 1024, greth->rx_bd_base, greth->rx_bd_base_phys);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1518  error4:
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1519  	dma_free_coherent(greth->dev, 1024, greth->tx_bd_base, greth->tx_bd_base_phys);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1520  error3:
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1521  	mdiobus_unregister(greth->mdio);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1522  error2:
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1523  	of_iounmap(&ofdev->resource[0], greth->regs, resource_size(&ofdev->resource[0]));
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1524  error1:
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1525  	free_netdev(dev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1526  	return err;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1527  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1528  
c0c0e29d8c94fb4 drivers/net/ethernet/aeroflex/greth.c Bill Pemberton     2012-12-03  1529  static int greth_of_remove(struct platform_device *of_dev)
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1530  {
8513fbd880093f0 drivers/net/ethernet/aeroflex/greth.c Jingoo Han         2013-05-23  1531  	struct net_device *ndev = platform_get_drvdata(of_dev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1532  	struct greth_private *greth = netdev_priv(ndev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1533  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1534  	/* Free descriptor areas */
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1535  	dma_free_coherent(&of_dev->dev, 1024, greth->rx_bd_base, greth->rx_bd_base_phys);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1536  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1537  	dma_free_coherent(&of_dev->dev, 1024, greth->tx_bd_base, greth->tx_bd_base_phys);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1538  
65752dda4b52573 drivers/net/ethernet/aeroflex/greth.c Philippe Reynes    2016-07-30  1539  	if (ndev->phydev)
65752dda4b52573 drivers/net/ethernet/aeroflex/greth.c Philippe Reynes    2016-07-30  1540  		phy_stop(ndev->phydev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1541  	mdiobus_unregister(greth->mdio);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1542  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1543  	unregister_netdev(ndev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1544  	free_netdev(ndev);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1545  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1546  	of_iounmap(&of_dev->resource[0], greth->regs, resource_size(&of_dev->resource[0]));
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1547  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1548  	return 0;
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1549  }
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1550  
73c7047464f26c0 drivers/net/ethernet/aeroflex/greth.c Fabian Frederick   2015-03-17  1551  static const struct of_device_id greth_of_match[] = {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1552  	{
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1553  	 .name = "GAISLER_ETHMAC",
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1554  	 },
ad4650a89ac47bd drivers/net/greth.c                   Daniel Hellstrom   2011-01-14  1555  	{
ad4650a89ac47bd drivers/net/greth.c                   Daniel Hellstrom   2011-01-14  1556  	 .name = "01_01d",
ad4650a89ac47bd drivers/net/greth.c                   Daniel Hellstrom   2011-01-14  1557  	 },
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1558  	{},
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1559  };
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1560  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1561  MODULE_DEVICE_TABLE(of, greth_of_match);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1562  
74888760d40b3ac drivers/net/greth.c                   Grant Likely       2011-02-22  1563  static struct platform_driver greth_of_driver = {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1564  	.driver = {
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1565  		.name = "grlib-greth",
bc284f94f84c3d7 drivers/net/greth.c                   David S. Miller    2010-05-31  1566  		.of_match_table = greth_of_match,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1567  	},
bc284f94f84c3d7 drivers/net/greth.c                   David S. Miller    2010-05-31  1568  	.probe = greth_of_probe,
c0c0e29d8c94fb4 drivers/net/ethernet/aeroflex/greth.c Bill Pemberton     2012-12-03  1569  	.remove = greth_of_remove,
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1570  };
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1571  
db62f684deeb291 drivers/net/ethernet/aeroflex/greth.c Axel Lin           2011-11-27  1572  module_platform_driver(greth_of_driver);
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1573  
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1574  MODULE_AUTHOR("Aeroflex Gaisler AB.");
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1575  MODULE_DESCRIPTION("Aeroflex Gaisler Ethernet MAC driver");
d4c41139df6e74c drivers/net/greth.c                   Kristoffer Glembo  2010-02-15  1576  MODULE_LICENSE("GPL");

:::::: The code at line 113 was first introduced by commit
:::::: ab7e11d9d0293ef1802d6ae8aab39ce58472b167 greth: convert to SKB paged frag API.

:::::: TO: Ian Campbell <Ian.Campbell@citrix.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 58659 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190724/99b238ae/attachment-0001.bin>
