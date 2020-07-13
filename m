From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 13 Jul 2020 13:53:05 -0700
Subject: [Intel-wired-lan] [PATCH S50 02/15] ice: Fix link broken after
 GLOBR reset
In-Reply-To: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
References: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
Message-ID: <20200713205318.32425-2-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dave Ertman <david.m.ertman@intel.com>

After a GLOBR, the link was broken so that a link
up situation was being seen as a link down.

The problem was that the rebuild process was updating
the port_info link status without doing any of the
other things that need to be done when link changes.

This was causing the port_info struct to have current
"UP" information so that any further UP interrupts
were skipped as redundant.

The rebuild flow should *not* be updating the port_info
struct link information, so eliminate this and leave
it to the link event handling code.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 3024fff6ca1d..6b5185a0aa04 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5768,10 +5768,6 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 	if (err)
 		goto err_sched_init_port;
 
-	err = ice_update_link_info(hw->port_info);
-	if (err)
-		dev_err(dev, "Get link status error %d\n", err);
-
 	/* start misc vector */
 	err = ice_req_irq_msix_misc(pf);
 	if (err) {
-- 
2.20.1

