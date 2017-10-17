From: Gavin Lambert <gavin.lambert@compacsort.com>
Date: Tue, 17 Oct 2017 03:05:09 +0000
Subject: [Intel-wired-lan] Packet loss on 82571EB with kernel 4.9
Message-ID: <SG2PR03MB187291B811B5438AEADC53AE844C0@SG2PR03MB1872.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

(Please explicitly CC me in any replies.)
I have a computer with an Intel 82571EB 2-port card using the e1000e driver.  I've noticed that it appears to be dropping some transmitted packets:

# iperf3 -c 10.200.197.17
Connecting to host 10.200.197.17, port 5201
[  4] local 10.200.197.82 port 59294 connected to 10.200.197.17 port 5201
[ ID] Interval           Transfer     Bandwidth       Retr  Cwnd
[  4]   0.00-1.00   sec   113 MBytes   951 Mbits/sec    0    223 KBytes
[  4]   1.00-2.00   sec   112 MBytes   941 Mbits/sec    0    223 KBytes
[  4]   2.00-3.00   sec   112 MBytes   941 Mbits/sec   10    204 KBytes
[  4]   3.00-4.00   sec   112 MBytes   941 Mbits/sec    0    221 KBytes
[  4]   4.00-5.00   sec   112 MBytes   941 Mbits/sec   10    154 KBytes
[  4]   5.00-6.00   sec   112 MBytes   942 Mbits/sec    0    222 KBytes
[  4]   6.00-7.00   sec   112 MBytes   941 Mbits/sec    0    222 KBytes
[  4]   7.00-8.00   sec   112 MBytes   941 Mbits/sec    0    222 KBytes
[  4]   8.00-9.00   sec   112 MBytes   942 Mbits/sec    0    222 KBytes
[  4]   9.00-10.00  sec   112 MBytes   941 Mbits/sec    0    222 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bandwidth       Retr
[  4]   0.00-10.00  sec  1.10 GBytes   942 Mbits/sec   20             sender
[  4]   0.00-10.00  sec  1.10 GBytes   941 Mbits/sec                  receiver

# iperf3 -c 10.200.197.17 -u -b0
...
[ ID] Interval           Transfer     Bandwidth       Jitter    Lost/Total Datagrams
[  4]   0.00-10.00  sec  1.12 GBytes   958 Mbits/sec  0.123 ms  28/146256 (0.019%)
[  4] Sent 146256 datagrams

(A reverse run with -R, where this PC is only receiving packets, doesn't report any problems.)

The computer is running Debian Linux Stretch x86_64 with kernel 4.9.30-2+deb9u2.
       e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
       e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
       e1000e 0000:01:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
       e1000e 0000:01:00.0 eth0: (PCI Express:2.5GT/s:Width x4) 68:05:ca:16:5a:24
       e1000e 0000:01:00.0 eth0: Intel(R) PRO/1000 Network Connection
       e1000e 0000:01:00.0 eth0: MAC: 0, PHY: 4, PBA No: D50868-008
       e1000e 0000:01:00.1: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
       e1000e 0000:01:00.1 eth1: (PCI Express:2.5GT/s:Width x4) 68:05:ca:16:5a:25
       e1000e 0000:01:00.1 eth1: Intel(R) PRO/1000 Network Connection
       e1000e 0000:01:00.1 eth1: MAC: 0, PHY: 4, PBA No: D50868-008
       e1000e 0000:01:00.0 enp1s0f0: renamed from eth0
       e1000e 0000:01:00.1 enp1s0f1: renamed from eth1
       e1000e: enp1s0f0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
       IPv6: ADDRCONF(NETDEV_CHANGE): enp1s0f0: link becomes ready

The tests above were performed with enp1s0f0, but unsurprisingly enp1s0f1 behaves the same way.  The computer also has a non-Intel network card and performing the same tests on that does not produce any errors.

If I downgrade the computer to Debian Jessie with kernel 3.2.54 and e1000e driver 1.5.1-k then there is no packet loss in the same test.  I don't currently have anything in between these versions, although I might be able to build something custom if that will help.

What information is needed to diagnose this further and correct the problem?

