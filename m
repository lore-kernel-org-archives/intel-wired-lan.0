From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 07 Sep 2016 20:28:11 -0700
Subject: [Intel-wired-lan] [next PATCH 1/3] ixgbe: Allow setting multiple
 queues when SR-IOV is enabled
In-Reply-To: <20160908032606.25312.86849.stgit@localhost.localdomain>
References: <20160908032606.25312.86849.stgit@localhost.localdomain>
Message-ID: <20160908032811.25312.38792.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

The maximum queue count reported was 1, however support for multiple queues
with SR-IOV was added some time ago so we should report support for it to
the user so that they can select multiple queues if they so desire.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 730a99f0f002..2d872be336bb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3060,8 +3060,8 @@ static unsigned int ixgbe_max_channels(struct ixgbe_adapter *adapter)
 		/* We only support one q_vector without MSI-X */
 		max_combined = 1;
 	} else if (adapter->flags & IXGBE_FLAG_SRIOV_ENABLED) {
-		/* SR-IOV currently only allows one queue on the PF */
-		max_combined = 1;
+		/* Limit value based on the queue mask */
+		max_combined = adapter->ring_feature[RING_F_RSS].mask + 1;
 	} else if (tcs > 1) {
 		/* For DCB report channels per traffic class */
 		if (adapter->hw.mac.type == ixgbe_mac_82598EB) {

