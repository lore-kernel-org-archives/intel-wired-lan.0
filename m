From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 11 Apr 2019 09:11:36 -0700
Subject: [Intel-wired-lan] [PATCH 4/4] net: hns3: Use LLDP ethertype define
 ETH_P_LLDP
In-Reply-To: <20190411161136.1541-1-anirudh.venkataramanan@intel.com>
References: <20190411161136.1541-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190411161136.1541-5-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove references to HCLGE_MAC_ETHERTYPE_LLDP and use ETH_P_LLDP instead.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h  | 1 -
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index 3714733c96d9..667ed15bd452 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -646,7 +646,6 @@ struct hclge_umv_spc_alc_cmd {
 #define HCLGE_MAC_MGR_MASK_VLAN_B		BIT(0)
 #define HCLGE_MAC_MGR_MASK_MAC_B		BIT(1)
 #define HCLGE_MAC_MGR_MASK_ETHERTYPE_B		BIT(2)
-#define HCLGE_MAC_ETHERTYPE_LLDP		0x88cc
 
 struct hclge_mac_mgr_tbl_entry_cmd {
 	u8      flags;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index f51e4c01b670..4c0682436e8b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -289,7 +289,7 @@ static const struct hclge_comm_stats_str g_mac_stats_string[] = {
 static const struct hclge_mac_mgr_tbl_entry_cmd hclge_mgr_table[] = {
 	{
 		.flags = HCLGE_MAC_MGR_MASK_VLAN_B,
-		.ethter_type = cpu_to_le16(HCLGE_MAC_ETHERTYPE_LLDP),
+		.ethter_type = cpu_to_le16(ETH_P_LLDP),
 		.mac_addr_hi32 = cpu_to_le32(htonl(0x0180C200)),
 		.mac_addr_lo16 = cpu_to_le16(htons(0x000E)),
 		.i_port_bitmap = 0x1,
-- 
2.20.1

