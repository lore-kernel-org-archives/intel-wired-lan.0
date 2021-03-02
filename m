From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue,  2 Mar 2021 10:15:44 -0800
Subject: [Intel-wired-lan] [PATCH S56 12/13] ice: Remove unnecessary blank
 line
In-Reply-To: <20210302181545.51822-1-anthony.l.nguyen@intel.com>
References: <20210302181545.51822-1-anthony.l.nguyen@intel.com>
Message-ID: <20210302181545.51822-12-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Checkpatch reports the following, fix it.

-----------------------------------------
drivers/net/ethernet/intel/ice/ice_main.c
-----------------------------------------
CHECK:BRACES: Blank lines aren't necessary before a close brace '}'
FILE: drivers/net/ethernet/intel/ice/ice_main.c:455:
+
+}

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 4f35a4de33ab..f243668b8956 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -451,7 +451,6 @@ static void ice_pf_dis_all_vsi(struct ice_pf *pf, bool locked)
 
 	for (node = 0; node < ICE_MAX_VF_AGG_NODES; node++)
 		pf->vf_agg_node[node].num_vsis = 0;
-
 }
 
 /**
-- 
2.20.1

