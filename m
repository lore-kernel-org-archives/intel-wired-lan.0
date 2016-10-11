From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue, 11 Oct 2016 15:26:56 -0700
Subject: [Intel-wired-lan] [next PATCH S50 4/6] i40e: Fix for division by
	zero
In-Reply-To: <1476224818-16844-1-git-send-email-bimmy.pujari@intel.com>
References: <1476224818-16844-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1476224818-16844-5-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Michal Kosiarz <michal.kosiarz@intel.com>

For some cases when reading from device are incorrect or image is
incorrect, this part of code causes crash due to division by zero.

Signed-off-by: Michal Kosiarz <michal.kosiarz@intel.com>
Change-ID: I8961029a7a87b0a479995823ef8fcbf6471405e1
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index a475946..98791ba 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -3313,8 +3313,10 @@ static void i40e_parse_discover_capabilities(struct i40e_hw *hw, void *buff,
 	/* partition id is 1-based, and functions are evenly spread
 	 * across the ports as partitions
 	 */
-	hw->partition_id = (hw->pf_id / hw->num_ports) + 1;
-	hw->num_partitions = num_functions / hw->num_ports;
+	if (hw->num_ports != 0) {
+		hw->partition_id = (hw->pf_id / hw->num_ports) + 1;
+		hw->num_partitions = num_functions / hw->num_ports;
+	}
 
 	/* additional HW specific goodies that might
 	 * someday be HW version specific
-- 
2.4.11

