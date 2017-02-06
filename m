From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  6 Feb 2017 14:38:49 -0800
Subject: [Intel-wired-lan] [PART2 PATCH 6/9] i40e: add parsing of flexible
	filter fields from userdef
In-Reply-To: <20170206223852.31177-1-jacob.e.keller@intel.com>
References: <20170206223852.31177-1-jacob.e.keller@intel.com>
Message-ID: <20170206223852.31177-7-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add code to parse the user-def field into a data structure format. This
code is intended to allow future extensions of the user-def field by
keeping all code that actually reads and writes the field into a single
location. This ensures that we do not litter the driver with references
to the user-def field and minimizes the amount of bitwise operations we
need to do on the data.

Add code which parses the lower 32bits into a flexible word and its
offset. This will be used in a future patch to enable flexible filters
which can match on some arbitrary data in the packet payload. For now,
we just return -EOPNOTSUPP when this is used.

Add code to fill in the user-def field when reporting the filter back,
even though we don't actually implement any user-def fields yet.

Additionally, ensure that we mask the extended FLOW_EXT bit from the
flow_type now that we will be accepting filters which have the FLOW_EXT
bit set (and thus make use of the user-def field).

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-Id: 238845035c179380a347baa8db8223304f5f6dd7
---
 drivers/net/ethernet/intel/i40e/i40e.h         |   9 +++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 108 ++++++++++++++++++++++++-
 2 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 4d54d5005ad3..bffcfc1041e7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -206,6 +206,15 @@ enum i40e_fd_stat_idx {
 #define I40E_FD_ATR_TUNNEL_STAT_IDX(pf_id) \
 			(I40E_FD_STAT_PF_IDX(pf_id) + I40E_FD_STAT_ATR_TUNNEL)
 
+/* The following structure contains the data parsed from the user-defined
+ * field of the ethtool_rx_flow_spec structure.
+ */
+struct i40e_rx_flow_userdef {
+	bool flex_filter;
+	u16 flex_word;
+	u16 flex_offset;
+};
+
 struct i40e_fdir_filter {
 	struct hlist_node fdir_node;
 	/* filter ipnut set */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index f6cca3254fd4..56adffa049d6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2293,6 +2293,100 @@ static int i40e_get_rss_hash_opts(struct i40e_pf *pf, struct ethtool_rxnfc *cmd)
 	return 0;
 }
 
+/* i40e_check_mask - Check whether a mask field is set
+ * @mask: the full mask value
+ * @field; mask of the field to check
+ *
+ * If the given mask is fully set, return positive value. If the mask for the
+ * field is fully unset, return zero. Otherwise return a negative error code.
+ */
+static int i40e_check_mask(u64 mask, u64 field)
+{
+	u64 value = mask & field;
+
+	if (value == field)
+		return 1;
+	else if (!value)
+		return 0;
+	else
+		return -1;
+}
+
+/* i40e_parse_rx_flow_user_data - Deconstruct user-defined data
+ * @fsp: pointer to rx flow specification
+ * @data: pointer to userdef data structure for storage
+ *
+ * Read the user-defined data and deconstruct the value into a structure. No
+ * other code should read the user-defined data, so as to ensure that every
+ * place consistently reads the value correctly.
+ *
+ * The user-defined field is a 64bit Big Endian format value, which we
+ * deconstruct by reading bits or bit fields from it. Single bit flags shall
+ * be defined starting from the highest bits, while small bit field values
+ * shall be defined starting from the lowest bits.
+ *
+ * Returns 0 if the data is valid, and non-zero if the userdef data is invalid
+ * and the filter should be rejected. The data structure will always be
+ * modified even if FLOW_EXT is not set.
+
+ *
+ */
+static int i40e_parse_rx_flow_user_data(struct ethtool_rx_flow_spec *fsp,
+					struct i40e_rx_flow_userdef *data)
+{
+	u64 value, mask;
+	int valid;
+
+	/* Zero memory first so it's always consistent. */
+	memset(data, 0, sizeof(*data));
+
+	if (!(fsp->flow_type & FLOW_EXT))
+		return 0;
+
+	value = be64_to_cpu(*((__be64 *)fsp->h_ext.data));
+	mask = be64_to_cpu(*((__be64 *)fsp->m_ext.data));
+
+#define I40E_USERDEF_FLEX_WORD		GENMASK_ULL(15, 0)
+#define I40E_USERDEF_FLEX_OFFSET	GENMASK_ULL(31, 16)
+#define I40E_USERDEF_FLEX_FILTER	GENMASK_ULL(31, 0)
+
+	valid = i40e_check_mask(mask, I40E_USERDEF_FLEX_FILTER);
+	if (valid < 0) {
+		return -EINVAL;
+	} else if (valid) {
+		data->flex_word = value & I40E_USERDEF_FLEX_WORD;
+		data->flex_offset =
+			(value & I40E_USERDEF_FLEX_OFFSET) >> 16;
+		data->flex_filter = true;
+	}
+
+	return 0;
+}
+
+/* i40e_fill_rx_flow_user_data - Fill in user-defined data field
+ * @fsp: pointer to rx_flow specification
+ *
+ * Reads the userdef data structure and properly fills in the user defined
+ * fields of the rx_flow_spec.
+ */
+static void i40e_fill_rx_flow_user_data(struct ethtool_rx_flow_spec *fsp,
+					struct i40e_rx_flow_userdef *data)
+{
+	u64 value = 0, mask = 0;
+
+	if (data->flex_filter) {
+		value |= data->flex_word;
+		value |= (u64)data->flex_offset << 16;
+		mask |= I40E_USERDEF_FLEX_FILTER;
+	}
+
+	if (value || mask)
+		fsp->flow_type |= FLOW_EXT;
+
+	*((__be64 *)fsp->h_ext.data) = cpu_to_be64(value);
+	*((__be64 *)fsp->m_ext.data) = cpu_to_be64(mask);
+}
+
 /**
  * i40e_get_ethtool_fdir_all - Populates the rule count of a command
  * @pf: Pointer to the physical function struct
@@ -2344,6 +2438,7 @@ static int i40e_get_ethtool_fdir_entry(struct i40e_pf *pf,
 {
 	struct ethtool_rx_flow_spec *fsp =
 			(struct ethtool_rx_flow_spec *)&cmd->fs;
+	struct i40e_rx_flow_userdef userdef = {0};
 	struct i40e_fdir_filter *rule = NULL;
 	struct hlist_node *node2;
 	u64 input_set;
@@ -2430,6 +2525,8 @@ static int i40e_get_ethtool_fdir_entry(struct i40e_pf *pf,
 		}
 	}
 
+	i40e_fill_rx_flow_user_data(fsp, &userdef);
+
 	return 0;
 }
 
@@ -3003,6 +3100,7 @@ static int i40e_check_fdir_input_set(struct i40e_vsi *vsi,
 static int i40e_add_fdir_ethtool(struct i40e_vsi *vsi,
 				 struct ethtool_rxnfc *cmd)
 {
+	struct i40e_rx_flow_userdef userdef;
 	struct ethtool_rx_flow_spec *fsp;
 	struct i40e_fdir_filter *input;
 	u16 dest_vsi = 0, q_index = 0;
@@ -3029,6 +3127,14 @@ static int i40e_add_fdir_ethtool(struct i40e_vsi *vsi,
 
 	fsp = (struct ethtool_rx_flow_spec *)&cmd->fs;
 
+	/* Parse the user-defined field */
+	if (i40e_parse_rx_flow_user_data(fsp, &userdef))
+		return -EINVAL;
+
+	/* Flexible filters not yet supported */
+	if (userdef.flex_filter)
+		return -EOPNOTSUPP;
+
 	/* Extended MAC field is not supported */
 	if (fsp->flow_type & FLOW_MAC_EXT)
 		return -EINVAL;
@@ -3082,7 +3188,7 @@ static int i40e_add_fdir_ethtool(struct i40e_vsi *vsi,
 	input->cnt_index  = I40E_FD_SB_STAT_IDX(pf->hw.pf_id);
 	input->dst_ip = fsp->h_u.tcp_ip4_spec.ip4src;
 	input->src_ip = fsp->h_u.tcp_ip4_spec.ip4dst;
-	input->flow_type = fsp->flow_type;
+	input->flow_type = fsp->flow_type & ~FLOW_EXT;
 	input->ip4_proto = fsp->h_u.usr_ip4_spec.proto;
 
 	/* Reverse the src and dest notion, since the HW expects them to be from
-- 
2.12.0.rc0.151.g8a5726c42288

