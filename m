From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 16 Apr 2015 20:06:04 -0400
Subject: [Intel-wired-lan]  [net-next S4 07/15] i40evf: restore state
In-Reply-To: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
References: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1429229172-143692-8-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

If the netdev is closed when a reset occurs, the adapter state will be
left in the RESETTING state incorrectly. Correct this deficiency.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: Ia0c5bf0449f7c81609f6f646e6b805f030d3360d
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 7c53aca..37e66ec 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1624,7 +1624,8 @@ continue_reset:
 			goto reset_err;
 
 		i40evf_irq_enable(adapter, true);
-	}
+	} else
+		adapter->state = __I40EVF_DOWN;
 	return;
 reset_err:
 	dev_err(&adapter->pdev->dev, "failed to allocate resources during reinit\n");
-- 
1.9.3

