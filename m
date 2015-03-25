From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 24 Mar 2015 21:30:23 -0700
Subject: [Intel-wired-lan] [next-queue S2 13/15] i40evf: protect VLAN filter
	list
In-Reply-To: <1427257825-24519-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1427257825-24519-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1427257825-24519-13-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

The MAC filter list is protected by a critical task bit, and the VLAN
list should be protected as well. This prevents list corruption if the
watchdog happens to run at the same time as a VLAN filter is being added
or deleted.

Change-ID: Ia4867cebbbb046a1f38012771b288a634ca5882b
Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index b08efaf..46aef2a 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -664,13 +664,21 @@ i40evf_vlan_filter *i40evf_find_vlan(struct i40evf_adapter *adapter, u16 vlan)
 static struct
 i40evf_vlan_filter *i40evf_add_vlan(struct i40evf_adapter *adapter, u16 vlan)
 {
-	struct i40evf_vlan_filter *f;
+	struct i40evf_vlan_filter *f = NULL;
+	int count = 50;
+
+	while (test_and_set_bit(__I40EVF_IN_CRITICAL_TASK,
+				&adapter->crit_section)) {
+		udelay(1);
+		if (--count == 0)
+			goto out;
+	}
 
 	f = i40evf_find_vlan(adapter, vlan);
 	if (!f) {
 		f = kzalloc(sizeof(*f), GFP_ATOMIC);
 		if (!f)
-			return NULL;
+			goto clearout;
 
 		f->vlan = vlan;
 
@@ -680,6 +688,9 @@ i40evf_vlan_filter *i40evf_add_vlan(struct i40evf_adapter *adapter, u16 vlan)
 		adapter->aq_required |= I40EVF_FLAG_AQ_ADD_VLAN_FILTER;
 	}
 
+clearout:
+	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
+out:
 	return f;
 }
 
@@ -691,12 +702,21 @@ i40evf_vlan_filter *i40evf_add_vlan(struct i40evf_adapter *adapter, u16 vlan)
 static void i40evf_del_vlan(struct i40evf_adapter *adapter, u16 vlan)
 {
 	struct i40evf_vlan_filter *f;
+	int count = 50;
+
+	while (test_and_set_bit(__I40EVF_IN_CRITICAL_TASK,
+				&adapter->crit_section)) {
+		udelay(1);
+		if (--count == 0)
+			return;
+	}
 
 	f = i40evf_find_vlan(adapter, vlan);
 	if (f) {
 		f->remove = true;
 		adapter->aq_required |= I40EVF_FLAG_AQ_DEL_VLAN_FILTER;
 	}
+	clear_bit(__I40EVF_IN_CRITICAL_TASK, &adapter->crit_section);
 }
 
 /**
-- 
1.9.3

