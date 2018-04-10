From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Tue, 10 Apr 2018 10:49:50 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v7 01/10] igb: Fix not adding
 filter elements to the list
In-Reply-To: <20180410174959.18757-1-vinicius.gomes@intel.com>
References: <20180410174959.18757-1-vinicius.gomes@intel.com>
Message-ID: <20180410174959.18757-2-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Because the order of the parameters passes to 'hlist_add_behind()' was
inverted, the 'parent' node was added "behind" the 'input', as input
is not in the list, this causes the 'input' node to be lost.

Fixes: 0e71def25281 ("igb: add support of RX network flow classification")
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index e77ba0d5866d..5975d432836f 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2865,7 +2865,7 @@ static int igb_update_ethtool_nfc_entry(struct igb_adapter *adapter,
 
 	/* add filter to the list */
 	if (parent)
-		hlist_add_behind(&parent->nfc_node, &input->nfc_node);
+		hlist_add_behind(&input->nfc_node, &parent->nfc_node);
 	else
 		hlist_add_head(&input->nfc_node, &adapter->nfc_filter_list);
 
-- 
2.17.0

