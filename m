From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Wed,  3 Aug 2016 10:20:14 -0700
Subject: [Intel-wired-lan] [next PATCH S41 4/5] i40e: Add support for ARP NS
	in X722
In-Reply-To: <1470244815-31174-1-git-send-email-bimmy.pujari@intel.com>
References: <1470244815-31174-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1470244815-31174-5-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Carolyn Wyborny <carolyn.wyborny@intel.com>

This patch adds support and interface for supporting ARP NS
proxy offload in firmware for X722.

Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
Change-ID: Ic7489fbcbe2195df7be62ff5e359201b827cefe6
---
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  | 38 ++++++++++++----------
 .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    | 38 ++++++++++++----------
 2 files changed, 42 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index aabacc3..736c3ab 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -455,13 +455,15 @@ I40E_CHECK_CMD_LENGTH(i40e_aqc_cppm_configuration);
 /* Set ARP Proxy command / response (indirect 0x0104) */
 struct i40e_aqc_arp_proxy_data {
 	__le16	command_flags;
-#define I40E_AQ_ARP_INIT_IPV4	0x0008
-#define I40E_AQ_ARP_UNSUP_CTL	0x0010
-#define I40E_AQ_ARP_ENA		0x0020
-#define I40E_AQ_ARP_ADD_IPV4	0x0040
-#define I40E_AQ_ARP_DEL_IPV4	0x0080
+#define I40E_AQ_ARP_INIT_IPV4	0x0800
+#define I40E_AQ_ARP_UNSUP_CTL	0x1000
+#define I40E_AQ_ARP_ENA		0x2000
+#define I40E_AQ_ARP_ADD_IPV4	0x4000
+#define I40E_AQ_ARP_DEL_IPV4	0x8000
 	__le16	table_id;
-	__le32	pfpm_proxyfc;
+	__le32	enabled_offloads;
+#define I40E_AQ_ARP_DIRECTED_OFFLOAD_ENABLE	0x00000020
+#define I40E_AQ_ARP_OFFLOAD_ENABLE		0x00000800
 	__le32	ip_addr;
 	u8	mac_addr[6];
 	u8	reserved[2];
@@ -476,17 +478,19 @@ struct i40e_aqc_ns_proxy_data {
 	__le16	table_idx_ipv6_0;
 	__le16	table_idx_ipv6_1;
 	__le16	control;
-#define I40E_AQ_NS_PROXY_ADD_0		0x0100
-#define I40E_AQ_NS_PROXY_DEL_0		0x0200
-#define I40E_AQ_NS_PROXY_ADD_1		0x0400
-#define I40E_AQ_NS_PROXY_DEL_1		0x0800
-#define I40E_AQ_NS_PROXY_ADD_IPV6_0	0x1000
-#define I40E_AQ_NS_PROXY_DEL_IPV6_0	0x2000
-#define I40E_AQ_NS_PROXY_ADD_IPV6_1	0x4000
-#define I40E_AQ_NS_PROXY_DEL_IPV6_1	0x8000
-#define I40E_AQ_NS_PROXY_COMMAND_SEQ	0x0001
-#define I40E_AQ_NS_PROXY_INIT_IPV6_TBL	0x0002
-#define I40E_AQ_NS_PROXY_INIT_MAC_TBL	0x0004
+#define I40E_AQ_NS_PROXY_ADD_0		0x0001
+#define I40E_AQ_NS_PROXY_DEL_0		0x0002
+#define I40E_AQ_NS_PROXY_ADD_1		0x0004
+#define I40E_AQ_NS_PROXY_DEL_1		0x0008
+#define I40E_AQ_NS_PROXY_ADD_IPV6_0	0x0010
+#define I40E_AQ_NS_PROXY_DEL_IPV6_0	0x0020
+#define I40E_AQ_NS_PROXY_ADD_IPV6_1	0x0040
+#define I40E_AQ_NS_PROXY_DEL_IPV6_1	0x0080
+#define I40E_AQ_NS_PROXY_COMMAND_SEQ	0x0100
+#define I40E_AQ_NS_PROXY_INIT_IPV6_TBL	0x0200
+#define I40E_AQ_NS_PROXY_INIT_MAC_TBL	0x0400
+#define I40E_AQ_NS_PROXY_OFFLOAD_ENABLE	0x0800
+#define I40E_AQ_NS_PROXY_DIRECTED_OFFLOAD_ENABLE	0x1000
 	u8	mac_addr_0[6];
 	u8	mac_addr_1[6];
 	u8	local_mac_addr[6];
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
index c07e3a3..0c099df 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
@@ -452,13 +452,15 @@ I40E_CHECK_CMD_LENGTH(i40e_aqc_cppm_configuration);
 /* Set ARP Proxy command / response (indirect 0x0104) */
 struct i40e_aqc_arp_proxy_data {
 	__le16	command_flags;
-#define I40E_AQ_ARP_INIT_IPV4	0x0008
-#define I40E_AQ_ARP_UNSUP_CTL	0x0010
-#define I40E_AQ_ARP_ENA		0x0020
-#define I40E_AQ_ARP_ADD_IPV4	0x0040
-#define I40E_AQ_ARP_DEL_IPV4	0x0080
+#define I40E_AQ_ARP_INIT_IPV4	0x0800
+#define I40E_AQ_ARP_UNSUP_CTL	0x1000
+#define I40E_AQ_ARP_ENA		0x2000
+#define I40E_AQ_ARP_ADD_IPV4	0x4000
+#define I40E_AQ_ARP_DEL_IPV4	0x8000
 	__le16	table_id;
-	__le32	pfpm_proxyfc;
+	__le32	enabled_offloads;
+#define I40E_AQ_ARP_DIRECTED_OFFLOAD_ENABLE	0x00000020
+#define I40E_AQ_ARP_OFFLOAD_ENABLE		0x00000800
 	__le32	ip_addr;
 	u8	mac_addr[6];
 	u8	reserved[2];
@@ -473,17 +475,19 @@ struct i40e_aqc_ns_proxy_data {
 	__le16	table_idx_ipv6_0;
 	__le16	table_idx_ipv6_1;
 	__le16	control;
-#define I40E_AQ_NS_PROXY_ADD_0		0x0100
-#define I40E_AQ_NS_PROXY_DEL_0		0x0200
-#define I40E_AQ_NS_PROXY_ADD_1		0x0400
-#define I40E_AQ_NS_PROXY_DEL_1		0x0800
-#define I40E_AQ_NS_PROXY_ADD_IPV6_0	0x1000
-#define I40E_AQ_NS_PROXY_DEL_IPV6_0	0x2000
-#define I40E_AQ_NS_PROXY_ADD_IPV6_1	0x4000
-#define I40E_AQ_NS_PROXY_DEL_IPV6_1	0x8000
-#define I40E_AQ_NS_PROXY_COMMAND_SEQ	0x0001
-#define I40E_AQ_NS_PROXY_INIT_IPV6_TBL	0x0002
-#define I40E_AQ_NS_PROXY_INIT_MAC_TBL	0x0004
+#define I40E_AQ_NS_PROXY_ADD_0		0x0001
+#define I40E_AQ_NS_PROXY_DEL_0		0x0002
+#define I40E_AQ_NS_PROXY_ADD_1		0x0004
+#define I40E_AQ_NS_PROXY_DEL_1		0x0008
+#define I40E_AQ_NS_PROXY_ADD_IPV6_0	0x0010
+#define I40E_AQ_NS_PROXY_DEL_IPV6_0	0x0020
+#define I40E_AQ_NS_PROXY_ADD_IPV6_1	0x0040
+#define I40E_AQ_NS_PROXY_DEL_IPV6_1	0x0080
+#define I40E_AQ_NS_PROXY_COMMAND_SEQ	0x0100
+#define I40E_AQ_NS_PROXY_INIT_IPV6_TBL	0x0200
+#define I40E_AQ_NS_PROXY_INIT_MAC_TBL	0x0400
+#define I40E_AQ_NS_PROXY_OFFLOAD_ENABLE	0x0800
+#define I40E_AQ_NS_PROXY_DIRECTED_OFFLOAD_ENABLE	0x1000
 	u8	mac_addr_0[6];
 	u8	mac_addr_1[6];
 	u8	local_mac_addr[6];
-- 
2.4.11

