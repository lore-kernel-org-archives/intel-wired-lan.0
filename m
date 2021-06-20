From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sun, 20 Jun 2021 15:28:06 +0200
Subject: [Intel-wired-lan] [PATCH] ice: Fix a memory leak in an error
 handling path in 'ice_pf_dcb_cfg()'
Message-ID: <0302ff0ced7f38b0076c08ce351477d338bbe548.1624195601.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If this 'kzalloc()' fails we must free some resources as in all the other
error handling paths of this function.

Fixes: 348048e724a0 ("ice: Implement iidc operations")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
'event' is allocated and freed just a few lines below. It looks like a
small structure, so maybe a better fix would be to avoid the
kzalloc/kfree and use a local variable instead.
Another solution
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index 857dc62da7a8..926cf748c5ec 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -316,8 +316,10 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg, bool locked)
 
 	/* Notify AUX drivers about impending change to TCs */
 	event = kzalloc(sizeof(*event), GFP_KERNEL);
-	if (!event)
-		return -ENOMEM;
+	if (!event) {
+		ret = -ENOMEM;
+		goto free_cfg;
+	}
 
 	set_bit(IIDC_EVENT_BEFORE_TC_CHANGE, event->type);
 	ice_send_event_to_aux(pf, event);
-- 
2.30.2

