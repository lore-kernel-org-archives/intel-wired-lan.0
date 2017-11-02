From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 02 Nov 2017 16:33:09 -0700
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 0/5] macvlan offload
 fixes
Message-ID: <20171102232857.15146.21583.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I'm looking at performing a refactor of the macvlan offload code. However
before I started I wanted to at least get things into a running state. The
patches in this set are needed to address a number of issues that were
preventing things from working as they were supposed to.

With these changes in place I seem to be able to receive traffic as I am
supposed to in the case of ixgbe and fm10k with the offload enabled, and I
am now transmitting to the correct Tx ring in the case of ixgbe.

The last two patches in the set are what I consider to be minor clean-ups
to address the fact that we don't want packets to somehow stray and end up
being transmitted on a queue that is supposed to be in use by a macvlan
instead of the lowerdev itself.

---

Alexander Duyck (5):
      ixgbe: Fix interaction between SR-IOV and macvlan offload
      fm10k: Fix VLAN configuration for macvlan offload
      ixgbe: Fix handling of macvlan Tx offload
      dev: Clean-up __skb_tx_hash to match up with traffic class based configs
      dev: Cap number of queues even with accel_priv


 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c |    4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   |   22 ++++++++++++++++++----
 net/core/dev.c                                  |   21 ++++++++++-----------
 3 files changed, 30 insertions(+), 17 deletions(-)

--
