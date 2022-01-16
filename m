From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sun, 16 Jan 2022 19:46:20 +0100
Subject: [Intel-wired-lan] [PATCH] ice: Don't use GFP_KERNEL in atomic
 context
Message-ID: <40c94af2f9140794351593047abc95ca65e4e576.1642358759.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ice_misc_intr() is an irq handler. It should not sleep.

Use GFP_ATOMIC instead of GFP_KERNEL when allocating some memory.

Fixes: 348048e724a0 ("ice: Implement iidc operations")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
I've never played a lot with irq handler. My understanding is that they
should never sleep. So GFP_KERNEL must be avoided. So I guess that this
patch is correct.

However, I don't know if some special cases allow such allocation.
Any feedback/pointer to a good doc/explanation is welcome :)
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 30814435f779..65de01f3a504 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3018,7 +3018,7 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 		struct iidc_event *event;
 
 		ena_mask &= ~ICE_AUX_CRIT_ERR;
-		event = kzalloc(sizeof(*event), GFP_KERNEL);
+		event = kzalloc(sizeof(*event), GFP_ATOMIC);
 		if (event) {
 			set_bit(IIDC_EVENT_CRIT_ERR, event->type);
 			/* report the entire OICR value to AUX driver */
-- 
2.32.0

