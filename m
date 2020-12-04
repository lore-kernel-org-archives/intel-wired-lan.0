From: Mario Limonciello <mario.limonciello@dell.com>
Date: Fri,  4 Dec 2020 14:09:20 -0600
Subject: [Intel-wired-lan] [PATCH v3 7/7] e1000e: Add another Dell TGL
 notebook system into S0ix heuristics
In-Reply-To: <20201204200920.133780-1-mario.limonciello@dell.com>
References: <20201204200920.133780-1-mario.limonciello@dell.com>
Message-ID: <20201204200920.133780-8-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This Tiger Lake system is not yet released, but has been validated
on pre-release hardware.

This is being submitted separately from released hardware in case of
a regression between pre-release and release hardware so this commit
can be reverted alone.

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 drivers/net/ethernet/intel/e1000e/s0ix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/e1000e/s0ix.c b/drivers/net/ethernet/intel/e1000e/s0ix.c
index cc04aeaa2292..3f2985fac67c 100644
--- a/drivers/net/ethernet/intel/e1000e/s0ix.c
+++ b/drivers/net/ethernet/intel/e1000e/s0ix.c
@@ -63,6 +63,7 @@ static bool e1000e_check_subsystem_allowlist(struct pci_dev *dev)
 		case 0x0a40: /* Notebook 0x0a40 */
 		case 0x0a41: /* Notebook 0x0a41 */
 		case 0x0a42: /* Notebook 0x0a42 */
+		case 0x0a22: /* Notebook 0x0a22 */
 		case 0x0a2e: /* Desktop  0x0a2e */
 		case 0x0a30: /* Desktop  0x0a30 */
 			return true;
-- 
2.25.1

