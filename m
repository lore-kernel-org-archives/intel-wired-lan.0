From: Samudrala, Sridhar <sridhar.samudrala@intel.com>
Date: Tue, 03 May 2016 10:58:50 -0700
Subject: [Intel-wired-lan] ixgbe Tx Unit Hangs seen when l2-fwd-offload is
	enabled
Message-ID: <5728E6DA.2050909@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

With the latest davem's next-next or Jeff's dev-queue branch (4.6.0-rc5+), I am seeing Tx Unit Hangs when
using offloaded macvlans.

Here is a simple sequence of commands that can reproduce this issue.
	ethtool -K p4p1 l2-fwd-offload on
	ip link add link p4p1 name mvlan_1 type macvlan
	ip link set mvlan_1 up

Here is the kernel log when this happens.

May 03 10:45:01 sri02 kernel: ixgbe 0000:1f:00.0 p4p1: NIC Link is Up 10 Gbps, Flow Control: RX/TX
May 03 10:45:01 sri02 kernel: IPv6: ADDRCONF(NETDEV_CHANGE): p4p1: link becomes ready
May 03 10:45:30 sri02 kernel: ixgbe 0000:1f:00.0: removed PHC on p4p1
May 03 10:45:30 sri02 kernel: ixgbe 0000:1f:00.0: Multiqueue Enabled: Rx Queue count = 2, Tx Queue count = 2
May 03 10:45:30 sri02 kernel: ixgbe 0000:1f:00.0 p4p1: Could not enable Tx Queue 0
May 03 10:45:30 sri02 kernel: ixgbe 0000:1f:00.0 p4p1: Could not enable Tx Queue 2
May 03 10:45:30 sri02 kernel: ixgbe 0000:1f:00.0: registered PHC device on p4p1
May 03 10:45:30 sri02 kernel: ixgbe 0000:1f:00.0 p4p1: detected SFP+: 5
May 03 10:45:31 sri02 kernel: ixgbe 0000:1f:00.0 p4p1: NIC Link is Up 10 Gbps, Flow Control: RX/TX
May 03 10:45:33 sri02 kernel: ixgbe 0000:1f:00.0 p4p1: Detected Tx Unit Hang
                                 Tx Queue             <0>
                                 TDH, TDT             <0>, <4>
                                 next_to_use          <4>
                                 next_to_clean        <0>
                               tx_buffer_info[next_to_clean]
                                 time_stamp           <10005560a>
                                 jiffies              <100055df4>
May 03 10:45:33 sri02 kernel: ixgbe 0000:1f:00.0 p4p1: tx hang 1 detected on queue 0, resetting adapter
May 03 10:45:33 sri02 kernel: ixgbe 0000:1f:00.0 p4p1: initiating reset due to tx timeout
May 03 10:45:33 sri02 kernel: ixgbe 0000:1f:00.0 p4p1: Reset adapter
May 03 10:45:35 sri02 kernel: ixgbe 0000:1f:00.0 p4p1: Could not enable Tx Queue 0
May 03 10:45:35 sri02 kernel: ixgbe 0000:1f:00.0 p4p1: Could not enable Tx Queue 2
May 03 10:45:35 sri02 kernel: ixgbe 0000:1f:00.0 p4p1: detected SFP+: 5
May 03 10:45:36 sri02 kernel: ixgbe 0000:1f:00.0 p4p1: NIC Link is Up 10 Gbps, Flow Control: RX/TX
May 03 10:45:38 sri02 kernel: ixgbe 0000:1f:00.0 p4p1: Detected Tx Unit Hang
                                 Tx Queue             <0>
                                 TDH, TDT             <0>, <2>
                                 next_to_use          <2>
                                 next_to_clean        <0>
                               tx_buffer_info[next_to_clean]
                                 time_stamp           <1000569a0>
                                 jiffies              <1000571b0>
May 03 10:45:38 sri02 kernel: ixgbe 0000:1f:00.0 p4p1: tx hang 2 detected on queue 0, resetting adapter
May 03 10:45:38 sri02 kernel: ixgbe 0000:1f:00.0 p4p1: initiating reset due to tx timeout
May 03 10:45:38 sri02 kernel: ixgbe 0000:1f:00.0 p4p1: Reset adapter
May 03 10:45:40 sri02 kernel: Virtual device mvlan_1 asks to queue packet!
May 03 10:45:40 sri02 kernel: ixgbe 0000:1f:00.0 p4p1: Could not enable Tx Queue 0
May 03 10:45:40 sri02 kernel: ixgbe 0000:1f:00.0 p4p1: Could not enable Tx Queue 2

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160503/6f45bdb4/attachment-0001.html>
