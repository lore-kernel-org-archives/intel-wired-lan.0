From: Damilola Bello <rogbabello@gmail.com>
Date: Tue, 13 Apr 2021 15:19:55 -0400
Subject: [Intel-wired-lan] i40e and igb ethtool counters
Message-ID: <CAFspsv4==uah2gw8SM1aERmBCteJH2TKYQJGoog4kkOSXSwizQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I'd like to get a rough estimate of the follwoing: Total packets, Dropped
packets, Error packets and Successful packets (transmitted/received) all
from the ethtool.

My assumptions:

igb:
Total RX packets received from the network: "rx_packets" + "rx_errors" +
"rx_missed_errors" + ("rx_fifo_errors" - "rx_missed_errors")
Total TX packets sent by the host: "tx_packets" + "tx_errors"
Dropped RX packets: "rx_missed_errors" +  ("rx_fifo_errors" -
"rx_missed_errors")
Dropped TX packets: "tx_dropped"
RX error packets: "rx_errors"
TX error packets; "tx_errors"
Successful RX packets: "rx_packets" - ("rx_fifo_errors" -
"rx_missed_errors")
Successful TX packets: "tx_packets"

Note: igb adds the MPC ("rx_missed_errors") to "rx_fifo_errors".

i40e:
Total RX packets received from the network:
"port.rx_dropped" +"rx_packets" + "rx_dropped"  + "rx_errors"
Total TX packets sent by the host: "port.tx_dropped" + "tx_packets" +
"tx_dropped"  + "tx_errors"
Dropped RX packets: "rx_dropped"
Dropped TX packets: "tx_dropped"
RX error packets: "rx_errors"
TX error packets; "tx_errors"
Successful RX packets: "rx_packets"
Successful TX packets: "tx_packets"

I would like to know if the assumptions above are correct.
Thanks.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210413/29133f5c/attachment.html>
