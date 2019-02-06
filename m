From: Alice Michael <alice.michael@intel.com>
Date: Wed,  6 Feb 2019 15:08:15 -0800
Subject: [Intel-wired-lan] [next PATCH S2-V2 01/12] i40e: Queues are
 reserved despite "Invalid argument" error.
Message-ID: <20190206230826.24970-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Adam Ludkiewicz <adam.ludkiewicz@intel.com>

Added a new local variable in the i40e_setup_tc function named
old_queue_pairs so num_queue_pairs can be restored to the correct
value in case configuring queue channels fails. Additionally, moved
the exit label in the i40e_setup_tc function so the if (need_reset)
block can be executed.
Also, fixed data packing in the i40e_setup_tc function.

Signed-off-by: Adam Ludkiewicz <adam.ludkiewicz@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e53b7b89ef1d..9b315230a0d6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7290,10 +7290,12 @@ static int i40e_setup_tc(struct net_device *netdev, void *type_data)
 	struct i40e_pf *pf = vsi->back;
 	u8 enabled_tc = 0, num_tc, hw;
 	bool need_reset = false;
+	int old_queue_pairs;
 	int ret = -EINVAL;
 	u16 mode;
 	int i;
 
+	old_queue_pairs = vsi->num_queue_pairs;
 	num_tc = mqprio_qopt->qopt.num_tc;
 	hw = mqprio_qopt->qopt.hw;
 	mode = mqprio_qopt->mode;
@@ -7394,6 +7396,7 @@ static int i40e_setup_tc(struct net_device *netdev, void *type_data)
 		}
 		ret = i40e_configure_queue_channels(vsi);
 		if (ret) {
+			vsi->num_queue_pairs = old_queue_pairs;
 			netdev_info(netdev,
 				    "Failed configuring queue channels\n");
 			need_reset = true;
-- 
2.19.2

