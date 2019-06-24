From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Mon, 24 Jun 2019 17:09:37 +0800
Subject: [Intel-wired-lan] RX CRC errors on I219-V (6) 8086:15be
Message-ID: <C4036C54-EEEB-47F3-9200-4DD1B22B4280@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jeffrey,

We?ve encountered another issue, which causes multiple CRC errors and  
renders ethernet completely useless, here?s the network stats:

/sys/class/net/eno1/statistics$ grep . *
collisions:0
multicast:95
rx_bytes:1499851
rx_compressed:0
rx_crc_errors:1165
rx_dropped:0
rx_errors:2330
rx_fifo_errors:0
rx_frame_errors:0
rx_length_errors:0
rx_missed_errors:0
rx_nohandler:0
rx_over_errors:0
rx_packets:4789
tx_aborted_errors:0
tx_bytes:864312
tx_carrier_errors:0
tx_compressed:0
tx_dropped:0
tx_errors:0
tx_fifo_errors:0
tx_heartbeat_errors:0
tx_packets:7370
tx_window_errors:0

Same behavior can be observed on both mainline kernel and on your dev-queue  
branch.
OTOH, the same issue can?t be observed on out-of-tree e1000e.

Is there any plan to close the gap between upstream and out-of-tree version?

Kai-Heng
