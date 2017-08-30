From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 31 Aug 2017 07:37:01 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 68/68]
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c:281:5: warning: format '%li'
 expects argument of type 'long int',
 but argument 4 has type 'long unsigned int *'
Message-ID: <201708310748.v9LHAtJh%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   b908ea672f07f89d265f7785fd4f8368fa114a13
commit: b908ea672f07f89d265f7785fd4f8368fa114a13 [68/68] i40e/i40evf: use DECLARE_BITMAP for state
config: ia64-allyesconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout b908ea672f07f89d265f7785fd4f8368fa114a13
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All warnings (new ones prefixed by >>):

   In file included from include/linux/dma-mapping.h:6:0,
                    from include/linux/skbuff.h:34,
                    from include/linux/tcp.h:21,
                    from include/net/tcp.h:24,
                    from drivers/net/ethernet/intel/i40e/i40e.h:30,
                    from drivers/net/ethernet/intel/i40e/i40e_debugfs.c:32:
   drivers/net/ethernet/intel/i40e/i40e_debugfs.c: In function 'i40e_dbg_dump_vsi_seid':
>> drivers/net/ethernet/intel/i40e/i40e_debugfs.c:281:5: warning: format '%li' expects argument of type 'long int', but argument 4 has type 'long unsigned int *' [-Wformat=]
        "    rx_rings[%i]: state = %li, queue_index = %d, reg_idx = %d\n",
        ^
   include/linux/device.h:1317:51: note: in definition of macro 'dev_info'
    #define dev_info(dev, fmt, arg...) _dev_info(dev, fmt, ##arg)
                                                      ^~~
   drivers/net/ethernet/intel/i40e/i40e_debugfs.c:337:5: warning: format '%li' expects argument of type 'long int', but argument 4 has type 'long unsigned int *' [-Wformat=]
        "    tx_rings[%i]: state = %li, queue_index = %d, reg_idx = %d\n",
        ^
   include/linux/device.h:1317:51: note: in definition of macro 'dev_info'
    #define dev_info(dev, fmt, arg...) _dev_info(dev, fmt, ##arg)
                                                      ^~~

vim +281 drivers/net/ethernet/intel/i40e/i40e_debugfs.c

c3c7ea27b Mitch Williams   2016-06-20  126  
02e9c2908 Jesse Brandeburg 2013-09-11  127  /**
e625f71ba Shannon Nelson   2013-11-26  128   * i40e_dbg_dump_vsi_seid - handles dump vsi seid write into command datum
02e9c2908 Jesse Brandeburg 2013-09-11  129   * @pf: the i40e_pf created in command write
02e9c2908 Jesse Brandeburg 2013-09-11  130   * @seid: the seid the user put in
02e9c2908 Jesse Brandeburg 2013-09-11  131   **/
02e9c2908 Jesse Brandeburg 2013-09-11  132  static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
02e9c2908 Jesse Brandeburg 2013-09-11  133  {
02e9c2908 Jesse Brandeburg 2013-09-11  134  	struct rtnl_link_stats64 *nstat;
02e9c2908 Jesse Brandeburg 2013-09-11  135  	struct i40e_mac_filter *f;
02e9c2908 Jesse Brandeburg 2013-09-11  136  	struct i40e_vsi *vsi;
278e7d0b9 Jacob Keller     2016-10-05  137  	int i, bkt;
02e9c2908 Jesse Brandeburg 2013-09-11  138  
02e9c2908 Jesse Brandeburg 2013-09-11  139  	vsi = i40e_dbg_find_vsi(pf, seid);
02e9c2908 Jesse Brandeburg 2013-09-11  140  	if (!vsi) {
02e9c2908 Jesse Brandeburg 2013-09-11  141  		dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  142  			 "dump %d: seid not found\n", seid);
02e9c2908 Jesse Brandeburg 2013-09-11  143  		return;
02e9c2908 Jesse Brandeburg 2013-09-11  144  	}
02e9c2908 Jesse Brandeburg 2013-09-11  145  	dev_info(&pf->pdev->dev, "vsi seid %d\n", seid);
de1017f76 Shannon Nelson   2015-12-23  146  	if (vsi->netdev) {
de1017f76 Shannon Nelson   2015-12-23  147  		struct net_device *nd = vsi->netdev;
de1017f76 Shannon Nelson   2015-12-23  148  
de1017f76 Shannon Nelson   2015-12-23  149  		dev_info(&pf->pdev->dev, "    netdev: name = %s, state = %lu, flags = 0x%08x\n",
de1017f76 Shannon Nelson   2015-12-23  150  			 nd->name, nd->state, nd->flags);
de1017f76 Shannon Nelson   2015-12-23  151  		dev_info(&pf->pdev->dev, "        features      = 0x%08lx\n",
de1017f76 Shannon Nelson   2015-12-23  152  			 (unsigned long int)nd->features);
de1017f76 Shannon Nelson   2015-12-23  153  		dev_info(&pf->pdev->dev, "        hw_features   = 0x%08lx\n",
de1017f76 Shannon Nelson   2015-12-23  154  			 (unsigned long int)nd->hw_features);
de1017f76 Shannon Nelson   2015-12-23  155  		dev_info(&pf->pdev->dev, "        vlan_features = 0x%08lx\n",
de1017f76 Shannon Nelson   2015-12-23  156  			 (unsigned long int)nd->vlan_features);
de1017f76 Shannon Nelson   2015-12-23  157  	}
02e9c2908 Jesse Brandeburg 2013-09-11  158  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  159  		 "    vlgrp: & = %p\n", vsi->active_vlans);
02e9c2908 Jesse Brandeburg 2013-09-11  160  	dev_info(&pf->pdev->dev,
0da36b977 Jacob Keller     2017-04-19  161  		 "    flags = 0x%08lx, netdev_registered = %i, current_netdev_flags = 0x%04x\n",
0da36b977 Jacob Keller     2017-04-19  162  		 vsi->flags, vsi->netdev_registered, vsi->current_netdev_flags);
0da36b977 Jacob Keller     2017-04-19  163  	for (i = 0; i < BITS_TO_LONGS(__I40E_VSI_STATE_SIZE__); i++)
0da36b977 Jacob Keller     2017-04-19  164  		dev_info(&pf->pdev->dev,
0da36b977 Jacob Keller     2017-04-19  165  			 "    state[%d] = %08lx\n",
0da36b977 Jacob Keller     2017-04-19  166  			 i, vsi->state[i]);
2ddb80c9c Shannon Nelson   2015-02-27  167  	if (vsi == pf->vsi[pf->lan_vsi])
2ddb80c9c Shannon Nelson   2015-02-27  168  		dev_info(&pf->pdev->dev, "    MAC address: %pM SAN MAC: %pM Port MAC: %pM\n",
2ddb80c9c Shannon Nelson   2015-02-27  169  			 pf->hw.mac.addr,
2ddb80c9c Shannon Nelson   2015-02-27  170  			 pf->hw.mac.san_addr,
2ddb80c9c Shannon Nelson   2015-02-27  171  			 pf->hw.mac.port_addr);
278e7d0b9 Jacob Keller     2016-10-05  172  	hash_for_each(vsi->mac_filter_hash, bkt, f, hlist) {
02e9c2908 Jesse Brandeburg 2013-09-11  173  		dev_info(&pf->pdev->dev,
1bc87e807 Jacob Keller     2016-10-05  174  			 "    mac_filter_hash: %pM vid=%d, state %s\n",
1bc87e807 Jacob Keller     2016-10-05  175  			 f->macaddr, f->vlan,
1bc87e807 Jacob Keller     2016-10-05  176  			 i40e_filter_state_string[f->state]);
02e9c2908 Jesse Brandeburg 2013-09-11  177  	}
5951cf949 Jacob Keller     2016-11-21  178  	dev_info(&pf->pdev->dev, "    active_filters %u, promisc_threshold %u, overflow promisc %s\n",
c3c7ea27b Mitch Williams   2016-06-20  179  		 vsi->active_filters, vsi->promisc_threshold,
0da36b977 Jacob Keller     2017-04-19  180  		 (test_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state) ?
c3c7ea27b Mitch Williams   2016-06-20  181  		  "ON" : "OFF"));
02e9c2908 Jesse Brandeburg 2013-09-11  182  	nstat = i40e_get_vsi_stats_struct(vsi);
02e9c2908 Jesse Brandeburg 2013-09-11  183  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  184  		 "    net_stats: rx_packets = %lu, rx_bytes = %lu, rx_errors = %lu, rx_dropped = %lu\n",
6995b36c0 Jesse Brandeburg 2015-08-28  185  		 (unsigned long int)nstat->rx_packets,
6995b36c0 Jesse Brandeburg 2015-08-28  186  		 (unsigned long int)nstat->rx_bytes,
6995b36c0 Jesse Brandeburg 2015-08-28  187  		 (unsigned long int)nstat->rx_errors,
6995b36c0 Jesse Brandeburg 2015-08-28  188  		 (unsigned long int)nstat->rx_dropped);
02e9c2908 Jesse Brandeburg 2013-09-11  189  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  190  		 "    net_stats: tx_packets = %lu, tx_bytes = %lu, tx_errors = %lu, tx_dropped = %lu\n",
6995b36c0 Jesse Brandeburg 2015-08-28  191  		 (unsigned long int)nstat->tx_packets,
6995b36c0 Jesse Brandeburg 2015-08-28  192  		 (unsigned long int)nstat->tx_bytes,
6995b36c0 Jesse Brandeburg 2015-08-28  193  		 (unsigned long int)nstat->tx_errors,
6995b36c0 Jesse Brandeburg 2015-08-28  194  		 (unsigned long int)nstat->tx_dropped);
02e9c2908 Jesse Brandeburg 2013-09-11  195  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  196  		 "    net_stats: multicast = %lu, collisions = %lu\n",
6995b36c0 Jesse Brandeburg 2015-08-28  197  		 (unsigned long int)nstat->multicast,
6995b36c0 Jesse Brandeburg 2015-08-28  198  		 (unsigned long int)nstat->collisions);
02e9c2908 Jesse Brandeburg 2013-09-11  199  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  200  		 "    net_stats: rx_length_errors = %lu, rx_over_errors = %lu, rx_crc_errors = %lu\n",
6995b36c0 Jesse Brandeburg 2015-08-28  201  		 (unsigned long int)nstat->rx_length_errors,
6995b36c0 Jesse Brandeburg 2015-08-28  202  		 (unsigned long int)nstat->rx_over_errors,
6995b36c0 Jesse Brandeburg 2015-08-28  203  		 (unsigned long int)nstat->rx_crc_errors);
02e9c2908 Jesse Brandeburg 2013-09-11  204  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  205  		 "    net_stats: rx_frame_errors = %lu, rx_fifo_errors = %lu, rx_missed_errors = %lu\n",
6995b36c0 Jesse Brandeburg 2015-08-28  206  		 (unsigned long int)nstat->rx_frame_errors,
6995b36c0 Jesse Brandeburg 2015-08-28  207  		 (unsigned long int)nstat->rx_fifo_errors,
6995b36c0 Jesse Brandeburg 2015-08-28  208  		 (unsigned long int)nstat->rx_missed_errors);
02e9c2908 Jesse Brandeburg 2013-09-11  209  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  210  		 "    net_stats: tx_aborted_errors = %lu, tx_carrier_errors = %lu, tx_fifo_errors = %lu\n",
6995b36c0 Jesse Brandeburg 2015-08-28  211  		 (unsigned long int)nstat->tx_aborted_errors,
6995b36c0 Jesse Brandeburg 2015-08-28  212  		 (unsigned long int)nstat->tx_carrier_errors,
6995b36c0 Jesse Brandeburg 2015-08-28  213  		 (unsigned long int)nstat->tx_fifo_errors);
02e9c2908 Jesse Brandeburg 2013-09-11  214  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  215  		 "    net_stats: tx_heartbeat_errors = %lu, tx_window_errors = %lu\n",
6995b36c0 Jesse Brandeburg 2015-08-28  216  		 (unsigned long int)nstat->tx_heartbeat_errors,
6995b36c0 Jesse Brandeburg 2015-08-28  217  		 (unsigned long int)nstat->tx_window_errors);
02e9c2908 Jesse Brandeburg 2013-09-11  218  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  219  		 "    net_stats: rx_compressed = %lu, tx_compressed = %lu\n",
6995b36c0 Jesse Brandeburg 2015-08-28  220  		 (unsigned long int)nstat->rx_compressed,
6995b36c0 Jesse Brandeburg 2015-08-28  221  		 (unsigned long int)nstat->tx_compressed);
02e9c2908 Jesse Brandeburg 2013-09-11  222  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  223  		 "    net_stats_offsets: rx_packets = %lu, rx_bytes = %lu, rx_errors = %lu, rx_dropped = %lu\n",
6995b36c0 Jesse Brandeburg 2015-08-28  224  		 (unsigned long int)vsi->net_stats_offsets.rx_packets,
6995b36c0 Jesse Brandeburg 2015-08-28  225  		 (unsigned long int)vsi->net_stats_offsets.rx_bytes,
6995b36c0 Jesse Brandeburg 2015-08-28  226  		 (unsigned long int)vsi->net_stats_offsets.rx_errors,
6995b36c0 Jesse Brandeburg 2015-08-28  227  		 (unsigned long int)vsi->net_stats_offsets.rx_dropped);
02e9c2908 Jesse Brandeburg 2013-09-11  228  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  229  		 "    net_stats_offsets: tx_packets = %lu, tx_bytes = %lu, tx_errors = %lu, tx_dropped = %lu\n",
6995b36c0 Jesse Brandeburg 2015-08-28  230  		 (unsigned long int)vsi->net_stats_offsets.tx_packets,
6995b36c0 Jesse Brandeburg 2015-08-28  231  		 (unsigned long int)vsi->net_stats_offsets.tx_bytes,
6995b36c0 Jesse Brandeburg 2015-08-28  232  		 (unsigned long int)vsi->net_stats_offsets.tx_errors,
6995b36c0 Jesse Brandeburg 2015-08-28  233  		 (unsigned long int)vsi->net_stats_offsets.tx_dropped);
02e9c2908 Jesse Brandeburg 2013-09-11  234  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  235  		 "    net_stats_offsets: multicast = %lu, collisions = %lu\n",
6995b36c0 Jesse Brandeburg 2015-08-28  236  		 (unsigned long int)vsi->net_stats_offsets.multicast,
6995b36c0 Jesse Brandeburg 2015-08-28  237  		 (unsigned long int)vsi->net_stats_offsets.collisions);
02e9c2908 Jesse Brandeburg 2013-09-11  238  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  239  		 "    net_stats_offsets: rx_length_errors = %lu, rx_over_errors = %lu, rx_crc_errors = %lu\n",
6995b36c0 Jesse Brandeburg 2015-08-28  240  		 (unsigned long int)vsi->net_stats_offsets.rx_length_errors,
6995b36c0 Jesse Brandeburg 2015-08-28  241  		 (unsigned long int)vsi->net_stats_offsets.rx_over_errors,
6995b36c0 Jesse Brandeburg 2015-08-28  242  		 (unsigned long int)vsi->net_stats_offsets.rx_crc_errors);
02e9c2908 Jesse Brandeburg 2013-09-11  243  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  244  		 "    net_stats_offsets: rx_frame_errors = %lu, rx_fifo_errors = %lu, rx_missed_errors = %lu\n",
6995b36c0 Jesse Brandeburg 2015-08-28  245  		 (unsigned long int)vsi->net_stats_offsets.rx_frame_errors,
6995b36c0 Jesse Brandeburg 2015-08-28  246  		 (unsigned long int)vsi->net_stats_offsets.rx_fifo_errors,
6995b36c0 Jesse Brandeburg 2015-08-28  247  		 (unsigned long int)vsi->net_stats_offsets.rx_missed_errors);
02e9c2908 Jesse Brandeburg 2013-09-11  248  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  249  		 "    net_stats_offsets: tx_aborted_errors = %lu, tx_carrier_errors = %lu, tx_fifo_errors = %lu\n",
6995b36c0 Jesse Brandeburg 2015-08-28  250  		 (unsigned long int)vsi->net_stats_offsets.tx_aborted_errors,
6995b36c0 Jesse Brandeburg 2015-08-28  251  		 (unsigned long int)vsi->net_stats_offsets.tx_carrier_errors,
6995b36c0 Jesse Brandeburg 2015-08-28  252  		 (unsigned long int)vsi->net_stats_offsets.tx_fifo_errors);
02e9c2908 Jesse Brandeburg 2013-09-11  253  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  254  		 "    net_stats_offsets: tx_heartbeat_errors = %lu, tx_window_errors = %lu\n",
6995b36c0 Jesse Brandeburg 2015-08-28  255  		 (unsigned long int)vsi->net_stats_offsets.tx_heartbeat_errors,
6995b36c0 Jesse Brandeburg 2015-08-28  256  		 (unsigned long int)vsi->net_stats_offsets.tx_window_errors);
02e9c2908 Jesse Brandeburg 2013-09-11  257  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  258  		 "    net_stats_offsets: rx_compressed = %lu, tx_compressed = %lu\n",
6995b36c0 Jesse Brandeburg 2015-08-28  259  		 (unsigned long int)vsi->net_stats_offsets.rx_compressed,
6995b36c0 Jesse Brandeburg 2015-08-28  260  		 (unsigned long int)vsi->net_stats_offsets.tx_compressed);
02e9c2908 Jesse Brandeburg 2013-09-11  261  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  262  		 "    tx_restart = %d, tx_busy = %d, rx_buf_failed = %d, rx_page_failed = %d\n",
02e9c2908 Jesse Brandeburg 2013-09-11  263  		 vsi->tx_restart, vsi->tx_busy,
02e9c2908 Jesse Brandeburg 2013-09-11  264  		 vsi->rx_buf_failed, vsi->rx_page_failed);
9f65e15b4 Alexander Duyck  2013-09-28  265  	rcu_read_lock();
02e9c2908 Jesse Brandeburg 2013-09-11  266  	for (i = 0; i < vsi->num_queue_pairs; i++) {
9f65e15b4 Alexander Duyck  2013-09-28  267  		struct i40e_ring *rx_ring = ACCESS_ONCE(vsi->rx_rings[i]);
6995b36c0 Jesse Brandeburg 2015-08-28  268  
9f65e15b4 Alexander Duyck  2013-09-28  269  		if (!rx_ring)
9f65e15b4 Alexander Duyck  2013-09-28  270  			continue;
9f65e15b4 Alexander Duyck  2013-09-28  271  
02e9c2908 Jesse Brandeburg 2013-09-11  272  		dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  273  			 "    rx_rings[%i]: desc = %p\n",
9f65e15b4 Alexander Duyck  2013-09-28  274  			 i, rx_ring->desc);
02e9c2908 Jesse Brandeburg 2013-09-11  275  		dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  276  			 "    rx_rings[%i]: dev = %p, netdev = %p, rx_bi = %p\n",
9f65e15b4 Alexander Duyck  2013-09-28  277  			 i, rx_ring->dev,
9f65e15b4 Alexander Duyck  2013-09-28  278  			 rx_ring->netdev,
9f65e15b4 Alexander Duyck  2013-09-28  279  			 rx_ring->rx_bi);
02e9c2908 Jesse Brandeburg 2013-09-11  280  		dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11 @281  			 "    rx_rings[%i]: state = %li, queue_index = %d, reg_idx = %d\n",
9f65e15b4 Alexander Duyck  2013-09-28  282  			 i, rx_ring->state,
9f65e15b4 Alexander Duyck  2013-09-28  283  			 rx_ring->queue_index,
9f65e15b4 Alexander Duyck  2013-09-28  284  			 rx_ring->reg_idx);
02e9c2908 Jesse Brandeburg 2013-09-11  285  		dev_info(&pf->pdev->dev,
1a557afc4 Jesse Brandeburg 2016-04-20  286  			 "    rx_rings[%i]: rx_buf_len = %d\n",
1a557afc4 Jesse Brandeburg 2016-04-20  287  			 i, rx_ring->rx_buf_len);
02e9c2908 Jesse Brandeburg 2013-09-11  288  		dev_info(&pf->pdev->dev,
b32bfa172 Jesse Brandeburg 2016-04-18  289  			 "    rx_rings[%i]: next_to_use = %d, next_to_clean = %d, ring_active = %i\n",
b32bfa172 Jesse Brandeburg 2016-04-18  290  			 i,
9f65e15b4 Alexander Duyck  2013-09-28  291  			 rx_ring->next_to_use,
9f65e15b4 Alexander Duyck  2013-09-28  292  			 rx_ring->next_to_clean,
9f65e15b4 Alexander Duyck  2013-09-28  293  			 rx_ring->ring_active);
02e9c2908 Jesse Brandeburg 2013-09-11  294  		dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  295  			 "    rx_rings[%i]: rx_stats: packets = %lld, bytes = %lld, non_eop_descs = %lld\n",
9f65e15b4 Alexander Duyck  2013-09-28  296  			 i, rx_ring->stats.packets,
9f65e15b4 Alexander Duyck  2013-09-28  297  			 rx_ring->stats.bytes,
9f65e15b4 Alexander Duyck  2013-09-28  298  			 rx_ring->rx_stats.non_eop_descs);
02e9c2908 Jesse Brandeburg 2013-09-11  299  		dev_info(&pf->pdev->dev,
420136ccc Mitch Williams   2013-12-18  300  			 "    rx_rings[%i]: rx_stats: alloc_page_failed = %lld, alloc_buff_failed = %lld\n",
02e9c2908 Jesse Brandeburg 2013-09-11  301  			 i,
420136ccc Mitch Williams   2013-12-18  302  			 rx_ring->rx_stats.alloc_page_failed,
420136ccc Mitch Williams   2013-12-18  303  			 rx_ring->rx_stats.alloc_buff_failed);
02e9c2908 Jesse Brandeburg 2013-09-11  304  		dev_info(&pf->pdev->dev,
f16704e5e Mitch Williams   2016-01-13  305  			 "    rx_rings[%i]: rx_stats: realloc_count = %lld, page_reuse_count = %lld\n",
f16704e5e Mitch Williams   2016-01-13  306  			 i,
f16704e5e Mitch Williams   2016-01-13  307  			 rx_ring->rx_stats.realloc_count,
f16704e5e Mitch Williams   2016-01-13  308  			 rx_ring->rx_stats.page_reuse_count);
f16704e5e Mitch Williams   2016-01-13  309  		dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  310  			 "    rx_rings[%i]: size = %i, dma = 0x%08lx\n",
9f65e15b4 Alexander Duyck  2013-09-28  311  			 i, rx_ring->size,
6995b36c0 Jesse Brandeburg 2015-08-28  312  			 (unsigned long int)rx_ring->dma);
02e9c2908 Jesse Brandeburg 2013-09-11  313  		dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  314  			 "    rx_rings[%i]: vsi = %p, q_vector = %p\n",
9f65e15b4 Alexander Duyck  2013-09-28  315  			 i, rx_ring->vsi,
9f65e15b4 Alexander Duyck  2013-09-28  316  			 rx_ring->q_vector);
a75e8005d Kan Liang        2016-02-19  317  		dev_info(&pf->pdev->dev,
a75e8005d Kan Liang        2016-02-19  318  			 "    rx_rings[%i]: rx_itr_setting = %d (%s)\n",
a75e8005d Kan Liang        2016-02-19  319  			 i, rx_ring->rx_itr_setting,
a75e8005d Kan Liang        2016-02-19  320  			 ITR_IS_DYNAMIC(rx_ring->rx_itr_setting) ? "dynamic" : "fixed");
02e9c2908 Jesse Brandeburg 2013-09-11  321  	}
02e9c2908 Jesse Brandeburg 2013-09-11  322  	for (i = 0; i < vsi->num_queue_pairs; i++) {
9f65e15b4 Alexander Duyck  2013-09-28  323  		struct i40e_ring *tx_ring = ACCESS_ONCE(vsi->tx_rings[i]);
6995b36c0 Jesse Brandeburg 2015-08-28  324  
9f65e15b4 Alexander Duyck  2013-09-28  325  		if (!tx_ring)
9f65e15b4 Alexander Duyck  2013-09-28  326  			continue;
1b60f3c41 Jesse Brandeburg 2013-11-28  327  
02e9c2908 Jesse Brandeburg 2013-09-11  328  		dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  329  			 "    tx_rings[%i]: desc = %p\n",
9f65e15b4 Alexander Duyck  2013-09-28  330  			 i, tx_ring->desc);
02e9c2908 Jesse Brandeburg 2013-09-11  331  		dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  332  			 "    tx_rings[%i]: dev = %p, netdev = %p, tx_bi = %p\n",
9f65e15b4 Alexander Duyck  2013-09-28  333  			 i, tx_ring->dev,
9f65e15b4 Alexander Duyck  2013-09-28  334  			 tx_ring->netdev,
9f65e15b4 Alexander Duyck  2013-09-28  335  			 tx_ring->tx_bi);
02e9c2908 Jesse Brandeburg 2013-09-11  336  		dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  337  			 "    tx_rings[%i]: state = %li, queue_index = %d, reg_idx = %d\n",
9f65e15b4 Alexander Duyck  2013-09-28  338  			 i, tx_ring->state,
9f65e15b4 Alexander Duyck  2013-09-28  339  			 tx_ring->queue_index,
9f65e15b4 Alexander Duyck  2013-09-28  340  			 tx_ring->reg_idx);
02e9c2908 Jesse Brandeburg 2013-09-11  341  		dev_info(&pf->pdev->dev,
4668607aa Mitch Williams   2016-01-13  342  			 "    tx_rings[%i]: next_to_use = %d, next_to_clean = %d, ring_active = %i\n",
4668607aa Mitch Williams   2016-01-13  343  			 i,
9f65e15b4 Alexander Duyck  2013-09-28  344  			 tx_ring->next_to_use,
9f65e15b4 Alexander Duyck  2013-09-28  345  			 tx_ring->next_to_clean,
9f65e15b4 Alexander Duyck  2013-09-28  346  			 tx_ring->ring_active);
02e9c2908 Jesse Brandeburg 2013-09-11  347  		dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  348  			 "    tx_rings[%i]: tx_stats: packets = %lld, bytes = %lld, restart_queue = %lld\n",
9f65e15b4 Alexander Duyck  2013-09-28  349  			 i, tx_ring->stats.packets,
9f65e15b4 Alexander Duyck  2013-09-28  350  			 tx_ring->stats.bytes,
9f65e15b4 Alexander Duyck  2013-09-28  351  			 tx_ring->tx_stats.restart_queue);
02e9c2908 Jesse Brandeburg 2013-09-11  352  		dev_info(&pf->pdev->dev,
c304fdac6 Alexander Duyck  2013-09-28  353  			 "    tx_rings[%i]: tx_stats: tx_busy = %lld, tx_done_old = %lld\n",
02e9c2908 Jesse Brandeburg 2013-09-11  354  			 i,
9f65e15b4 Alexander Duyck  2013-09-28  355  			 tx_ring->tx_stats.tx_busy,
9f65e15b4 Alexander Duyck  2013-09-28  356  			 tx_ring->tx_stats.tx_done_old);
02e9c2908 Jesse Brandeburg 2013-09-11  357  		dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  358  			 "    tx_rings[%i]: size = %i, dma = 0x%08lx\n",
9f65e15b4 Alexander Duyck  2013-09-28  359  			 i, tx_ring->size,
6995b36c0 Jesse Brandeburg 2015-08-28  360  			 (unsigned long int)tx_ring->dma);
02e9c2908 Jesse Brandeburg 2013-09-11  361  		dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  362  			 "    tx_rings[%i]: vsi = %p, q_vector = %p\n",
9f65e15b4 Alexander Duyck  2013-09-28  363  			 i, tx_ring->vsi,
9f65e15b4 Alexander Duyck  2013-09-28  364  			 tx_ring->q_vector);
02e9c2908 Jesse Brandeburg 2013-09-11  365  		dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  366  			 "    tx_rings[%i]: DCB tc = %d\n",
9f65e15b4 Alexander Duyck  2013-09-28  367  			 i, tx_ring->dcb_tc);
a75e8005d Kan Liang        2016-02-19  368  		dev_info(&pf->pdev->dev,
a75e8005d Kan Liang        2016-02-19  369  			 "    tx_rings[%i]: tx_itr_setting = %d (%s)\n",
a75e8005d Kan Liang        2016-02-19  370  			 i, tx_ring->tx_itr_setting,
a75e8005d Kan Liang        2016-02-19  371  			 ITR_IS_DYNAMIC(tx_ring->tx_itr_setting) ? "dynamic" : "fixed");
02e9c2908 Jesse Brandeburg 2013-09-11  372  	}
9f65e15b4 Alexander Duyck  2013-09-28  373  	rcu_read_unlock();
02e9c2908 Jesse Brandeburg 2013-09-11  374  	dev_info(&pf->pdev->dev,
a75e8005d Kan Liang        2016-02-19  375  		 "    work_limit = %d\n",
a75e8005d Kan Liang        2016-02-19  376  		 vsi->work_limit);
02e9c2908 Jesse Brandeburg 2013-09-11  377  	dev_info(&pf->pdev->dev,
1a557afc4 Jesse Brandeburg 2016-04-20  378  		 "    max_frame = %d, rx_buf_len = %d dtype = %d\n",
bec60fc42 Jesse Brandeburg 2016-04-18  379  		 vsi->max_frame, vsi->rx_buf_len, 0);
02e9c2908 Jesse Brandeburg 2013-09-11  380  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  381  		 "    num_q_vectors = %i, base_vector = %i\n",
02e9c2908 Jesse Brandeburg 2013-09-11  382  		 vsi->num_q_vectors, vsi->base_vector);
02e9c2908 Jesse Brandeburg 2013-09-11  383  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  384  		 "    seid = %d, id = %d, uplink_seid = %d\n",
02e9c2908 Jesse Brandeburg 2013-09-11  385  		 vsi->seid, vsi->id, vsi->uplink_seid);
02e9c2908 Jesse Brandeburg 2013-09-11  386  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  387  		 "    base_queue = %d, num_queue_pairs = %d, num_desc = %d\n",
02e9c2908 Jesse Brandeburg 2013-09-11  388  		 vsi->base_queue, vsi->num_queue_pairs, vsi->num_desc);
02e9c2908 Jesse Brandeburg 2013-09-11  389  	dev_info(&pf->pdev->dev, "    type = %i\n", vsi->type);
3118025a0 Mitch Williams   2017-04-12  390  	if (vsi->type == I40E_VSI_SRIOV)
3118025a0 Mitch Williams   2017-04-12  391  		dev_info(&pf->pdev->dev, "    VF ID = %i\n", vsi->vf_id);
02e9c2908 Jesse Brandeburg 2013-09-11  392  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  393  		 "    info: valid_sections = 0x%04x, switch_id = 0x%04x\n",
02e9c2908 Jesse Brandeburg 2013-09-11  394  		 vsi->info.valid_sections, vsi->info.switch_id);
02e9c2908 Jesse Brandeburg 2013-09-11  395  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  396  		 "    info: sw_reserved[] = 0x%02x 0x%02x\n",
02e9c2908 Jesse Brandeburg 2013-09-11  397  		 vsi->info.sw_reserved[0], vsi->info.sw_reserved[1]);
02e9c2908 Jesse Brandeburg 2013-09-11  398  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  399  		 "    info: sec_flags = 0x%02x, sec_reserved = 0x%02x\n",
02e9c2908 Jesse Brandeburg 2013-09-11  400  		 vsi->info.sec_flags, vsi->info.sec_reserved);
02e9c2908 Jesse Brandeburg 2013-09-11  401  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  402  		 "    info: pvid = 0x%04x, fcoe_pvid = 0x%04x, port_vlan_flags = 0x%02x\n",
02e9c2908 Jesse Brandeburg 2013-09-11  403  		 vsi->info.pvid, vsi->info.fcoe_pvid,
02e9c2908 Jesse Brandeburg 2013-09-11  404  		 vsi->info.port_vlan_flags);
02e9c2908 Jesse Brandeburg 2013-09-11  405  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  406  		 "    info: pvlan_reserved[] = 0x%02x 0x%02x 0x%02x\n",
02e9c2908 Jesse Brandeburg 2013-09-11  407  		 vsi->info.pvlan_reserved[0], vsi->info.pvlan_reserved[1],
02e9c2908 Jesse Brandeburg 2013-09-11  408  		 vsi->info.pvlan_reserved[2]);
02e9c2908 Jesse Brandeburg 2013-09-11  409  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  410  		 "    info: ingress_table = 0x%08x, egress_table = 0x%08x\n",
02e9c2908 Jesse Brandeburg 2013-09-11  411  		 vsi->info.ingress_table, vsi->info.egress_table);
02e9c2908 Jesse Brandeburg 2013-09-11  412  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  413  		 "    info: cas_pv_stag = 0x%04x, cas_pv_flags= 0x%02x, cas_pv_reserved = 0x%02x\n",
02e9c2908 Jesse Brandeburg 2013-09-11  414  		 vsi->info.cas_pv_tag, vsi->info.cas_pv_flags,
02e9c2908 Jesse Brandeburg 2013-09-11  415  		 vsi->info.cas_pv_reserved);
02e9c2908 Jesse Brandeburg 2013-09-11  416  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  417  		 "    info: queue_mapping[0..7 ] = 0x%04x 0x%04x 0x%04x 0x%04x 0x%04x 0x%04x 0x%04x 0x%04x\n",
02e9c2908 Jesse Brandeburg 2013-09-11  418  		 vsi->info.queue_mapping[0], vsi->info.queue_mapping[1],
02e9c2908 Jesse Brandeburg 2013-09-11  419  		 vsi->info.queue_mapping[2], vsi->info.queue_mapping[3],
02e9c2908 Jesse Brandeburg 2013-09-11  420  		 vsi->info.queue_mapping[4], vsi->info.queue_mapping[5],
02e9c2908 Jesse Brandeburg 2013-09-11  421  		 vsi->info.queue_mapping[6], vsi->info.queue_mapping[7]);
02e9c2908 Jesse Brandeburg 2013-09-11  422  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  423  		 "    info: queue_mapping[8..15] = 0x%04x 0x%04x 0x%04x 0x%04x 0x%04x 0x%04x 0x%04x 0x%04x\n",
02e9c2908 Jesse Brandeburg 2013-09-11  424  		 vsi->info.queue_mapping[8], vsi->info.queue_mapping[9],
02e9c2908 Jesse Brandeburg 2013-09-11  425  		 vsi->info.queue_mapping[10], vsi->info.queue_mapping[11],
02e9c2908 Jesse Brandeburg 2013-09-11  426  		 vsi->info.queue_mapping[12], vsi->info.queue_mapping[13],
02e9c2908 Jesse Brandeburg 2013-09-11  427  		 vsi->info.queue_mapping[14], vsi->info.queue_mapping[15]);
02e9c2908 Jesse Brandeburg 2013-09-11  428  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  429  		 "    info: tc_mapping[] = 0x%04x 0x%04x 0x%04x 0x%04x 0x%04x 0x%04x 0x%04x 0x%04x\n",
02e9c2908 Jesse Brandeburg 2013-09-11  430  		 vsi->info.tc_mapping[0], vsi->info.tc_mapping[1],
02e9c2908 Jesse Brandeburg 2013-09-11  431  		 vsi->info.tc_mapping[2], vsi->info.tc_mapping[3],
02e9c2908 Jesse Brandeburg 2013-09-11  432  		 vsi->info.tc_mapping[4], vsi->info.tc_mapping[5],
02e9c2908 Jesse Brandeburg 2013-09-11  433  		 vsi->info.tc_mapping[6], vsi->info.tc_mapping[7]);
02e9c2908 Jesse Brandeburg 2013-09-11  434  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  435  		 "    info: queueing_opt_flags = 0x%02x  queueing_opt_reserved[0..2] = 0x%02x 0x%02x 0x%02x\n",
02e9c2908 Jesse Brandeburg 2013-09-11  436  		 vsi->info.queueing_opt_flags,
02e9c2908 Jesse Brandeburg 2013-09-11  437  		 vsi->info.queueing_opt_reserved[0],
02e9c2908 Jesse Brandeburg 2013-09-11  438  		 vsi->info.queueing_opt_reserved[1],
02e9c2908 Jesse Brandeburg 2013-09-11  439  		 vsi->info.queueing_opt_reserved[2]);
02e9c2908 Jesse Brandeburg 2013-09-11  440  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  441  		 "    info: up_enable_bits = 0x%02x\n",
02e9c2908 Jesse Brandeburg 2013-09-11  442  		 vsi->info.up_enable_bits);
02e9c2908 Jesse Brandeburg 2013-09-11  443  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  444  		 "    info: sched_reserved = 0x%02x, outer_up_table = 0x%04x\n",
02e9c2908 Jesse Brandeburg 2013-09-11  445  		 vsi->info.sched_reserved, vsi->info.outer_up_table);
02e9c2908 Jesse Brandeburg 2013-09-11  446  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  447  		 "    info: cmd_reserved[] = 0x%02x 0x%02x 0x%02x 0x0%02x 0x%02x 0x%02x 0x%02x 0x0%02x\n",
02e9c2908 Jesse Brandeburg 2013-09-11  448  		 vsi->info.cmd_reserved[0], vsi->info.cmd_reserved[1],
02e9c2908 Jesse Brandeburg 2013-09-11  449  		 vsi->info.cmd_reserved[2], vsi->info.cmd_reserved[3],
02e9c2908 Jesse Brandeburg 2013-09-11  450  		 vsi->info.cmd_reserved[4], vsi->info.cmd_reserved[5],
02e9c2908 Jesse Brandeburg 2013-09-11  451  		 vsi->info.cmd_reserved[6], vsi->info.cmd_reserved[7]);
02e9c2908 Jesse Brandeburg 2013-09-11  452  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  453  		 "    info: qs_handle[] = 0x%04x 0x%04x 0x%04x 0x%04x 0x%04x 0x%04x 0x%04x 0x%04x\n",
02e9c2908 Jesse Brandeburg 2013-09-11  454  		 vsi->info.qs_handle[0], vsi->info.qs_handle[1],
02e9c2908 Jesse Brandeburg 2013-09-11  455  		 vsi->info.qs_handle[2], vsi->info.qs_handle[3],
02e9c2908 Jesse Brandeburg 2013-09-11  456  		 vsi->info.qs_handle[4], vsi->info.qs_handle[5],
02e9c2908 Jesse Brandeburg 2013-09-11  457  		 vsi->info.qs_handle[6], vsi->info.qs_handle[7]);
02e9c2908 Jesse Brandeburg 2013-09-11  458  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  459  		 "    info: stat_counter_idx = 0x%04x, sched_id = 0x%04x\n",
02e9c2908 Jesse Brandeburg 2013-09-11  460  		 vsi->info.stat_counter_idx, vsi->info.sched_id);
02e9c2908 Jesse Brandeburg 2013-09-11  461  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  462  		 "    info: resp_reserved[] = 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n",
02e9c2908 Jesse Brandeburg 2013-09-11  463  		 vsi->info.resp_reserved[0], vsi->info.resp_reserved[1],
02e9c2908 Jesse Brandeburg 2013-09-11  464  		 vsi->info.resp_reserved[2], vsi->info.resp_reserved[3],
02e9c2908 Jesse Brandeburg 2013-09-11  465  		 vsi->info.resp_reserved[4], vsi->info.resp_reserved[5],
02e9c2908 Jesse Brandeburg 2013-09-11  466  		 vsi->info.resp_reserved[6], vsi->info.resp_reserved[7],
02e9c2908 Jesse Brandeburg 2013-09-11  467  		 vsi->info.resp_reserved[8], vsi->info.resp_reserved[9],
02e9c2908 Jesse Brandeburg 2013-09-11  468  		 vsi->info.resp_reserved[10], vsi->info.resp_reserved[11]);
02e9c2908 Jesse Brandeburg 2013-09-11  469  	if (vsi->back)
b40c82e6a Jeff Kirsher     2015-02-27  470  		dev_info(&pf->pdev->dev, "    PF = %p\n", vsi->back);
02e9c2908 Jesse Brandeburg 2013-09-11  471  	dev_info(&pf->pdev->dev, "    idx = %d\n", vsi->idx);
02e9c2908 Jesse Brandeburg 2013-09-11  472  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  473  		 "    tc_config: numtc = %d, enabled_tc = 0x%x\n",
02e9c2908 Jesse Brandeburg 2013-09-11  474  		 vsi->tc_config.numtc, vsi->tc_config.enabled_tc);
02e9c2908 Jesse Brandeburg 2013-09-11  475  	for (i = 0; i < I40E_MAX_TRAFFIC_CLASS; i++) {
02e9c2908 Jesse Brandeburg 2013-09-11  476  		dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  477  			 "    tc_config: tc = %d, qoffset = %d, qcount = %d, netdev_tc = %d\n",
02e9c2908 Jesse Brandeburg 2013-09-11  478  			 i, vsi->tc_config.tc_info[i].qoffset,
02e9c2908 Jesse Brandeburg 2013-09-11  479  			 vsi->tc_config.tc_info[i].qcount,
02e9c2908 Jesse Brandeburg 2013-09-11  480  			 vsi->tc_config.tc_info[i].netdev_tc);
02e9c2908 Jesse Brandeburg 2013-09-11  481  	}
02e9c2908 Jesse Brandeburg 2013-09-11  482  	dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  483  		 "    bw: bw_limit = %d, bw_max_quanta = %d\n",
02e9c2908 Jesse Brandeburg 2013-09-11  484  		 vsi->bw_limit, vsi->bw_max_quanta);
02e9c2908 Jesse Brandeburg 2013-09-11  485  	for (i = 0; i < I40E_MAX_TRAFFIC_CLASS; i++) {
02e9c2908 Jesse Brandeburg 2013-09-11  486  		dev_info(&pf->pdev->dev,
02e9c2908 Jesse Brandeburg 2013-09-11  487  			 "    bw[%d]: ets_share_credits = %d, ets_limit_credits = %d, max_quanta = %d\n",
02e9c2908 Jesse Brandeburg 2013-09-11  488  			 i, vsi->bw_ets_share_credits[i],
02e9c2908 Jesse Brandeburg 2013-09-11  489  			 vsi->bw_ets_limit_credits[i],
02e9c2908 Jesse Brandeburg 2013-09-11  490  			 vsi->bw_ets_max_quanta[i]);
02e9c2908 Jesse Brandeburg 2013-09-11  491  	}
02e9c2908 Jesse Brandeburg 2013-09-11  492  }
02e9c2908 Jesse Brandeburg 2013-09-11  493  

:::::: The code at line 281 was first introduced by commit
:::::: 02e9c290814cc143ceccecb14eac3e7a05da745e i40e: debugfs interface

:::::: TO: Jesse Brandeburg <jesse.brandeburg@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 51531 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170831/800d4ab9/attachment-0001.bin>
