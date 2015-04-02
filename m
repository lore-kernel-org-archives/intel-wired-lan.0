From: Tantilov, Emil S <emil.s.tantilov@intel.com>
Date: Thu, 2 Apr 2015 17:52:22 +0000
Subject: [Intel-wired-lan] [E1000-devel] Fragmented UDP packets trigger
 rx_missed_errors on	82599EB
In-Reply-To: <551CBDE3.30708@gmail.com>
References: <551CBDE3.30708@gmail.com>
Message-ID: <87618083B2453E4A8714035B62D679925028D5FC@FMSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Fan Du [mailto:fengyuleidian0615 at gmail.com] 
>Sent: Wednesday, April 01, 2015 8:56 PM
To: e1000-devel@lists.sourceforge.net
>Cc: Du, Fan; intel-wired-lan at lists.osuosl.org
>Subject: [E1000-devel] Fragmented UDP packets trigger rx_missed_errors on 82599EB
>
>Hi
>
>While investigating a upper level network issue, I found out the root cause may be triggered
>by packet loss at NIC level, showed by rx_missed_errors.
>
>kernel: linux-2.6.32-358.el6.x86_64
>server: iperf -s -B 192.168.5.1 -u
>client: iperf -c 192.168.5.1 -u -b 10G -i 1 -t 1000 -P 12 -l 3k
>Use -l to specify buffers large than MTU to create fragmented IP packets.
>
>1. Tune rx ring from 512 to max 4096 does help for single flow, but still got great rx_missed_errors from multiple flows.
>2. Using latest net-next 4.0.0-rc4 shows the same effect.
>3. Got 9.4Gbits/sec even though rx_missed_errors shows NIC level packets drop.

>rx_missed_errors value comes from RXMPC, where 82599 data sheet 8.2.3.5.1 says:
>"Missed packet interrupt is activated for each received packet that overflows the Rx packet buffer > (overrun).
>he packet is dropped and also increments the associated RXMPC[n] counter."
>
>I'm not sure it means my env is mis-configured or anything I'm missing obviously.
>Any hints?

In simple terms packets are coming in faster than the interface can receive them. See below.

>Attached several logs as below.
># ethtool -S eth4
>NIC statistics:
>rx_packets: 1047869017
>tx_packets: 206275776
>rx_bytes: 1103333268576
>tx_bytes: 289198212456
>rx_pkts_nic: 1047200292
>tx_pkts_nic: 206275773
>rx_bytes_nic: 1907927064202
>tx_bytes_nic: 290023317512
>lsc_int: 17
>tx_busy: 0
>non_eop_descs: 0
>rx_errors: 0
>tx_errors: 0
>rx_dropped: 0
>tx_dropped: 0
>multicast: 0
>broadcast: 4310
>rx_no_buffer_count: 0
>collisions: 0
>rx_over_errors: 0
>rx_crc_errors: 0
>rx_frame_errors: 0
>hw_rsc_aggregated: 0
>hw_rsc_flushed: 0
>fdir_match: 0
>fdir_miss: 6545204
>fdir_overflow: 0
>rx_fifo_errors: 0
>rx_missed_errors: 638609576 <--------
>tx_aborted_errors: 0
>tx_carrier_errors: 0
>tx_fifo_errors: 0
>tx_heartbeat_errors: 0
>tx_timeout_count: 0
>tx_restart_queue: 0
>rx_long_length_errors: 0
>rx_short_length_errors: 0
>tx_flow_control_xon: 174182
>rx_flow_control_xon: 0
>tx_flow_control_xoff: 946044

Your interface is generating XOFF packets, which means that it cannot keep up with the
 upcoming traffic.

You can disable flow control and look at the stats again - usually it will spill over
 to other counters like rx_no_buffer, or rx_no_dma

>
># numactl --hardware
>available: 4 nodes (0-3)
>node 0 cpus: 0 1 2 3 4 20 21 22 23 24
>node 0 size: 24466 MB
>node 0 free: 22444 MB
>node 1 cpus: 5 6 7 8 9 25 26 27 28 29
>node 1 size: 16384 MB
>node 1 free: 15831 MB
>node 2 cpus: 10 11 12 13 14 30 31 32 33 34
>node 2 size: 16384 MB
>node 2 free: 15791 MB
>node 3 cpus: 15 16 17 18 19 35 36 37 38 39
>node 3 size: 24576 MB
>node 3 free: 22508 MB
>node distances:
>node 0 1 2 3
>0: 10 21 31 31
>1: 21 10 31 31
>2: 31 31 10 21
>3: 31 31 21 10

Since you have 4 nodes you may want to check your board layout and try to pin the queues and iperf to the same
 node as the network interface. See if that helps.

If you want to debug your numa allocations in more detail, check out this tool:
http://www.intel.com/software/pcm

Thanks,
Emil

