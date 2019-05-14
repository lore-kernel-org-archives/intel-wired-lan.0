From: Alice Michael <alice.michael@intel.com>
Date: Tue, 14 May 2019 10:36:59 -0700
Subject: [Intel-wired-lan] [next PATCH S5 iavf 01/11] iavf: Create VLAN tag
 elements starting from the first element
Message-ID: <20190514173709.62431-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

This patch changes how VLAN tag are being populated and programmed into
the HW - Instead of start adding VF VLAN tag from the last member of the
element list, start from the first member of the list, until number of
allowed VLAN tags is exhausted in the HW.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 44d2150adb37..36f17d0c7a2e 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -665,8 +665,7 @@ iavf_vlan_filter *iavf_add_vlan(struct iavf_adapter *adapter, u16 vlan)
 
 		f->vlan = vlan;
 
-		INIT_LIST_HEAD(&f->list);
-		list_add(&f->list, &adapter->vlan_filter_list);
+		list_add_tail(&f->list, &adapter->vlan_filter_list);
 		f->add = true;
 		adapter->aq_required |= IAVF_FLAG_AQ_ADD_VLAN_FILTER;
 	}
-- 
2.19.2

