From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed,  2 Sep 2020 08:53:44 -0700
Subject: [Intel-wired-lan] [net 3/6] ice: report correct max number of TCs
In-Reply-To: <20200902155347.16972-1-anthony.l.nguyen@intel.com>
References: <20200902155347.16972-1-anthony.l.nguyen@intel.com>
Message-ID: <20200902155347.16972-3-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dave Ertman <david.m.ertman@intel.com>

In the driver currently, we are reporting max number of TCs
to the DCBNL callback as a kernel define set to 8.  This is
preventing userspace applications performing DCBx to correctly
down map the TCs from requested to actual values.

Report the actual max TC value to userspace from the capability
struct.

Fixes: b94b013eb626 ("ice: Implement DCBNL support")
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
index 87f91b750d59..842d44b63480 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
@@ -136,7 +136,7 @@ ice_dcbnl_getnumtcs(struct net_device *dev, int __always_unused tcid, u8 *num)
 	if (!test_bit(ICE_FLAG_DCB_CAPABLE, pf->flags))
 		return -EINVAL;
 
-	*num = IEEE_8021QAZ_MAX_TCS;
+	*num = pf->hw.func_caps.common_cap.maxtc;
 	return 0;
 }
 
-- 
2.20.1

