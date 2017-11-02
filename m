From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 02 Nov 2017 16:33:45 -0700
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 2/5] fm10k: Fix VLAN
 configuration for macvlan offload
In-Reply-To: <20171102232857.15146.21583.stgit@localhost.localdomain>
References: <20171102232857.15146.21583.stgit@localhost.localdomain>
Message-ID: <20171102233336.15146.31137.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

The fm10k driver didn't work correctly when macvlan offload was enabled.
Specifically what would occur is that we would see no unicast packets being
received. This was traced down to us not correctly configuring the default
VLAN ID for the port and defaulting to 0.

To correct this we either use the default ID provided by the switch or
simply use 1. With that we are able to pass and receive traffic without any
issues.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 81e4425f0529..1280127077de 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -1490,7 +1490,7 @@ static void *fm10k_dfwd_add_station(struct net_device *dev,
 		hw->mac.ops.update_xcast_mode(hw, glort,
 					      FM10K_XCAST_MODE_MULTI);
 		fm10k_queue_mac_request(interface, glort, sdev->dev_addr,
-					0, true);
+					hw->mac.default_vid ? : 1, true);
 	}
 
 	fm10k_mbx_unlock(interface);
@@ -1530,7 +1530,7 @@ static void fm10k_dfwd_del_station(struct net_device *dev, void *priv)
 		hw->mac.ops.update_xcast_mode(hw, glort,
 					      FM10K_XCAST_MODE_NONE);
 		fm10k_queue_mac_request(interface, glort, sdev->dev_addr,
-					0, false);
+					hw->mac.default_vid ? : 1, false);
 	}
 
 	fm10k_mbx_unlock(interface);

