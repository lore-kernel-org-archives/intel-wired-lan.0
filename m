From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 15 Mar 2018 16:08:10 +0100
Subject: [Intel-wired-lan] [RFC PATCH 0/2] net:setup XPS mapping for each
 online CPU
Message-ID: <cover.1521124830.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Currently, most MQ netdevice setup the default XPS configuration mapping 1-1
the first real_num_tx_queues queues and CPUs and no mapping is created for
the CPUs with id greater then real_num_tx_queues, if any.

As a result, the xmit path for unconnected sockets on such cores experiences a
relevant overhead in netdev_pick_tx(), which needs to dissect each packet and
compute its hash.

Such scenario is easily triggered. e.g. from DNS server under relevant load, as
the user-space process is moved away from the CPUs serving the softirqs (note:
this is beneficial for the overall DNS server performances).

This series introduces an helper to easily setup up XPS mapping for all the
online CPUs, and use it in the ixgbe driver, demonstrating a relevant
performance improvement in the above scenario.

Paolo Abeni (2):
  net: introduce netif_set_xps()
  ixgbe: setup XPS via netif_set_xps()

 drivers/net/ethernet/intel/ixgbe/ixgbe.h         |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 13 ++----
 include/linux/netdevice.h                        |  6 +++
 net/core/dev.c                                   | 58 ++++++++++++++++++------
 5 files changed, 55 insertions(+), 25 deletions(-)

-- 
2.14.3

