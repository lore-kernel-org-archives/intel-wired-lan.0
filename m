From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue, 21 Feb 2017 15:55:44 -0800
Subject: [Intel-wired-lan] [next PATCH S61 06/10] i40e: fix for queue timing
	delays
In-Reply-To: <1487721348-25617-1-git-send-email-bimmy.pujari@intel.com>
References: <1487721348-25617-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1487721348-25617-7-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Carolyn Wyborny <carolyn.wyborny@intel.com>

This patch adds a delay to rx queue disables to accommodate hw needs.

Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
Change-ID: I2864ca667ce5dcc2cc44f8718113b719742a46a1
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index db09914..9426174 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4306,6 +4306,8 @@ static int i40e_vsi_control_rx(struct i40e_vsi *vsi, bool enable)
 		}
 	}
 
+	/* HW needs up to 50ms to finish RX queue disable*/
+	mdelay(50);
 	return ret;
 }
 
-- 
2.4.11

