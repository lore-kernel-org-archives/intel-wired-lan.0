From: Dan Streetman <dan.streetman@canonical.com>
Date: Thu, 1 Oct 2015 15:16:27 -0400
Subject: [Intel-wired-lan] failure in ixgbe_disable_rx_queue(),
	and master disable timeout
Message-ID: <CAOZ2QJPyaxg3qhzFzo9zPO-9+p0SVM4A5QpeJXgDOApfU9VGAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello,

I have a report of some strange behavior with a ixgbe nic, failing to
clear the IXGBE_RXDCTL_ENABLE bit.  Do you or anyone know of anything
that would cause that?  And/or, how to recover?

What I'm seeing is it's getting tx timeouts/hangs, e.g.:

Sep 10 07:26:28 hypervisor kernel: [22953602.207900] ixgbe
0000:04:00.0 p2p1: Detected Tx Unit Hang
Sep 10 07:26:28 hypervisor kernel: [22953602.207900]   Tx Queue             <8>
Sep 10 07:26:28 hypervisor kernel: [22953602.207900]   TDH, TDT
     <0>, <1>
Sep 10 07:26:28 hypervisor kernel: [22953602.207900]   next_to_use          <1>
Sep 10 07:26:28 hypervisor kernel: [22953602.207900]   next_to_clean        <0>
Sep 10 07:26:28 hypervisor kernel: [22953602.207900]
tx_buffer_info[next_to_clean]
Sep 10 07:26:28 hypervisor kernel: [22953602.207900]   time_stamp
     <25603350d>
Sep 10 07:26:28 hypervisor kernel: [22953602.207900]   jiffies
     <2560335db>
Sep 10 07:26:28 hypervisor kernel: [22953602.207953] ixgbe
0000:04:00.0 p2p1: tx hang 111 detected on queue 16, resetting adapter
Sep 10 07:26:28 hypervisor kernel: [22953602.207991] ixgbe
0000:04:00.0 p2p1: tx hang 111 detected on queue 3, resetting adapter
Sep 10 07:26:28 hypervisor kernel: [22953602.208028] ixgbe
0000:04:00.0 p2p1: tx hang 111 detected on queue 27, resetting adapter
Sep 10 07:26:28 hypervisor kernel: [22953602.208072] ixgbe
0000:04:00.0 p2p1: initiating reset due to tx timeout
Sep 10 07:26:28 hypervisor kernel: [22953602.208103] ixgbe
0000:04:00.0 p2p1: initiating reset due to tx timeout
Sep 10 07:26:28 hypervisor kernel: [22953602.208127] ixgbe
0000:04:00.0 p2p1: initiating reset due to tx timeout

which by itself may be ok, but then there's a problem disabling the rx
queues, e.g.:

Sep 10 07:26:28 hypervisor kernel: [22953602.208702] ixgbe
0000:04:00.0 p2p1: RXDCTL.ENABLE on Rx queue 4 not cleared within the
polling period
Sep 10 07:26:28 hypervisor kernel: [22953602.209717] ixgbe
0000:04:00.0 p2p1: RXDCTL.ENABLE on Rx queue 13 not cleared within the
polling period
Sep 10 07:26:28 hypervisor kernel: [22953602.210735] ixgbe
0000:04:00.0 p2p1: RXDCTL.ENABLE on Rx queue 22 not cleared within the
polling period
Sep 10 07:26:28 hypervisor kernel: [22953602.211769] ixgbe
0000:04:00.0 p2p1: RXDCTL.ENABLE on Rx queue 31 not cleared within the
polling period
Sep 10 07:26:28 hypervisor kernel: [22953602.212798] ixgbe
0000:04:00.0 p2p1: RXDCTL.ENABLE on Rx queue 40 not cleared within the
polling period
Sep 10 07:26:28 hypervisor kernel: [22953602.213812] ixgbe
0000:04:00.0 p2p1: RXDCTL.ENABLE on Rx queue 49 not cleared within the
polling period

then the interface is brought back up, but immediately sees tx hangs
again, presumably because the queue wasn't actually reset, e.g.:

Sep 10 07:27:14 hypervisor kernel: [22953663.666774] ixgbe
0000:04:00.0 p2p1: NIC Link is Up 10 Gbps, Flow Control: None
Sep 10 07:27:14 hypervisor kernel: [22953663.682703] br0: port 1(p2p1)
entered forwarding state
Sep 10 07:27:29 hypervisor kernel: [22953667.579209] ixgbe
0000:04:00.0 p2p1: Detected Tx Unit Hang
Sep 10 07:27:29 hypervisor kernel: [22953667.579209]   Tx Queue             <59>
Sep 10 07:27:29 hypervisor kernel: [22953667.579209]   TDH, TDT
     <0>, <1>
Sep 10 07:27:29 hypervisor kernel: [22953667.579209]   next_to_use          <1>
Sep 10 07:27:29 hypervisor kernel: [22953667.579209]   next_to_clean        <0>
Sep 10 07:27:29 hypervisor kernel: [22953667.579209]
tx_buffer_info[next_to_clean]
Sep 10 07:27:29 hypervisor kernel: [22953667.579209]   time_stamp
     <25603728a>
Sep 10 07:27:29 hypervisor kernel: [22953667.579209]   jiffies
     <2560375b1>

the RX disable failure happens for all the queues, and there's also
"Reset adapter" and "master disable timed out" messages in the logs,
e.g.:

Sep 10 06:58:25 hypervisor kernel: [22951934.569219] ixgbe
0000:04:00.0 p2p1: Reset adapter
...
Sep 10 06:59:23 hypervisor kernel: [22951992.420818] ixgbe
0000:04:00.0: master disable timed out


This is on Ubuntu trusty, with kernel 3.13.0-43, with ixgbe driver
version 3.15.1-k:
Sep 10 07:34:25 hypervisor kernel: [    4.944118] ixgbe: Intel(R) 10
Gigabit PCI Express Network Driver - version 3.15.1-k
