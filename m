From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  7 May 2020 17:41:10 -0700
Subject: [Intel-wired-lan] [PATCH S41 12/15] ice: remove unnecessary
 expression that is always true
In-Reply-To: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
References: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
Message-ID: <20200508004113.39725-12-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

The else conditional expression is always true due to the if conditional
expression; remove it and add a comment to make it obvious still.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 5eca66849e52..d9ffa48b3dd4 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -347,7 +347,8 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
 				vsi->current_netdev_flags &= ~IFF_ALLMULTI;
 				goto out_promisc;
 			}
-		} else if (!(vsi->current_netdev_flags & IFF_ALLMULTI)) {
+		} else {
+			/* !(vsi->current_netdev_flags & IFF_ALLMULTI) */
 			if (vsi->vlan_ena)
 				promisc_m = ICE_MCAST_VLAN_PROMISC_BITS;
 			else
-- 
2.20.1

