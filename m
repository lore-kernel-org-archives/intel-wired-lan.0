From: Haiyue Wang <haiyue.wang@intel.com>
Date: Wed, 31 Mar 2021 10:08:35 +0800
Subject: [Intel-wired-lan] [Patch v1 1/3] iavf: change the flex-byte support
 number to macro definition
Message-ID: <20210331020837.3640-1-haiyue.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The maximum number (2) of flex-byte support is derived from ethtool
use-def data size (8 byte).

Change the magic number 2 to macro definition, and add the comment to
track the design thinking, so the code is clear and easily maintained.

Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 2 +-
 drivers/net/ethernet/intel/iavf/iavf_fdir.h    | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index d9ed4d4e3d78..935145ab2b77 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -939,7 +939,7 @@ iavf_parse_rx_flow_user_data(struct ethtool_rx_flow_spec *fsp,
 	if (!(fsp->flow_type & FLOW_EXT))
 		return 0;
 
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < IAVF_FLEX_WORD_NUM; i++) {
 #define IAVF_USERDEF_FLEX_WORD_M	GENMASK(15, 0)
 #define IAVF_USERDEF_FLEX_OFFS_S	16
 #define IAVF_USERDEF_FLEX_OFFS_M	GENMASK(31, IAVF_USERDEF_FLEX_OFFS_S)
diff --git a/drivers/net/ethernet/intel/iavf/iavf_fdir.h b/drivers/net/ethernet/intel/iavf/iavf_fdir.h
index 2439c970b657..33c55c366315 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_fdir.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_fdir.h
@@ -35,6 +35,11 @@ enum iavf_fdir_flow_type {
 	IAVF_FDIR_FLOW_PTYPE_MAX,
 };
 
+/* Must not exceed the array element number of '__be32 data[2]' in the ethtool
+ * 'struct ethtool_rx_flow_spec.m_ext.data[2]' to express the flex-byte (word).
+ */
+#define IAVF_FLEX_WORD_NUM	2
+
 struct iavf_flex_word {
 	u16 offset;
 	u16 word;
@@ -71,7 +76,7 @@ struct iavf_fdir_ip {
 };
 
 struct iavf_fdir_extra {
-	u32 usr_def[2];
+	u32 usr_def[IAVF_FLEX_WORD_NUM];
 };
 
 /* bookkeeping of Flow Director filters */
@@ -95,7 +100,7 @@ struct iavf_fdir_fltr {
 	/* flex byte filter data */
 	u8 ip_ver; /* used to adjust the flex offset, 4 : IPv4, 6 : IPv6 */
 	u8 flex_cnt;
-	struct iavf_flex_word flex_words[2];
+	struct iavf_flex_word flex_words[IAVF_FLEX_WORD_NUM];
 
 	u32 flow_id;
 
-- 
2.31.1

