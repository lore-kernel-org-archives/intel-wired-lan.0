From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Mon,  4 Jan 2016 10:33:02 -0800
Subject: [Intel-wired-lan] [next PATCH S26 02/12] i40e: trivial: fix missing
	space
In-Reply-To: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
References: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1451932392-15538-3-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Missing space in comment, fixed.

Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: I8cdf3ce5994b4a97dcc3eeb33422533918546667
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 766a887..cbbe2f9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3754,7 +3754,7 @@ static int i40e_vsi_request_irq(struct i40e_vsi *vsi, char *basename)
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
 /**
- * i40e_netpoll - A Polling 'interrupt'handler
+ * i40e_netpoll - A Polling 'interrupt' handler
  * @netdev: network interface device structure
  *
  * This is used by netconsole to send skbs without having to re-enable
-- 
2.1.0

