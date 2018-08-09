From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu,  9 Aug 2018 06:28:52 -0700
Subject: [Intel-wired-lan] [PATCH v4 02/13] ice: Remove unncessary node
 owner check
In-Reply-To: <20180809132903.22819-1-anirudh.venkataramanan@intel.com>
References: <20180809132903.22819-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180809132903.22819-3-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

There is already a check for owner == ICE_SCHED_NODE_OWNER_LAN at the
beginning of ice_sched_update_vsi_child_nodes. Remove the additional
check to address the static anlaysis tool smatch issue "warn: we tested
'owner' before and it was 'false'".

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
--
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> rewrote commit message]
---
 drivers/net/ethernet/intel/ice/ice_sched.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index 2e6c1d92cc88..eeae199469b6 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -1576,8 +1576,7 @@ ice_sched_update_vsi_child_nodes(struct ice_port_info *pi, u16 vsi_id, u8 tc,
 			return status;
 	}
 
-	if (owner == ICE_SCHED_NODE_OWNER_LAN)
-		vsi->max_lanq[tc] = new_numqs;
+	vsi->max_lanq[tc] = new_numqs;
 
 	return status;
 }
-- 
2.17.1

