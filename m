From: kbuild test robot <lkp@intel.com>
Date: Tue, 28 Jan 2020 15:39:16 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 25/27]
 drivers/net/ethernet/intel/igc/igc_dump.c:197:25: sparse: sparse: cast to
 restricted __le64
Message-ID: <202001281514.Wa7UWB6r%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   6a71a4851aa363f042d1446967d96c4cf1392f66
commit: 0ac10c5733a8a2cb846cd95048777338df0e23d3 [25/27] igc: Add dump options
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-153-g47b6dfef-dirty
        git checkout 0ac10c5733a8a2cb846cd95048777338df0e23d3
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/intel/igc/igc_dump.c:197:25: sparse: sparse: cast to restricted __le64
>> drivers/net/ethernet/intel/igc/igc_dump.c:197:25: sparse: sparse: cast to restricted __le64
   drivers/net/ethernet/intel/igc/igc_dump.c:278:33: sparse: sparse: cast to restricted __le64
   drivers/net/ethernet/intel/igc/igc_dump.c:278:33: sparse: sparse: cast to restricted __le64
   drivers/net/ethernet/intel/igc/igc_dump.c:284:33: sparse: sparse: cast to restricted __le64
   drivers/net/ethernet/intel/igc/igc_dump.c:284:33: sparse: sparse: cast to restricted __le64

vim +197 drivers/net/ethernet/intel/igc/igc_dump.c

   112	
   113	/* igc_rings_dump - Tx-rings and Rx-rings */
   114	void igc_rings_dump(struct igc_adapter *adapter)
   115	{
   116		struct net_device *netdev = adapter->netdev;
   117		struct my_u0 { u64 a; u64 b; } *u0;
   118		union igc_adv_tx_desc *tx_desc;
   119		union igc_adv_rx_desc *rx_desc;
   120		struct igc_ring *tx_ring;
   121		struct igc_ring *rx_ring;
   122		u32 staterr;
   123		u16 i, n;
   124	
   125		if (!netif_msg_hw(adapter))
   126			return;
   127	
   128		/* Print netdevice Info */
   129		if (netdev) {
   130			dev_info(&adapter->pdev->dev, "Net device Info\n");
   131			pr_info("Device Name     state            trans_start\n");
   132			pr_info("%-15s %016lX %016lX\n", netdev->name,
   133				netdev->state, dev_trans_start(netdev));
   134		}
   135	
   136		/* Print TX Ring Summary */
   137		if (!netdev || !netif_running(netdev))
   138			goto exit;
   139	
   140		dev_info(&adapter->pdev->dev, "TX Rings Summary\n");
   141		pr_info("Queue [NTU] [NTC] [bi(ntc)->dma  ] leng ntw timestamp\n");
   142		for (n = 0; n < adapter->num_tx_queues; n++) {
   143			struct igc_tx_buffer *buffer_info;
   144	
   145			tx_ring = adapter->tx_ring[n];
   146			buffer_info = &tx_ring->tx_buffer_info[tx_ring->next_to_clean];
   147	
   148			pr_info(" %5d %5X %5X %016llX %04X %p %016llX\n",
   149				n, tx_ring->next_to_use, tx_ring->next_to_clean,
   150				(u64)dma_unmap_addr(buffer_info, dma),
   151				dma_unmap_len(buffer_info, len),
   152				buffer_info->next_to_watch,
   153				(u64)buffer_info->time_stamp);
   154		}
   155	
   156		/* Print TX Rings */
   157		if (!netif_msg_tx_done(adapter))
   158			goto rx_ring_summary;
   159	
   160		dev_info(&adapter->pdev->dev, "TX Rings Dump\n");
   161	
   162		/* Transmit Descriptor Formats
   163		 *
   164		 * Advanced Transmit Descriptor
   165		 *   +--------------------------------------------------------------+
   166		 * 0 |         Buffer Address [63:0]                                |
   167		 *   +--------------------------------------------------------------+
   168		 * 8 | PAYLEN  | PORTS  |CC|IDX | STA | DCMD  |DTYP|MAC|RSV| DTALEN |
   169		 *   +--------------------------------------------------------------+
   170		 *   63      46 45    40 39 38 36 35 32 31   24             15       0
   171		 */
   172	
   173		for (n = 0; n < adapter->num_tx_queues; n++) {
   174			tx_ring = adapter->tx_ring[n];
   175			pr_info("------------------------------------\n");
   176			pr_info("TX QUEUE INDEX = %d\n", tx_ring->queue_index);
   177			pr_info("------------------------------------\n");
   178			pr_info("T [desc]     [address 63:0  ] [PlPOCIStDDM Ln] [bi->dma       ] leng  ntw timestamp        bi->skb\n");
   179	
   180			for (i = 0; tx_ring->desc && (i < tx_ring->count); i++) {
   181				const char *next_desc;
   182				struct igc_tx_buffer *buffer_info;
   183	
   184				tx_desc = IGC_TX_DESC(tx_ring, i);
   185				buffer_info = &tx_ring->tx_buffer_info[i];
   186				u0 = (struct my_u0 *)tx_desc;
   187				if (i == tx_ring->next_to_use &&
   188				    i == tx_ring->next_to_clean)
   189					next_desc = " NTC/U";
   190				else if (i == tx_ring->next_to_use)
   191					next_desc = " NTU";
   192				else if (i == tx_ring->next_to_clean)
   193					next_desc = " NTC";
   194				else
   195					next_desc = "";
   196	
 > 197				pr_info("T [0x%03X]    %016llX %016llX %016llX %04X  %p %016llX %p%s\n",
   198					i, le64_to_cpu(u0->a),
   199					le64_to_cpu(u0->b),
   200					(u64)dma_unmap_addr(buffer_info, dma),
   201					dma_unmap_len(buffer_info, len),
   202					buffer_info->next_to_watch,
   203					(u64)buffer_info->time_stamp,
   204					buffer_info->skb, next_desc);
   205	
   206				if (netif_msg_pktdata(adapter) && buffer_info->skb)
   207					print_hex_dump(KERN_INFO, "",
   208						       DUMP_PREFIX_ADDRESS,
   209						       16, 1, buffer_info->skb->data,
   210						       dma_unmap_len(buffer_info, len),
   211						       true);
   212			}
   213		}
   214	
   215		/* Print RX Rings Summary */
   216	rx_ring_summary:
   217		dev_info(&adapter->pdev->dev, "RX Rings Summary\n");
   218		pr_info("Queue [NTU] [NTC]\n");
   219		for (n = 0; n < adapter->num_rx_queues; n++) {
   220			rx_ring = adapter->rx_ring[n];
   221			pr_info(" %5d %5X %5X\n",
   222				n, rx_ring->next_to_use, rx_ring->next_to_clean);
   223		}
   224	
   225		/* Print RX Rings */
   226		if (!netif_msg_rx_status(adapter))
   227			goto exit;
   228	
   229		dev_info(&adapter->pdev->dev, "RX Rings Dump\n");
   230	
   231		/* Advanced Receive Descriptor (Read) Format
   232		 *    63                                           1        0
   233		 *    +-----------------------------------------------------+
   234		 *  0 |       Packet Buffer Address [63:1]           |A0/NSE|
   235		 *    +----------------------------------------------+------+
   236		 *  8 |       Header Buffer Address [63:1]           |  DD  |
   237		 *    +-----------------------------------------------------+
   238		 *
   239		 *
   240		 * Advanced Receive Descriptor (Write-Back) Format
   241		 *
   242		 *   63       48 47    32 31  30      21 20 17 16   4 3     0
   243		 *   +------------------------------------------------------+
   244		 * 0 | Packet     IP     |SPH| HDR_LEN   | RSV|Packet|  RSS |
   245		 *   | Checksum   Ident  |   |           |    | Type | Type |
   246		 *   +------------------------------------------------------+
   247		 * 8 | VLAN Tag | Length | Extended Error | Extended Status |
   248		 *   +------------------------------------------------------+
   249		 *   63       48 47    32 31            20 19               0
   250		 */
   251	
   252		for (n = 0; n < adapter->num_rx_queues; n++) {
   253			rx_ring = adapter->rx_ring[n];
   254			pr_info("------------------------------------\n");
   255			pr_info("RX QUEUE INDEX = %d\n", rx_ring->queue_index);
   256			pr_info("------------------------------------\n");
   257			pr_info("R  [desc]      [ PktBuf     A0] [  HeadBuf   DD] [bi->dma       ] [bi->skb] <-- Adv Rx Read format\n");
   258			pr_info("RWB[desc]      [PcsmIpSHl PtRs] [vl er S cks ln] ---------------- [bi->skb] <-- Adv Rx Write-Back format\n");
   259	
   260			for (i = 0; i < rx_ring->count; i++) {
   261				const char *next_desc;
   262				struct igc_rx_buffer *buffer_info;
   263	
   264				buffer_info = &rx_ring->rx_buffer_info[i];
   265				rx_desc = IGC_RX_DESC(rx_ring, i);
   266				u0 = (struct my_u0 *)rx_desc;
   267				staterr = le32_to_cpu(rx_desc->wb.upper.status_error);
   268	
   269				if (i == rx_ring->next_to_use)
   270					next_desc = " NTU";
   271				else if (i == rx_ring->next_to_clean)
   272					next_desc = " NTC";
   273				else
   274					next_desc = "";
   275	
   276				if (staterr & IGC_RXD_STAT_DD) {
   277					/* Descriptor Done */
   278					pr_info("%s[0x%03X]     %016llX %016llX ---------------- %s\n",
   279						"RWB", i,
   280						le64_to_cpu(u0->a),
   281						le64_to_cpu(u0->b),
   282						next_desc);
   283				} else {
   284					pr_info("%s[0x%03X]     %016llX %016llX %016llX %s\n",
   285						"R  ", i,
   286						le64_to_cpu(u0->a),
   287						le64_to_cpu(u0->b),
   288						(u64)buffer_info->dma,
   289						next_desc);
   290	
   291					if (netif_msg_pktdata(adapter) &&
   292					    buffer_info->dma && buffer_info->page) {
   293						print_hex_dump(KERN_INFO, "",
   294							       DUMP_PREFIX_ADDRESS,
   295							       16, 1,
   296							       page_address
   297							       (buffer_info->page) +
   298							       buffer_info->page_offset,
   299							       igc_rx_bufsz(rx_ring),
   300							       true);
   301					}
   302				}
   303			}
   304		}
   305	
   306	exit:
   307		return;
   308	}
   309	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org Intel Corporation
