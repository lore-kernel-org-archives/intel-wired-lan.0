From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 19 Aug 2021 12:29:58 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2 2/3] ice-linux: fix rate limit
 update after coalesce change
In-Reply-To: <20210819192959.590146-1-jesse.brandeburg@intel.com>
References: <20210819192959.590146-1-jesse.brandeburg@intel.com>
Message-ID: <20210819192959.590146-3-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If the adaptive settings are changed with
ethtool -C ethx adaptive-rx off adaptive-tx off
then the interrupt rate limit should be maintained as a user set
value, but only if BOTH adaptive settings are off. Fix a bug
where the rate limit that was being used in adaptive mode was
staying set in the register but was not reported correctly by
ethtool -c ethx.

Fixes: b8b4772377dd ("ice: refactor interrupt moderation writes")
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 9 +++++----
 drivers/net/ethernet/intel/ice/ice_lib.c     | 4 ++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 54ccba8992ee..d5777a8cd779 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3657,11 +3657,8 @@ ice_set_rc_coalesce(enum ice_container_type c_type, struct ethtool_coalesce *ec,
 				    c_type_str);
 			return -EINVAL;
 		}
-		if (ec->rx_coalesce_usecs_high != rc->ring->q_vector->intrl) {
+		if (ec->rx_coalesce_usecs_high != rc->ring->q_vector->intrl)
 			rc->ring->q_vector->intrl = ec->rx_coalesce_usecs_high;
-			ice_write_intrl(rc->ring->q_vector,
-					ec->rx_coalesce_usecs_high);
-		}
 
 		use_adaptive_coalesce = ec->use_adaptive_rx_coalesce;
 		coalesce_usecs = ec->rx_coalesce_usecs;
@@ -3811,6 +3808,8 @@ __ice_set_coalesce(struct net_device *netdev, struct ethtool_coalesce *ec,
 
 			if (ice_set_q_coalesce(vsi, ec, v_idx))
 				return -EINVAL;
+
+			ice_set_q_vector_intrl(vsi->q_vectors[v_idx]);
 		}
 		goto set_complete;
 	}
@@ -3818,6 +3817,8 @@ __ice_set_coalesce(struct net_device *netdev, struct ethtool_coalesce *ec,
 	if (ice_set_q_coalesce(vsi, ec, q_num))
 		return -EINVAL;
 
+	ice_set_q_vector_intrl(vsi->q_vectors[q_num]);
+
 set_complete:
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index b71ca3e7ea19..69760bcf2bd3 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3109,7 +3109,7 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi *vsi,
 		}
 
 		vsi->q_vectors[i]->intrl = coalesce[i].intrl;
-		ice_write_intrl(vsi->q_vectors[i], coalesce[i].intrl);
+		ice_set_q_vector_intrl(vsi->q_vectors[i]);
 	}
 
 	/* the number of queue vectors increased so write whatever is in
@@ -3127,7 +3127,7 @@ ice_vsi_rebuild_set_coalesce(struct ice_vsi *vsi,
 		ice_write_itr(rc, rc->itr_setting);
 
 		vsi->q_vectors[i]->intrl = coalesce[0].intrl;
-		ice_write_intrl(vsi->q_vectors[i], coalesce[0].intrl);
+		ice_set_q_vector_intrl(vsi->q_vectors[i]);
 	}
 }
 
-- 
2.31.1

