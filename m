From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Date: Fri, 21 May 2021 18:41:26 +0200
Subject: [Intel-wired-lan] [PATCH net] i40e: Fix firmware LLDP agent related
 warning
Message-ID: <20210521164126.220183-1-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Make warning meaningful for the user.

Previously the trace:
"Starting FW LLDP agent failed: error: I40E_ERR_ADMIN_QUEUE_ERROR, I40E_AQ_RC_EAGAIN"
was produced when user tried to start Firmware LLDP agent,
just after it was stopped with sequence:
ethtool --set-priv-flags <dev> disable-fw-lldp on
ethtool --set-priv-flags <dev> disable-fw-lldp off
(without any delay between the commands)
At that point the firmware is still processing stop command, the behavior
is expected.

Fixes: c1041d070437 ("i40e: Missing response checks in driver when starting/stopping FW LLDP")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 3e822ba..d9e26f9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -5294,6 +5294,10 @@ flags_complete:
 					dev_warn(&pf->pdev->dev,
 						 "Device configuration forbids SW from starting the LLDP agent.\n");
 					return -EINVAL;
+				case I40E_AQ_RC_EAGAIN:
+					dev_warn(&pf->pdev->dev,
+						 "Stop FW LLDP agent command is still being processed, please try again in a second.\n");
+					return -EBUSY;
 				default:
 					dev_warn(&pf->pdev->dev,
 						 "Starting FW LLDP agent failed: error: %s, %s\n",

base-commit: 776a417daec6a28fdf89426ea98126f8a03c79a1
-- 
2.26.0

