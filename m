From: Avinash Dayanand <avinash.dayanand@intel.com>
Date: Fri, 18 Mar 2016 12:18:10 -0700
Subject: [Intel-wired-lan] [next PATCH S31 v4 06/12] i40evf: Add longer wait
	after remove module
In-Reply-To: <1458328696-135941-1-git-send-email-avinash.dayanand@intel.com>
References: <1458328696-135941-1-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1458328696-135941-7-git-send-email-avinash.dayanand@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Upon module remove, wait a little longer after requesting a reset before
checking to see if the firmware responded. This change prevents double
resets when the firmware is busy.

Testing Hints: Load and unload VF driver repeatedly
with a lot of VFs enabled and make sure it reinitializes properly each
time.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: Ieedc988ee82fac1f32a074bf4d9e4dba426bfa58
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 0c99974..8598c5f 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2854,11 +2854,11 @@ static void i40evf_remove(struct pci_dev *pdev)
 	adapter->state = __I40EVF_REMOVE;
 	adapter->aq_required = 0;
 	i40evf_request_reset(adapter);
-	msleep(20);
+	msleep(50);
 	/* If the FW isn't responding, kick it once, but only once. */
 	if (!i40evf_asq_done(hw)) {
 		i40evf_request_reset(adapter);
-		msleep(20);
+		msleep(50);
 	}
 
 	if (adapter->msix_entries) {
-- 
2.4.3

