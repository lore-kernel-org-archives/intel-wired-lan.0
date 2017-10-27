From: Alice Michael <alice.michael@intel.com>
Date: Fri, 27 Oct 2017 11:06:51 -0400
Subject: [Intel-wired-lan] [next PATCH S81-V3 4/9] i40evf: release bit locks
	in reverse order
In-Reply-To: <20171027150656.68250-1-alice.michael@intel.com>
References: <20171027150656.68250-1-alice.michael@intel.com>
Message-ID: <20171027150656.68250-4-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Although not strictly necessary, it is customary to reverse the order in
which we release locks that we acquire. This helps preserve lock
ordering during future refactors, which can help avoid potential
deadlock situations.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 2b135dc..9a945ff 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1960,8 +1960,8 @@ static void i40evf_reset_task(struct work_struct *work)
 
 	adapter->aq_required |= I40EVF_FLAG_AQ_ADD_MAC_FILTER;
 	adapter->aq_required |= I40EVF_FLAG_AQ_ADD_VLAN_FILTER;
-	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
 	clear_bit(__I40EVF_IN_CLIENT_TASK, &adapter->crit_section);
+	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
 	i40evf_misc_irq_enable(adapter);
 
 	mod_timer(&adapter->watchdog_timer, jiffies + 2);
-- 
2.9.5

