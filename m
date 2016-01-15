From: Joshua Hay <joshua.a.hay@intel.com>
Date: Fri, 15 Jan 2016 14:33:19 -0800
Subject: [Intel-wired-lan] [next PATCH S28 12/15] i40evf: set adapter state
	on reset failure
In-Reply-To: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
References: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1452897202-15204-13-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

If a reset fails to complete, the driver gets its affairs in order and
awaits the cold solace of rmmod. Unfortunately, it was not properly
setting the adapter state, which would cause a panic on rmmod, instead
of the desired surcease.

Set the adapter state to DOWN in this case, and avoid a panic.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I6fdd9906da52e023f8dc744f7da44b5d95278ca9
---
Testing Hints: Execute CORER on the PF and see if you can get into
the state where the VF reset never completed. Then rmmod i40evf.

 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 2b3c81b..6fcf9af 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1883,6 +1883,7 @@ static void i40evf_reset_task(struct work_struct *work)
 		adapter->netdev->flags &= ~IFF_UP;
 		clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
 		adapter->flags &= ~I40EVF_FLAG_RESET_PENDING;
+		adapter->state = __I40EVF_DOWN;
 		dev_info(&adapter->pdev->dev, "Reset task did not complete, VF disabled\n");
 		return; /* Do not attempt to reinit. It's dead, Jim. */
 	}
-- 
2.1.0

