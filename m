From: Carolyn Wyborny <carolyn.wyborny@intel.com>
Date: Mon, 27 Mar 2017 16:08:38 -0700
Subject: [Intel-wired-lan] [net-next PATCH v2] i40e: fix for queue timing
	delays
Message-ID: <149065607626.40396.2636551099104046268.stgit@cmw-ivy.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds a delay to rx queue disables to accommodate hw needs.

v2: Added missing check for disable only, additional details on the need for
the ugly delay and fixed spacing on comment.

Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
Change-ID: I2864ca667ce5dcc2cc44f8718113b719742a46a1
---
 drivers/net/ethernet/intel/i40e/i40e_main.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4b32b47..6ae779b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4181,6 +4181,11 @@ static int i40e_vsi_control_rx(struct i40e_vsi *vsi, bool enable)
 		}
 	}
 
+	/* Due to HW errata, on Rx disable only, the register can indicate done
+	 * before it really is. Needs 50ms to be sure */
+	if (!enable)
+		mdelay(50);
+
 	return ret;
 }
 

