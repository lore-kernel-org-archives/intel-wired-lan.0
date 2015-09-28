From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 28 Sep 2015 14:16:50 -0400
Subject: [Intel-wired-lan] [next PATCH S17 01/11] i40evf: don't give up
In-Reply-To: <1443464220-148318-1-git-send-email-catherine.sullivan@intel.com>
References: <1443464220-148318-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1443464220-148318-2-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

When the VF driver is unable to communicate with the PF, it just gives
up and never tries again. Aside from the obvious character flaw that
this shows, it's also a lousy user experience.

When PF communications fail, wait five seconds, and try again. And
again. Don't give up, little VF driver! Your prince will come!

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: Ia1378a39879883563b8faffce819f375821f9585
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 2575473..d29519d 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2357,9 +2357,12 @@ err_alloc:
 err:
 	/* Things went into the weeds, so try again later */
 	if (++adapter->aq_wait_count > I40EVF_AQ_MAX_ERR) {
-		dev_err(&pdev->dev, "Failed to communicate with PF; giving up\n");
+		dev_err(&pdev->dev, "Failed to communicate with PF; waiting before retry\n");
 		adapter->flags |= I40EVF_FLAG_PF_COMMS_FAILED;
-		return; /* do not reschedule */
+		i40evf_shutdown_adminq(hw);
+		adapter->state = __I40EVF_STARTUP;
+		schedule_delayed_work(&adapter->init_task, HZ * 5);
+		return;
 	}
 	schedule_delayed_work(&adapter->init_task, HZ);
 }
-- 
1.9.3

