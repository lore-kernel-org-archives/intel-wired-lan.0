From: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
Date: Tue,  6 Aug 2019 10:38:26 -0300
Subject: [Intel-wired-lan] [PATCH] i40e: Remove EMPR traces from debugfs
 facility
Message-ID: <20190806133826.18480-1-maurosr@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Since commit
'5098850c9b9b ("i40e/i40evf: i40e_register.h updates")'
it is no longer possible to trigger an EMP Reset from debugfs, but it's
possible to request it either way, to end up with a bad reset request:

echo empr > /sys/kernel/debug/i40e/0002\:01\:00.1/command
i40e 0002:01:00.1: debugfs: forcing EMPR
i40e 0002:01:00.1: bad reset request 0x00010000

So let's remove this piece of code and show the available valid commands
as it is when any invalid command is issued.

Signed-off-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h         | 1 -
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 84bd06901014..6ec0e1bc05e6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -131,7 +131,6 @@ enum i40e_state_t {
 	__I40E_PF_RESET_REQUESTED,
 	__I40E_CORE_RESET_REQUESTED,
 	__I40E_GLOBAL_RESET_REQUESTED,
-	__I40E_EMP_RESET_REQUESTED,
 	__I40E_EMP_RESET_INTR_RECEIVED,
 	__I40E_SUSPENDED,
 	__I40E_PTP_TX_IN_PROGRESS,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 55d20acfcf70..48fdf16c6019 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -1125,10 +1125,6 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
 		dev_info(&pf->pdev->dev, "debugfs: forcing GlobR\n");
 		i40e_do_reset_safe(pf, BIT(__I40E_GLOBAL_RESET_REQUESTED));
 
-	} else if (strncmp(cmd_buf, "empr", 4) == 0) {
-		dev_info(&pf->pdev->dev, "debugfs: forcing EMPR\n");
-		i40e_do_reset_safe(pf, BIT(__I40E_EMP_RESET_REQUESTED));
-
 	} else if (strncmp(cmd_buf, "read", 4) == 0) {
 		u32 address;
 		u32 value;
-- 
2.21.0

