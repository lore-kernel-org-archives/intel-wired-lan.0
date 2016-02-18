From: Avinash Dayanand <avinash.dayanand@intel.com>
Date: Wed, 17 Feb 2016 16:12:16 -0800
Subject: [Intel-wired-lan] [next PATCH S29 06/14] i40e: Fix for unexpected
	messaging
In-Reply-To: <1455754344-6372-1-git-send-email-avinash.dayanand@intel.com>
References: <1455754344-6372-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1455754344-6372-7-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Carolyn Wyborny <carolyn.wyborny@intel.com>

This fixes an issue where a previously removed message
has returned.  Changing the message type to dev_dbg
leaves the info, if desired, but takes it out of normal
everyday usage. Also changed call to only provide port
data when its valid and not when its not (delete case).

Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
Change-ID: Ief6f33b915f6364c24fa8e5789c2fc3168b5e2ed
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 3c658a29..2a02f93 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7105,12 +7105,13 @@ static void i40e_sync_udp_filters_subtask(struct i40e_pf *pf)
 				ret = i40e_aq_del_udp_tunnel(hw, i, NULL);
 
 			if (ret) {
-				dev_info(&pf->pdev->dev,
-					 "%s vxlan port %d, index %d failed, err %s aq_err %s\n",
-					 port ? "add" : "delete",
-					 ntohs(port), i,
-					 i40e_stat_str(&pf->hw, ret),
-					 i40e_aq_str(&pf->hw,
+				dev_dbg(&pf->pdev->dev,
+					"%s %s port %d, index %d failed, err %s aq_err %s\n",
+					pf->udp_ports[i].type ? "vxlan" : "geneve",
+					port ? "add" : "delete",
+					ntohs(port), i,
+					i40e_stat_str(&pf->hw, ret),
+					i40e_aq_str(&pf->hw,
 						    pf->hw.aq.asq_last_status));
 				pf->udp_ports[i].index = 0;
 			}
-- 
2.1.0

