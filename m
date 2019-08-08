From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  8 Aug 2019 07:39:29 -0700
Subject: [Intel-wired-lan] [PATCH S27 06/15] ice: Remove enable DCB when SW
 LLDP is activated
In-Reply-To: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
References: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
Message-ID: <20190808143938.4968-6-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Michal Swiatkowski <michal.swiatkowski@intel.com>

Remove code that enables DCB in initialization when SW LLDP is
activated. DCB flag is set or reset before in ice_init_pf_dcb
based on number of TCs. So there is not need to overwrite it.

Setting DCB without checking number of TCs can cause communication
problems with other cards. Host card sends packet with VLAN priority
tag, but client card doesn't strip this tag and ping doesn't work.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index eb1077450e5b..cc94afbefced 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -480,7 +480,6 @@ int ice_init_pf_dcb(struct ice_pf *pf, bool locked)
 
 		pf->dcbx_cap = DCB_CAP_DCBX_HOST | DCB_CAP_DCBX_VER_IEEE;
 		set_bit(ICE_FLAG_DCB_CAPABLE, pf->flags);
-		set_bit(ICE_FLAG_DCB_ENA, pf->flags);
 		return 0;
 	}
 
-- 
2.20.1

