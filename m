From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 23 Jul 2015 16:54:43 -0400
Subject: [Intel-wired-lan] [next PATCH S9 14/15] i40evf: tighten up reset
	polling
In-Reply-To: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
References: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1437684884-222825-15-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Poll longer and more often for reset completion. This helps the driver
to recover more quickly and more reliably when a reset occurs.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: I27b6b5c9a79c1892f0ba453129f116bc32647dd0
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 4dccc0b..588cacf 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1478,8 +1478,8 @@ restart_watchdog:
 	schedule_work(&adapter->adminq_task);
 }
 
-#define I40EVF_RESET_WAIT_MS 100
-#define I40EVF_RESET_WAIT_COUNT 200
+#define I40EVF_RESET_WAIT_MS 10
+#define I40EVF_RESET_WAIT_COUNT 500
 /**
  * i40evf_reset_task - Call-back task to handle hardware reset
  * @work: pointer to work_struct
-- 
1.9.3

