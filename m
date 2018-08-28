From: Alice Michael <alice.michael@intel.com>
Date: Tue, 28 Aug 2018 10:16:06 -0700
Subject: [Intel-wired-lan] [next PATCH S96 6/9] i40e: fix double 'NIC Link
 is Down' messages
In-Reply-To: <20180828171609.78242-1-alice.michael@intel.com>
References: <20180828171609.78242-1-alice.michael@intel.com>
Message-ID: <20180828171609.78242-6-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sergey Nemov <sergey.nemov@intel.com>

When isup is false meaning that interface is going to shut down
set new speed to 0 to avoid double 'NIC Link is Down' messages.

Signed-off-by: Sergey Nemov <sergey.nemov@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 6ce695f..b57c1ea 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6437,7 +6437,10 @@ void i40e_print_link_message(struct i40e_vsi *vsi, bool isup)
 	char *req_fec = "";
 	char *an = "";
 
-	new_speed = pf->hw.phy.link_info.link_speed;
+	if (isup)
+		new_speed = pf->hw.phy.link_info.link_speed;
+	else
+		new_speed = I40E_LINK_SPEED_UNKNOWN;
 
 	if ((vsi->current_isup == isup) && (vsi->current_speed == new_speed))
 		return;
-- 
2.9.5

