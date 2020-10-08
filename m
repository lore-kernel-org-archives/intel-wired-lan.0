From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Thu, 8 Oct 2020 17:57:49 +0200
Subject: [Intel-wired-lan] What are management packets (rx_smbus, MGTPRC)?
Message-ID: <8ecde631-9b24-b177-749c-a5a6bddc31df@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Linux folks,


We are trying to debug a network issue, and, while looking at the 
network device statistics, noticed a high value of `rx_smbus`.

     $ sudo ethtool -S net00
     [?]
     tx_smbus: 0
     rx_smbus: 557816
     dropped_smbus: 9
     [?]

This seems unrelated to our problem, but we noticed, that around 20 % of 
our desktops have a positive value. From the source:

     drivers/net/ethernet/intel/e1000/e1000_main.c: 
adapter->stats.mgprc += er32(MGTPRC);
     drivers/net/ethernet/intel/e1000e/ethtool.c: 
E1000_STAT("rx_smbus", stats.mgprc

     drivers/net/ethernet/intel/e1000e/regs.h:#define E1000_MGTPRC 
0x040B4 /* Management Packets Rx Count - R/clr *

Out of curiosity, what are these management packets?


Kind regards,

Paul


$ sudo ethtool -S net00
NIC statistics:
      rx_packets: 993001516
      tx_packets: 1331956350
      rx_bytes: 938128015910
      tx_bytes: 1842492467154
      rx_broadcast: 84929255
      tx_broadcast: 237026
      rx_multicast: 3869371
      tx_multicast: 47602
      rx_errors: 250
      tx_errors: 0
      tx_dropped: 0
      multicast: 3869371
      collisions: 0
      rx_length_errors: 0
      rx_over_errors: 0
      rx_crc_errors: 187
      rx_frame_errors: 0
      rx_no_buffer_count: 0
      rx_missed_errors: 0
      tx_aborted_errors: 0
      tx_carrier_errors: 0
      tx_fifo_errors: 0
      tx_heartbeat_errors: 0
      tx_window_errors: 0
      tx_abort_late_coll: 0
      tx_deferred_ok: 0
      tx_single_coll_ok: 0
      tx_multi_coll_ok: 0
      tx_timeout_count: 0
      tx_restart_queue: 0
      rx_long_length_errors: 0
      rx_short_length_errors: 0
      rx_align_errors: 0
      tx_tcp_seg_good: 31498083
      tx_tcp_seg_failed: 0
      rx_flow_control_xon: 0
      rx_flow_control_xoff: 0
      tx_flow_control_xon: 0
      tx_flow_control_xoff: 0
      rx_csum_offload_good: 927463008
      rx_csum_offload_errors: 34
      rx_header_split: 0
      alloc_rx_buff_failed: 0
      tx_smbus: 0
      rx_smbus: 557816
      dropped_smbus: 9
      rx_dma_failed: 0
      tx_dma_failed: 0
      rx_hwtstamp_cleared: 0
      uncorr_ecc_errors: 0
      corr_ecc_errors: 0
      tx_hwtstamp_timeouts: 0
      tx_hwtstamp_skipped: 0
