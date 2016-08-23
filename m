From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Tue, 23 Aug 2016 15:08:09 +0000
Subject: [Intel-wired-lan] [PATCH -next] igb: fix non static symbol warning
Message-ID: <1471964889-511-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Wei Yongjun <weiyongjun1@huawei.com>

Fixes the following sparse warning:

drivers/net/ethernet/intel/igb/igb_ethtool.c:2707:5: warning:
 symbol 'igb_rxnfc_write_vlan_prio_filter' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 0c33eca..737b664 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2704,8 +2704,8 @@ static int igb_rxnfc_write_etype_filter(struct igb_adapter *adapter,
 	return 0;
 }
 
-int igb_rxnfc_write_vlan_prio_filter(struct igb_adapter *adapter,
-				     struct igb_nfc_filter *input)
+static int igb_rxnfc_write_vlan_prio_filter(struct igb_adapter *adapter,
+					    struct igb_nfc_filter *input)
 {
 	struct e1000_hw *hw = &adapter->hw;
 	u8 vlan_priority;



