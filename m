From: Gustavo A. R. Silva <gustavoars@kernel.org>
Date: Wed, 27 May 2020 07:27:37 -0500
Subject: [Intel-wired-lan] [PATCH v2][net-next] ice: Replace one-element
 arrays with flexible-arrays
Message-ID: <20200527122737.GA18133@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The current codebase makes use of one-element arrays in the following
form:

struct something {
    int length;
    u8 data[1];
};

struct something *instance;

instance = kmalloc(sizeof(*instance) + size, GFP_KERNEL);
instance->length = size;
memcpy(instance->data, source, size);

but the preferred mechanism to declare variable-length types such as
these ones is a flexible array member[1][2], introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on. So, replace
the one-element array with a flexible-array member.

Also, make use of the offsetof() helper in order to simplify the macros
that calculate the size of the structures that contain flexible-array
members.

This issue was found with the help of Coccinelle and, audited _manually_.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Use offsetof(struct ice_aqc_sw_rules_elem, pdata) instead of
   sizeof(struct ice_aqc_sw_rules_elem) - sizeof(((struct ice_aqc_sw_rules_elem *)0)->pdata)
 - Update changelog text. 

 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  6 ++---
 drivers/net/ethernet/intel/ice/ice_switch.c   | 26 +++++++------------
 2 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 586d69491268a..faa21830e40d8 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -570,7 +570,7 @@ struct ice_sw_rule_lkup_rx_tx {
 	 * lookup-type
 	 */
 	__le16 hdr_len;
-	u8 hdr[1];
+	u8 hdr[];
 } __packed;
 
 /* Add/Update/Remove large action command/response entry
@@ -580,7 +580,7 @@ struct ice_sw_rule_lkup_rx_tx {
 struct ice_sw_rule_lg_act {
 	__le16 index; /* Index in large action table */
 	__le16 size;
-	__le32 act[1]; /* array of size for actions */
+	__le32 act[]; /* array of size for actions */
 	/* Max number of large actions */
 #define ICE_MAX_LG_ACT	4
 	/* Bit 0:1 - Action type */
@@ -640,7 +640,7 @@ struct ice_sw_rule_lg_act {
 struct ice_sw_rule_vsi_list {
 	__le16 index; /* Index of VSI/Prune list */
 	__le16 number_vsi;
-	__le16 vsi[1]; /* Array of number_vsi VSI numbers */
+	__le16 vsi[]; /* Array of number_vsi VSI numbers */
 };
 
 /* Query VSI list command/response entry */
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 0156b73df1b1f..df0ddffaf03a2 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -29,25 +29,19 @@ static const u8 dummy_eth_header[DUMMY_ETH_HDR_LEN] = { 0x2, 0, 0, 0, 0, 0,
 							0x81, 0, 0, 0};
 
 #define ICE_SW_RULE_RX_TX_ETH_HDR_SIZE \
-	(sizeof(struct ice_aqc_sw_rules_elem) - \
-	 sizeof(((struct ice_aqc_sw_rules_elem *)0)->pdata) + \
-	 sizeof(struct ice_sw_rule_lkup_rx_tx) + DUMMY_ETH_HDR_LEN - 1)
+	(offsetof(struct ice_aqc_sw_rules_elem, pdata) + \
+	 sizeof(struct ice_sw_rule_lkup_rx_tx) + DUMMY_ETH_HDR_LEN)
 #define ICE_SW_RULE_RX_TX_NO_HDR_SIZE \
-	(sizeof(struct ice_aqc_sw_rules_elem) - \
-	 sizeof(((struct ice_aqc_sw_rules_elem *)0)->pdata) + \
-	 sizeof(struct ice_sw_rule_lkup_rx_tx) - 1)
+	(offsetof(struct ice_aqc_sw_rules_elem, pdata) + \
+	 sizeof(struct ice_sw_rule_lkup_rx_tx))
 #define ICE_SW_RULE_LG_ACT_SIZE(n) \
-	(sizeof(struct ice_aqc_sw_rules_elem) - \
-	 sizeof(((struct ice_aqc_sw_rules_elem *)0)->pdata) + \
-	 sizeof(struct ice_sw_rule_lg_act) - \
-	 sizeof(((struct ice_sw_rule_lg_act *)0)->act) + \
-	 ((n) * sizeof(((struct ice_sw_rule_lg_act *)0)->act)))
+	(offsetof(struct ice_aqc_sw_rules_elem, pdata) + \
+	 offsetof(struct ice_sw_rule_lg_act, act) + \
+	 ((n) * sizeof(__le32)))
 #define ICE_SW_RULE_VSI_LIST_SIZE(n) \
-	(sizeof(struct ice_aqc_sw_rules_elem) - \
-	 sizeof(((struct ice_aqc_sw_rules_elem *)0)->pdata) + \
-	 sizeof(struct ice_sw_rule_vsi_list) - \
-	 sizeof(((struct ice_sw_rule_vsi_list *)0)->vsi) + \
-	 ((n) * sizeof(((struct ice_sw_rule_vsi_list *)0)->vsi)))
+	(offsetof(struct ice_aqc_sw_rules_elem, pdata) + \
+	 offsetof(struct ice_sw_rule_vsi_list, vsi) + \
+	 ((n) * sizeof(__le16)))
 
 /**
  * ice_init_def_sw_recp - initialize the recipe book keeping tables
-- 
2.26.2

