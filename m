From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Wed, 24 Aug 2016 11:33:51 -0700
Subject: [Intel-wired-lan] [next PATCH S44 6/6] i40e: Fix for extra byte
	swap in tunnel setup
In-Reply-To: <1472063631-9033-1-git-send-email-bimmy.pujari@intel.com>
References: <1472063631-9033-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1472063631-9033-7-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Carolyn Wyborny <carolyn.wyborny@intel.com>

This patch fixes an issue where we were byte swapping the port
parameter, then byte swapping it again in function execution.
Obviously, that's unnecessary, so take it out of the function calls.
Without this patch, the udp based tunnel configuration would
not be correct.

Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
Change-ID: I788d83c5bd5732170f1a81dbfa0b1ac3ca8ea5b7
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 47cf91c..68c1253 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7138,9 +7138,9 @@ static void i40e_sync_udp_filters_subtask(struct i40e_pf *pf)
 			pf->pending_udp_bitmap &= ~BIT_ULL(i);
 			port = pf->udp_ports[i].index;
 			if (port)
-				ret = i40e_aq_add_udp_tunnel(hw, ntohs(port),
-						     pf->udp_ports[i].type,
-						     NULL, NULL);
+				ret = i40e_aq_add_udp_tunnel(hw, port,
+							pf->udp_ports[i].type,
+							NULL, NULL);
 			else
 				ret = i40e_aq_del_udp_tunnel(hw, i, NULL);
 
-- 
2.4.11

