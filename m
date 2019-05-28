From: Alice Michael <alice.michael@intel.com>
Date: Tue, 28 May 2019 10:59:18 -0700
Subject: [Intel-wired-lan] [next PATCH S6 4/7] i40e: Add log entry while
 creating or deleting TC0
In-Reply-To: <20190528175921.30534-1-alice.michael@intel.com>
References: <20190528175921.30534-1-alice.michael@intel.com>
Message-ID: <20190528175921.30534-4-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Generate log entry when TC0 is created or deleted.
Log entry is generated during main VSI setup.
Before there was no log info about adding or deleting TC0.

Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 931862c0f39d..7c93f28b7b1d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7432,6 +7432,10 @@ static int i40e_setup_tc(struct net_device *netdev, void *type_data)
 			    vsi->seid);
 		need_reset = true;
 		goto exit;
+	} else {
+		dev_info(&vsi->back->pdev->dev,
+			 "Setup channel (id:%u) utilizing num_queues %d\n",
+			 vsi->seid, vsi->tc_config.tc_info[0].qcount);
 	}
 
 	if (pf->flags & I40E_FLAG_TC_MQPRIO) {
-- 
2.19.2

