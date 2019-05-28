From: Vedang Patel <vedang.patel@intel.com>
Date: Tue, 28 May 2019 10:46:41 -0700
Subject: [Intel-wired-lan] [PATCH net-next v1 0/7] net/sched: Add txtime
 assist support for taprio
Message-ID: <1559065608-27888-1-git-send-email-vedang.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Currently, we are seeing packets being transmitted outside their timeslices. We
can confirm that the packets are being dequeued at the right time. So, the
delay is induced after the packet is dequeued, because taprio, without any
offloading, has no control of when a packet is actually transmitted.

In order to solve this, we are making use of the txtime feature provided by ETF
qdisc. Hardware offloading needs to be supported by the ETF qdisc in order to
take advantage of this feature. The taprio qdisc will assign txtime (in
skb->tstamp) for all the packets which do not have the txtime allocated via the
SO_TXTIME socket option. For the packets which already have SO_TXTIME set,
taprio will validate whether the packet will be transmitted in the correct
interval.

In order to support this, the following parameters have been added:
- offload (taprio): This is added in order to support different offloading
  modes which will be added in the future.
- txtime-delay (taprio): this is the time the packet takes to traverse through
  the kernel to adapter card.
- skip_sock_check (etf): etf qdisc currently drops any packet which does not
  have the SO_TXTIME socket option set. This check can be skipped by specifying
  this option.

Following is an example configuration:

$ tc qdisc replace dev $IFACE parent root handle 100 taprio \\
      num_tc 3 \\
      map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 \\
      queues 1 at 0 1 at 0 1 at 0 \\
      base-time $BASE_TIME \\
      sched-entry S 01 300000 \\
      sched-entry S 02 300000 \\
      sched-entry S 04 400000 \\
      offload 2 \\
      txtime-delay 40000 \\
      clockid CLOCK_TAI

$ tc qdisc replace dev $IFACE parent 100:1 etf \\
      offload delta 200000 clockid CLOCK_TAI skip_sock_check

Here, the "offload" parameter is indicating that the TXTIME_OFFLOAD mode is
enabled. Also, that all the traffic classes have been assigned the same queue.
This is to prevent the traffic classes in the lower priority queues from
getting starved. Note that this configuration is specific to the i210 ethernet
card. Other network cards where the hardware queues are given the same
priority, might be able to utilize more than one queue.

Following are some of the other highlights of the series:
- Fix a bug where hardware timestamping and SO_TXTIME options cannot be used
  together. (Patch 1)
- Introduce hardware offloading. This patch introduces offload parameter which
  can be used to enable the txtime offload mode. It will also support enabling
  full offload when the support is available in drivers. (Patch 3)
- Make TxTime assist mode work with TCP packets. (Patch 6 & 7)


The following changes are recommended to be done in order to get the best
performance from taprio in this mode:
# ip link set dev enp1s0 mtu 1514
# ethtool -K eth0 gso off
# ethtool -K eth0 tso off
# ethtool --set-eee eth0 eee off

Thanks,
Vedang Patel

Vedang Patel (6):
  igb: clear out tstamp after sending the packet.
  etf: Add skip_sock_check
  taprio: calculate cycle_time when schedule is installed
  taprio: Add support for txtime offload mode.
  taprio: make clock reference conversions easier
  taprio: Adjust timestamps for TCP packets.

Vinicius Costa Gomes (1):
  taprio: Add the skeleton to enable hardware offloading

 drivers/net/ethernet/intel/igb/igb_main.c |   1 +
 include/uapi/linux/pkt_sched.h            |   6 +
 net/sched/sch_etf.c                       |  10 +
 net/sched/sch_taprio.c                    | 548 ++++++++++++++++++++--
 4 files changed, 532 insertions(+), 33 deletions(-)

-- 
2.17.0

