From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 22 Jan 2021 14:44:49 -0800
Subject: [Intel-wired-lan] [PATCH net-next v3 4/8] igc: Only dump registers
 if configured to dump HW information
In-Reply-To: <20210122224453.4161729-1-vinicius.gomes@intel.com>
References: <20210122224453.4161729-1-vinicius.gomes@intel.com>
Message-ID: <20210122224453.4161729-5-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

To avoid polluting the users logs with register dumps, only dump the
adapter's registers if configured to do so.

If users want to enable HW status messages they can do:

$ ethtool -s IFACE msglvl hw on

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_dump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_dump.c b/drivers/net/ethernet/intel/igc/igc_dump.c
index 4b9ec7d0b727..90b754b429ff 100644
--- a/drivers/net/ethernet/intel/igc/igc_dump.c
+++ b/drivers/net/ethernet/intel/igc/igc_dump.c
@@ -308,6 +308,9 @@ void igc_regs_dump(struct igc_adapter *adapter)
 	struct igc_hw *hw = &adapter->hw;
 	struct igc_reg_info *reginfo;
 
+	if (!netif_msg_hw(adapter))
+		return;
+
 	/* Print Registers */
 	netdev_info(adapter->netdev, "Register Dump\n");
 	netdev_info(adapter->netdev, "Register Name   Value\n");
-- 
2.30.0

