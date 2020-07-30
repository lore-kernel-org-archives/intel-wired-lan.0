From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 29 Jul 2020 17:19:19 -0700
Subject: [Intel-wired-lan] [PATCH S51 10/13] ice: Disable VLAN pruning in
 promiscuous mode
In-Reply-To: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
References: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
Message-ID: <20200730001922.52568-10-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Nick Nunley <nicholas.d.nunley@intel.com>

Disable VLAN pruning when entering promiscuous mode, and re-enable it
when exiting.

Without this VLAN-over-bridge topologies created on the device won't be
functional unless rx-vlan-filter is explicitly disabled with ethtool.

Signed-off-by: Nick Nunley <nicholas.d.nunley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c  | 7 +++++++
 drivers/net/ethernet/intel/ice/ice_main.c | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 84202c814c3b..f2682776f8c8 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2017,6 +2017,13 @@ int ice_cfg_vlan_pruning(struct ice_vsi *vsi, bool ena, bool vlan_promisc)
 	if (!vsi)
 		return -EINVAL;
 
+	/* Don't enable VLAN pruning if the netdev is currently in promiscuous
+	 * mode. VLAN pruning will be enabled when the interface exits
+	 * promiscuous mode if any VLAN filters are active.
+	 */
+	if (vsi->netdev && vsi->netdev->flags & IFF_PROMISC && ena)
+		return 0;
+
 	pf = vsi->back;
 	ctxt = kzalloc(sizeof(*ctxt), GFP_KERNEL);
 	if (!ctxt)
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 22bbd84eef64..22e3d32463f1 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -369,6 +369,7 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
 						~IFF_PROMISC;
 					goto out_promisc;
 				}
+				ice_cfg_vlan_pruning(vsi, false, false);
 			}
 		} else {
 			/* Clear Rx filter to remove traffic from wire */
@@ -381,6 +382,8 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
 						IFF_PROMISC;
 					goto out_promisc;
 				}
+				if (vsi->num_vlan > 1)
+					ice_cfg_vlan_pruning(vsi, true, false);
 			}
 		}
 	}
-- 
2.20.1

