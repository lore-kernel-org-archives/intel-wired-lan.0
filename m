From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri, 26 Oct 2018 11:44:43 -0700
Subject: [Intel-wired-lan] [PATCH S9 11/15] ice: Fix return value from NAPI
 poll
In-Reply-To: <20181026184447.13547-1-anirudh.venkataramanan@intel.com>
References: <20181026184447.13547-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181026184447.13547-12-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dave Ertman <david.m.ertman@intel.com>

ice_napi_poll is hard-coded to return zero when it's done. It should
instead return the work done (if any work was done). The only time it
should return zero is if an interrupt or poll is handled and no work
is performed. So change the return value to be the minimum of work
done or budget-1.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index fe5bbabbb41e..99954089a7fb 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1107,7 +1107,8 @@ int ice_napi_poll(struct napi_struct *napi, int budget)
 	napi_complete_done(napi, work_done);
 	if (test_bit(ICE_FLAG_MSIX_ENA, pf->flags))
 		ice_irq_dynamic_ena(&vsi->back->hw, vsi, q_vector);
-	return 0;
+
+	return min(work_done, budget - 1);
 }
 
 /* helper function for building cmd/type/offset */
-- 
2.14.3

