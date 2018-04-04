From: Amritha Nambiar <amritha.nambiar@intel.com>
Date: Wed, 04 Apr 2018 12:59:49 -0700
Subject: [Intel-wired-lan] [jkirsher/next-queue,
 RFC PATCH 0/3] Symmetric queue selection using XPS for Rx queues
Message-ID: <152287164664.5088.10567280431867626085.stgit@anamdev.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch series implements support for Tx queue selection based on
Rx queue map. This is done by configuring Rx queue map per Tx-queue
using sysfs attribute. If the user configuration for Rx queues does
not apply, then the Tx queue selection falls back to XPS using CPUs and
finally to hashing.

XPS is refactored to support Tx queue selection based on either the
CPU map or the Rx-queue map. The config option CONFIG_XPS needs to be
enabled. By default no receive queues are configured for the Tx queue.

- /sys/class/net/eth0/queues/tx-*/xps_rxqs

This is to enable sending packets on the same Tx-Rx queue pair as this
is useful for busy polling multi-threaded workloads where it is not
possible to pin the threads to a CPU. This is a rework of Sridhar's
patch for symmetric queueing via socket option:
https://www.spinics.net/lists/netdev/msg453106.html

---

Amritha Nambiar (3):
      net: Refactor XPS for CPUs and Rx queues
      net: Enable Tx queue selection based on Rx queues
      net-sysfs: Add interface for Rx queue map per Tx queue


 include/linux/netdevice.h |   82 +++++++++++++++
 include/net/sock.h        |   18 +++
 net/core/dev.c            |  242 +++++++++++++++++++++++++++++++--------------
 net/core/net-sysfs.c      |   85 +++++++++++++++-
 net/core/sock.c           |    5 +
 net/ipv4/tcp_input.c      |    7 +
 net/ipv4/tcp_ipv4.c       |    1 
 net/ipv4/tcp_minisocks.c  |    1 
 8 files changed, 360 insertions(+), 81 deletions(-)

--
