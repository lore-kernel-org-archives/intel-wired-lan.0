From: Alice Michael <alice.michael@intel.com>
Date: Fri, 20 Apr 2018 01:41:33 -0700
Subject: [Intel-wired-lan] [next PATCH S90 1/8] i40e/i40evf: cleanup
 incorrect function doxygen comments
Message-ID: <20180420084140.8081-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Recent versions of the Linux kernel now warn about incorrect parameter
definitions for function comments. Fix up several function comments to
correctly reflect the current function arguments. This cleans up the
warnings and helps ensure our documentation is accurate.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_client.c      |  6 ++--
 drivers/net/ethernet/intel/i40e/i40e_common.c      | 37 +++++++++++++---------
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c      | 11 ++++---
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |  8 ++---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 24 ++++++++------
 drivers/net/ethernet/intel/i40e/i40e_hmc.c         |  1 -
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 22 +++++++++----
 drivers/net/ethernet/intel/i40e/i40e_nvm.c         |  1 +
 drivers/net/ethernet/intel/i40e/i40e_ptp.c         |  4 +--
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  6 ++--
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 16 +++++-----
 drivers/net/ethernet/intel/i40evf/i40e_common.c    |  1 +
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |  4 ++-
 drivers/net/ethernet/intel/i40evf/i40evf_client.c  |  4 +--
 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c |  7 ++--
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  5 ++-
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 11 +------
 17 files changed, 95 insertions(+), 73 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index 2041757..2e88597 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -40,7 +40,7 @@ static struct i40e_ops i40e_lan_ops = {
 /**
  * i40e_client_get_params - Get the params that can change at runtime
  * @vsi: the VSI with the message
- * @param: clinet param struct
+ * @params: clinet param struct
  *
  **/
 static
@@ -566,7 +566,7 @@ static int i40e_client_virtchnl_send(struct i40e_info *ldev,
  * i40e_client_setup_qvlist
  * @ldev: pointer to L2 context.
  * @client: Client pointer.
- * @qv_info: queue and vector list
+ * @qvlist_info: queue and vector list
  *
  * Return 0 on success or < 0 on error
  **/
@@ -641,7 +641,7 @@ static int i40e_client_setup_qvlist(struct i40e_info *ldev,
  * i40e_client_request_reset
  * @ldev: pointer to L2 context.
  * @client: Client pointer.
- * @level: reset level
+ * @reset_level: reset level
  **/
 static void i40e_client_request_reset(struct i40e_info *ldev,
 				      struct i40e_client *client,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 6f8fd70..eb2d153 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1671,6 +1671,8 @@ enum i40e_status_code i40e_aq_set_phy_config(struct i40e_hw *hw,
 /**
  * i40e_set_fc
  * @hw: pointer to the hw struct
+ * @aq_failures: buffer to return AdminQ failure information
+ * @atomic_restart: whether to enable atomic link restart
  *
  * Set the requested flow control mode using set_phy_config.
  **/
@@ -2807,8 +2809,8 @@ i40e_status i40e_aq_remove_macvlan(struct i40e_hw *hw, u16 seid,
  * @mr_list: list of mirrored VSI SEIDs or VLAN IDs
  * @cmd_details: pointer to command details structure or NULL
  * @rule_id: Rule ID returned from FW
- * @rule_used: Number of rules used in internal switch
- * @rule_free: Number of rules free in internal switch
+ * @rules_used: Number of rules used in internal switch
+ * @rules_free: Number of rules free in internal switch
  *
  * Add/Delete a mirror rule to a specific switch. Mirror rules are supported for
  * VEBs/VEPA elements only
@@ -2868,8 +2870,8 @@ static i40e_status i40e_mirrorrule_op(struct i40e_hw *hw,
  * @mr_list: list of mirrored VSI SEIDs or VLAN IDs
  * @cmd_details: pointer to command details structure or NULL
  * @rule_id: Rule ID returned from FW
- * @rule_used: Number of rules used in internal switch
- * @rule_free: Number of rules free in internal switch
+ * @rules_used: Number of rules used in internal switch
+ * @rules_free: Number of rules free in internal switch
  *
  * Add mirror rule. Mirror rules are supported for VEBs or VEPA elements only
  **/
@@ -2899,8 +2901,8 @@ i40e_status i40e_aq_add_mirrorrule(struct i40e_hw *hw, u16 sw_seid,
  *		add_mirrorrule.
  * @mr_list: list of mirrored VLAN IDs to be removed
  * @cmd_details: pointer to command details structure or NULL
- * @rule_used: Number of rules used in internal switch
- * @rule_free: Number of rules free in internal switch
+ * @rules_used: Number of rules used in internal switch
+ * @rules_free: Number of rules free in internal switch
  *
  * Delete a mirror rule. Mirror rules are supported for VEBs/VEPA elements only
  **/
@@ -3648,6 +3650,8 @@ i40e_status i40e_aq_stop_lldp(struct i40e_hw *hw, bool shutdown_agent,
 /**
  * i40e_aq_start_lldp
  * @hw: pointer to the hw struct
+ * @buff: buffer for result
+ * @buff_size: buffer size
  * @cmd_details: pointer to command details structure or NULL
  *
  * Start the embedded LLDP Agent on all ports.
@@ -3728,7 +3732,6 @@ i40e_status i40e_aq_get_cee_dcb_config(struct i40e_hw *hw,
  * i40e_aq_add_udp_tunnel
  * @hw: pointer to the hw struct
  * @udp_port: the UDP port to add in Host byte order
- * @header_len: length of the tunneling header length in DWords
  * @protocol_index: protocol index type
  * @filter_index: pointer to filter index
  * @cmd_details: pointer to command details structure or NULL
@@ -3947,6 +3950,7 @@ i40e_status i40e_aq_config_vsi_tc_bw(struct i40e_hw *hw,
  * @hw: pointer to the hw struct
  * @seid: seid of the switching component connected to Physical Port
  * @ets_data: Buffer holding ETS parameters
+ * @opcode: Tx scheduler AQ command opcode
  * @cmd_details: pointer to command details structure or NULL
  **/
 i40e_status i40e_aq_config_switch_comp_ets(struct i40e_hw *hw,
@@ -4290,10 +4294,10 @@ i40e_status i40e_aq_add_rem_control_packet_filter(struct i40e_hw *hw,
  * @hw: pointer to the hw struct
  * @seid: VSI seid to add ethertype filter from
  **/
-#define I40E_FLOW_CONTROL_ETHTYPE 0x8808
 void i40e_add_filter_to_drop_tx_flow_control_frames(struct i40e_hw *hw,
 						    u16 seid)
 {
+#define I40E_FLOW_CONTROL_ETHTYPE 0x8808
 	u16 flag = I40E_AQC_ADD_CONTROL_PACKET_FLAGS_IGNORE_MAC |
 		   I40E_AQC_ADD_CONTROL_PACKET_FLAGS_DROP |
 		   I40E_AQC_ADD_CONTROL_PACKET_FLAGS_TX;
@@ -4424,6 +4428,7 @@ void i40e_set_pci_config_data(struct i40e_hw *hw, u16 link_status)
  * @ret_buff_size: actual buffer size returned
  * @ret_next_table: next block to read
  * @ret_next_index: next index to read
+ * @cmd_details: pointer to command details structure or NULL
  *
  * Dump internal FW/HW data for debug purposes.
  *
@@ -4550,7 +4555,7 @@ i40e_status i40e_aq_configure_partition_bw(struct i40e_hw *hw,
  * i40e_read_phy_register_clause22
  * @hw: pointer to the HW structure
  * @reg: register address in the page
- * @phy_adr: PHY address on MDIO interface
+ * @phy_addr: PHY address on MDIO interface
  * @value: PHY register value
  *
  * Reads specified PHY register value
@@ -4595,7 +4600,7 @@ i40e_status i40e_read_phy_register_clause22(struct i40e_hw *hw,
  * i40e_write_phy_register_clause22
  * @hw: pointer to the HW structure
  * @reg: register address in the page
- * @phy_adr: PHY address on MDIO interface
+ * @phy_addr: PHY address on MDIO interface
  * @value: PHY register value
  *
  * Writes specified PHY register value
@@ -4636,7 +4641,7 @@ i40e_status i40e_write_phy_register_clause22(struct i40e_hw *hw,
  * @hw: pointer to the HW structure
  * @page: registers page number
  * @reg: register address in the page
- * @phy_adr: PHY address on MDIO interface
+ * @phy_addr: PHY address on MDIO interface
  * @value: PHY register value
  *
  * Reads specified PHY register value
@@ -4710,7 +4715,7 @@ i40e_status i40e_read_phy_register_clause45(struct i40e_hw *hw,
  * @hw: pointer to the HW structure
  * @page: registers page number
  * @reg: register address in the page
- * @phy_adr: PHY address on MDIO interface
+ * @phy_addr: PHY address on MDIO interface
  * @value: PHY register value
  *
  * Writes value to specified PHY register
@@ -4777,7 +4782,7 @@ i40e_status i40e_write_phy_register_clause45(struct i40e_hw *hw,
  * @hw: pointer to the HW structure
  * @page: registers page number
  * @reg: register address in the page
- * @phy_adr: PHY address on MDIO interface
+ * @phy_addr: PHY address on MDIO interface
  * @value: PHY register value
  *
  * Writes value to specified PHY register
@@ -4813,7 +4818,7 @@ i40e_status i40e_write_phy_register(struct i40e_hw *hw,
  * @hw: pointer to the HW structure
  * @page: registers page number
  * @reg: register address in the page
- * @phy_adr: PHY address on MDIO interface
+ * @phy_addr: PHY address on MDIO interface
  * @value: PHY register value
  *
  * Reads specified PHY register value
@@ -4848,7 +4853,6 @@ i40e_status i40e_read_phy_register(struct i40e_hw *hw,
  * i40e_get_phy_address
  * @hw: pointer to the HW structure
  * @dev_num: PHY port num that address we want
- * @phy_addr: Returned PHY address
  *
  * Gets PHY address for current port
  **/
@@ -5058,7 +5062,9 @@ i40e_status i40e_led_get_phy(struct i40e_hw *hw, u16 *led_addr,
  * i40e_led_set_phy
  * @hw: pointer to the HW structure
  * @on: true or false
+ * @led_addr: address of led register to use
  * @mode: original val plus bit for set or ignore
+ *
  * Set led's on or off when controlled by the PHY
  *
  **/
@@ -5347,6 +5353,7 @@ i40e_status_code i40e_aq_write_ddp(struct i40e_hw *hw, void *buff,
  * @hw: pointer to the hw struct
  * @buff: command buffer (size in bytes = buff_size)
  * @buff_size: buffer size in bytes
+ * @flags: AdminQ command flags
  * @cmd_details: pointer to command details structure or NULL
  **/
 enum
diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
index a09d723..9deae9a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
@@ -23,7 +23,7 @@ static void i40e_get_pfc_delay(struct i40e_hw *hw, u16 *delay)
 
 /**
  * i40e_dcbnl_ieee_getets - retrieve local IEEE ETS configuration
- * @netdev: the corresponding netdev
+ * @dev: the corresponding netdev
  * @ets: structure to hold the ETS information
  *
  * Returns local IEEE ETS configuration
@@ -62,8 +62,8 @@ static int i40e_dcbnl_ieee_getets(struct net_device *dev,
 
 /**
  * i40e_dcbnl_ieee_getpfc - retrieve local IEEE PFC configuration
- * @netdev: the corresponding netdev
- * @ets: structure to hold the PFC information
+ * @dev: the corresponding netdev
+ * @pfc: structure to hold the PFC information
  *
  * Returns local IEEE PFC configuration
  **/
@@ -95,7 +95,7 @@ static int i40e_dcbnl_ieee_getpfc(struct net_device *dev,
 
 /**
  * i40e_dcbnl_getdcbx - retrieve current DCBx capability
- * @netdev: the corresponding netdev
+ * @dev: the corresponding netdev
  *
  * Returns DCBx capability features
  **/
@@ -108,7 +108,8 @@ static u8 i40e_dcbnl_getdcbx(struct net_device *dev)
 
 /**
  * i40e_dcbnl_get_perm_hw_addr - MAC address used by DCBx
- * @netdev: the corresponding netdev
+ * @dev: the corresponding netdev
+ * @perm_addr: buffer to store the MAC address
  *
  * Returns the SAN MAC address used for LLDP exchange
  **/
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 94774a2..56b911a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -12,8 +12,8 @@ static struct dentry *i40e_dbg_root;
 
 /**
  * i40e_dbg_find_vsi - searches for the vsi with the given seid
- * @pf - the PF structure to search for the vsi
- * @seid - seid of the vsi it is searching for
+ * @pf: the PF structure to search for the vsi
+ * @seid: seid of the vsi it is searching for
  **/
 static struct i40e_vsi *i40e_dbg_find_vsi(struct i40e_pf *pf, int seid)
 {
@@ -31,8 +31,8 @@ static struct i40e_vsi *i40e_dbg_find_vsi(struct i40e_pf *pf, int seid)
 
 /**
  * i40e_dbg_find_veb - searches for the veb with the given seid
- * @pf - the PF structure to search for the veb
- * @seid - seid of the veb it is searching for
+ * @pf: the PF structure to search for the veb
+ * @seid: seid of the veb it is searching for
  **/
 static struct i40e_veb *i40e_dbg_find_veb(struct i40e_pf *pf, int seid)
 {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 94dbe2c..c1bbfb9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1055,6 +1055,9 @@ static int i40e_nway_reset(struct net_device *netdev)
 
 /**
  * i40e_get_pauseparam -  Get Flow Control status
+ * @netdev: netdevice structure
+ * @pause: buffer to return pause parameters
+ *
  * Return tx/rx-pause status
  **/
 static void i40e_get_pauseparam(struct net_device *netdev,
@@ -2526,7 +2529,7 @@ static int i40e_get_rss_hash_opts(struct i40e_pf *pf, struct ethtool_rxnfc *cmd)
 /**
  * i40e_check_mask - Check whether a mask field is set
  * @mask: the full mask value
- * @field; mask of the field to check
+ * @field: mask of the field to check
  *
  * If the given mask is fully set, return positive value. If the mask for the
  * field is fully unset, return zero. Otherwise return a negative error code.
@@ -2597,6 +2600,7 @@ static int i40e_parse_rx_flow_user_data(struct ethtool_rx_flow_spec *fsp,
 /**
  * i40e_fill_rx_flow_user_data - Fill in user-defined data field
  * @fsp: pointer to rx_flow specification
+ * @data: pointer to return userdef data
  *
  * Reads the userdef data structure and properly fills in the user defined
  * fields of the rx_flow_spec.
@@ -2775,6 +2779,7 @@ static int i40e_get_ethtool_fdir_entry(struct i40e_pf *pf,
  * i40e_get_rxnfc - command to get RX flow classification rules
  * @netdev: network interface device structure
  * @cmd: ethtool rxnfc command
+ * @rule_locs: pointer to store rule data
  *
  * Returns Success if the command is supported.
  **/
@@ -2816,7 +2821,7 @@ static int i40e_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 /**
  * i40e_get_rss_hash_bits - Read RSS Hash bits from register
  * @nfc: pointer to user request
- * @i_setc bits currently set
+ * @i_setc: bits currently set
  *
  * Returns value of bits to be set per user request
  **/
@@ -2861,7 +2866,7 @@ static u64 i40e_get_rss_hash_bits(struct ethtool_rxnfc *nfc, u64 i_setc)
 /**
  * i40e_set_rss_hash_opt - Enable/Disable flow types for RSS hash
  * @pf: pointer to the physical function struct
- * @cmd: ethtool rxnfc command
+ * @nfc: ethtool rxnfc command
  *
  * Returns Success if the flow input set is supported.
  **/
@@ -3260,7 +3265,7 @@ static int i40e_add_flex_offset(struct list_head *flex_pit_list,
  * __i40e_reprogram_flex_pit - Re-program specific FLX_PIT table
  * @pf: Pointer to the PF structure
  * @flex_pit_list: list of flexible src offsets in use
- * #flex_pit_start: index to first entry for this section of the table
+ * @flex_pit_start: index to first entry for this section of the table
  *
  * In order to handle flexible data, the hardware uses a table of values
  * called the FLX_PIT table. This table is used to indicate which sections of
@@ -3374,7 +3379,7 @@ static void i40e_reprogram_flex_pit(struct i40e_pf *pf)
 
 /**
  * i40e_flow_str - Converts a flow_type into a human readable string
- * @flow_type: the flow type from a flow specification
+ * @fsp: the flow specification
  *
  * Currently only flow types we support are included here, and the string
  * value attempts to match what ethtool would use to configure this flow type.
@@ -4079,7 +4084,7 @@ static unsigned int i40e_max_channels(struct i40e_vsi *vsi)
 
 /**
  * i40e_get_channels - Get the current channels enabled and max supported etc.
- * @netdev: network interface device structure
+ * @dev: network interface device structure
  * @ch: ethtool channels structure
  *
  * We don't support separate tx and rx queues as channels. The other count
@@ -4088,7 +4093,7 @@ static unsigned int i40e_max_channels(struct i40e_vsi *vsi)
  * q_vectors since we support a lot more queue pairs than q_vectors.
  **/
 static void i40e_get_channels(struct net_device *dev,
-			       struct ethtool_channels *ch)
+			      struct ethtool_channels *ch)
 {
 	struct i40e_netdev_priv *np = netdev_priv(dev);
 	struct i40e_vsi *vsi = np->vsi;
@@ -4107,14 +4112,14 @@ static void i40e_get_channels(struct net_device *dev,
 
 /**
  * i40e_set_channels - Set the new channels count.
- * @netdev: network interface device structure
+ * @dev: network interface device structure
  * @ch: ethtool channels structure
  *
  * The new channels count may not be the same as requested by the user
  * since it gets rounded down to a power of 2 value.
  **/
 static int i40e_set_channels(struct net_device *dev,
-			      struct ethtool_channels *ch)
+			     struct ethtool_channels *ch)
 {
 	const u8 drop = I40E_FILTER_PROGRAM_DESC_DEST_DROP_PACKET;
 	struct i40e_netdev_priv *np = netdev_priv(dev);
@@ -4249,6 +4254,7 @@ static int i40e_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key,
  * @netdev: network interface device structure
  * @indir: indirection table
  * @key: hash key
+ * @hfunc: hash function to use
  *
  * Returns -EINVAL if the table specifies an invalid queue id, otherwise
  * returns 0 after programming the table.
diff --git a/drivers/net/ethernet/intel/i40e/i40e_hmc.c b/drivers/net/ethernet/intel/i40e/i40e_hmc.c
index e40f3b5..19ce93d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_hmc.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_hmc.c
@@ -174,7 +174,6 @@ i40e_status i40e_add_pd_table_entry(struct i40e_hw *hw,
  * @hw: pointer to our HW structure
  * @hmc_info: pointer to the HMC configuration information structure
  * @idx: the page index
- * @is_pf: distinguishes a VF from a PF
  *
  * This function:
  *	1. Marks the entry in pd tabe (for paged address mode) or in sd table
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 41bad11..ad01bfc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -254,8 +254,8 @@ static int i40e_put_lump(struct i40e_lump_tracking *pile, u16 index, u16 id)
 
 /**
  * i40e_find_vsi_from_id - searches for the vsi with the given id
- * @pf - the pf structure to search for the vsi
- * @id - id of the vsi it is searching for
+ * @pf: the pf structure to search for the vsi
+ * @id: id of the vsi it is searching for
  **/
 struct i40e_vsi *i40e_find_vsi_from_id(struct i40e_pf *pf, u16 id)
 {
@@ -411,6 +411,7 @@ static void i40e_get_netdev_stats_struct_tx(struct i40e_ring *ring,
 /**
  * i40e_get_netdev_stats_struct - Get statistics for netdev interface
  * @netdev: network interface device structure
+ * @stats: data structure to store statistics
  *
  * Returns the address of the device statistics structure.
  * The statistics are actually updated from the service task.
@@ -2003,7 +2004,7 @@ struct i40e_new_mac_filter *i40e_next_filter(struct i40e_new_mac_filter *next)
  * from firmware
  * @count: Number of filters added
  * @add_list: return data from fw
- * @head: pointer to first filter in current batch
+ * @add_head: pointer to first filter in current batch
  *
  * MAC filter entries from list were slated to be added to device. Returns
  * number of successful filters. Note that 0 does NOT mean success!
@@ -2110,6 +2111,7 @@ void i40e_aqc_add_filters(struct i40e_vsi *vsi, const char *vsi_name,
 /**
  * i40e_aqc_broadcast_filter - Set promiscuous broadcast flags
  * @vsi: pointer to the VSI
+ * @vsi_name: the VSI name
  * @f: filter data
  *
  * This function sets or clears the promiscuous broadcast flags for VLAN
@@ -2816,6 +2818,7 @@ void i40e_vsi_kill_vlan(struct i40e_vsi *vsi, u16 vid)
 /**
  * i40e_vlan_rx_add_vid - Add a vlan id filter to HW offload
  * @netdev: network interface to be adjusted
+ * @proto: unused protocol value
  * @vid: vlan id to be added
  *
  * net_device_ops implementation for adding vlan ids
@@ -2840,6 +2843,7 @@ static int i40e_vlan_rx_add_vid(struct net_device *netdev,
 /**
  * i40e_vlan_rx_kill_vid - Remove a vlan id filter from HW offload
  * @netdev: network interface to be adjusted
+ * @proto: unused protocol value
  * @vid: vlan id to be removed
  *
  * net_device_ops implementation for removing vlan ids
@@ -3461,7 +3465,7 @@ static void i40e_vsi_configure_msix(struct i40e_vsi *vsi)
 
 /**
  * i40e_enable_misc_int_causes - enable the non-queue interrupts
- * @hw: ptr to the hardware info
+ * @pf: pointer to private device data structure
  **/
 static void i40e_enable_misc_int_causes(struct i40e_pf *pf)
 {
@@ -5072,7 +5076,7 @@ static int i40e_vsi_get_bw_info(struct i40e_vsi *vsi)
  * i40e_vsi_configure_bw_alloc - Configure VSI BW allocation per TC
  * @vsi: the VSI being configured
  * @enabled_tc: TC bitmap
- * @bw_credits: BW shared credits per TC
+ * @bw_share: BW shared credits per TC
  *
  * Returns 0 on success, negative value on failure
  **/
@@ -6329,6 +6333,7 @@ static int i40e_init_pf_dcb(struct i40e_pf *pf)
 /**
  * i40e_print_link_message - print link up or down
  * @vsi: the VSI for which link needs a message
+ * @isup: true of link is up, false otherwise
  */
 void i40e_print_link_message(struct i40e_vsi *vsi, bool isup)
 {
@@ -9980,7 +9985,7 @@ static int i40e_vsi_mem_alloc(struct i40e_pf *pf, enum i40e_vsi_type type)
 
 /**
  * i40e_vsi_free_arrays - Free queue and vector pointer arrays for the VSI
- * @type: VSI pointer
+ * @vsi: VSI pointer
  * @free_qvectors: a bool to specify if q_vectors need to be freed.
  *
  * On error: returns error code (negative)
@@ -10776,7 +10781,7 @@ int i40e_config_rss(struct i40e_vsi *vsi, u8 *seed, u8 *lut, u16 lut_size)
  * @vsi: Pointer to VSI structure
  * @seed: Buffer to store the keys
  * @lut: Buffer to store the lookup table entries
- * lut_size: Size of buffer to store the lookup table entries
+ * @lut_size: Size of buffer to store the lookup table entries
  *
  * Returns 0 on success, negative on failure
  */
@@ -11476,6 +11481,7 @@ static int i40e_get_phys_port_id(struct net_device *netdev,
  * @tb: pointer to array of nladdr (unused)
  * @dev: the net device pointer
  * @addr: the MAC address entry being added
+ * @vid: VLAN ID
  * @flags: instructions from stack about fdb operation
  */
 static int i40e_ndo_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
@@ -11521,6 +11527,7 @@ static int i40e_ndo_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
  * i40e_ndo_bridge_setlink - Set the hardware bridge mode
  * @dev: the netdev being configured
  * @nlh: RTNL message
+ * @flags: bridge flags
  *
  * Inserts a new hardware bridge if not already created and
  * enables the bridging mode requested (VEB or VEPA). If the
@@ -14094,6 +14101,7 @@ static void i40e_remove(struct pci_dev *pdev)
 /**
  * i40e_pci_error_detected - warning that something funky happened in PCI land
  * @pdev: PCI device information struct
+ * @error: the type of PCI error
  *
  * Called to warn that something happened and the error handling steps
  * are in progress.  Allows the driver to quiesce things, be ready for
diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 51554df..0299e5b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -1149,6 +1149,7 @@ void i40e_nvmupd_clear_wait_state(struct i40e_hw *hw)
  * i40e_nvmupd_check_wait_event - handle NVM update operation events
  * @hw: pointer to the hardware structure
  * @opcode: the event that just happened
+ * @desc: AdminQ descriptor
  **/
 void i40e_nvmupd_check_wait_event(struct i40e_hw *hw, u16 opcode,
 				  struct i40e_aq_desc *desc)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 47d10ad..43d7c44 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -483,7 +483,7 @@ void i40e_ptp_set_increment(struct i40e_pf *pf)
 /**
  * i40e_ptp_get_ts_config - ioctl interface to read the HW timestamping
  * @pf: Board private structure
- * @ifreq: ioctl data
+ * @ifr: ioctl data
  *
  * Obtain the current hardware timestamping settigs as requested. To do this,
  * keep a shadow copy of the timestamp settings rather than attempting to
@@ -627,7 +627,7 @@ static int i40e_ptp_set_timestamp_mode(struct i40e_pf *pf,
 /**
  * i40e_ptp_set_ts_config - ioctl interface to control the HW timestamping
  * @pf: Board private structure
- * @ifreq: ioctl data
+ * @ifr: ioctl data
  *
  * Respond to the user filter requests and make the appropriate hardware
  * changes here. The XL710 cannot support splitting of the Tx/Rx timestamping
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 6959897..5efa68d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -471,7 +471,7 @@ static int i40e_add_del_fdir_ipv4(struct i40e_vsi *vsi,
 /**
  * i40e_add_del_fdir - Build raw packets to add/del fdir filter
  * @vsi: pointer to the targeted VSI
- * @cmd: command to get or set RX flow classification rules
+ * @input: filter to add or delete
  * @add: true adds a filter, false removes it
  *
  **/
@@ -689,7 +689,7 @@ void i40e_free_tx_resources(struct i40e_ring *tx_ring)
 
 /**
  * i40e_get_tx_pending - how many tx descriptors not processed
- * @tx_ring: the ring of descriptors
+ * @ring: the ring of descriptors
  * @in_sw: use SW variables
  *
  * Since there is no access to the ring head register
@@ -1771,6 +1771,8 @@ static inline int i40e_ptype_to_htype(u8 ptype)
  * i40e_rx_hash - set the hash value in the skb
  * @ring: descriptor ring
  * @rx_desc: specific descriptor
+ * @skb: skb currently being received and modified
+ * @rx_ptype: Rx packet type
  **/
 static inline void i40e_rx_hash(struct i40e_ring *ring,
 				union i40e_rx_desc *rx_desc,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 3e7ab9f..2ceea63 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -8,8 +8,8 @@
 /**
  * i40e_vc_vf_broadcast
  * @pf: pointer to the PF structure
- * @opcode: operation code
- * @retval: return value
+ * @v_opcode: operation code
+ * @v_retval: return value
  * @msg: pointer to the msg buffer
  * @msglen: msg length
  *
@@ -1639,6 +1639,7 @@ static int i40e_vc_send_resp_to_vf(struct i40e_vf *vf,
 /**
  * i40e_vc_get_version_msg
  * @vf: pointer to the VF info
+ * @msg: pointer to the msg buffer
  *
  * called from the VF to request the API version used by the PF
  **/
@@ -1682,7 +1683,6 @@ static void i40e_del_qch(struct i40e_vf *vf)
  * i40e_vc_get_vf_resources_msg
  * @vf: pointer to the VF info
  * @msg: pointer to the msg buffer
- * @msglen: msg length
  *
  * called from the VF to request its resources
  **/
@@ -1806,8 +1806,6 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 /**
  * i40e_vc_reset_vf_msg
  * @vf: pointer to the VF info
- * @msg: pointer to the msg buffer
- * @msglen: msg length
  *
  * called from the VF to reset itself,
  * unlike other virtchnl messages, PF driver
@@ -3532,15 +3530,16 @@ static int i40e_vc_del_qch_msg(struct i40e_vf *vf, u8 *msg)
  * i40e_vc_process_vf_msg
  * @pf: pointer to the PF structure
  * @vf_id: source VF id
+ * @v_opcode: operation code
+ * @v_retval: unused return value code
  * @msg: pointer to the msg buffer
  * @msglen: msg length
- * @msghndl: msg handle
  *
  * called from the common aeq/arq handler to
  * process request from VF
  **/
 int i40e_vc_process_vf_msg(struct i40e_pf *pf, s16 vf_id, u32 v_opcode,
-			   u32 v_retval, u8 *msg, u16 msglen)
+			   u32 __always_unused v_retval, u8 *msg, u16 msglen)
 {
 	struct i40e_hw *hw = &pf->hw;
 	int local_vf_id = vf_id - (s16)hw->func_caps.vf_base_id;
@@ -3991,7 +3990,8 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev, int vf_id,
  * i40e_ndo_set_vf_bw
  * @netdev: network interface device structure
  * @vf_id: VF identifier
- * @tx_rate: Tx rate
+ * @min_tx_rate: Minimum Tx rate
+ * @max_tx_rate: Maximum Tx rate
  *
  * configure VF Tx rate
  **/
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_common.c b/drivers/net/ethernet/intel/i40evf/i40e_common.c
index 0841b2d..9cef549 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_common.c
@@ -1231,6 +1231,7 @@ i40e_status_code i40evf_aq_write_ddp(struct i40e_hw *hw, void *buff,
  * @hw: pointer to the hw struct
  * @buff: command buffer (size in bytes = buff_size)
  * @buff_size: buffer size in bytes
+ * @flags: AdminQ command flags
  * @cmd_details: pointer to command details structure or NULL
  **/
 enum
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 87101f5..a973071 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -105,7 +105,7 @@ void i40evf_free_tx_resources(struct i40e_ring *tx_ring)
 
 /**
  * i40evf_get_tx_pending - how many Tx descriptors not processed
- * @tx_ring: the ring of descriptors
+ * @ring: the ring of descriptors
  * @in_sw: is tx_pending being checked in SW or HW
  *
  * Since there is no access to the ring head register
@@ -1046,6 +1046,8 @@ static inline int i40e_ptype_to_htype(u8 ptype)
  * i40e_rx_hash - set the hash value in the skb
  * @ring: descriptor ring
  * @rx_desc: specific descriptor
+ * @skb: skb currently being received and modified
+ * @rx_ptype: Rx packet type
  **/
 static inline void i40e_rx_hash(struct i40e_ring *ring,
 				union i40e_rx_desc *rx_desc,
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_client.c b/drivers/net/ethernet/intel/i40evf/i40evf_client.c
index a30d093..3cc9d60 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_client.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_client.c
@@ -178,7 +178,6 @@ void i40evf_notify_client_close(struct i40e_vsi *vsi, bool reset)
 /**
  * i40evf_client_add_instance - add a client instance to the instance list
  * @adapter: pointer to the board struct
- * @client: pointer to a client struct in the client list.
  *
  * Returns cinst ptr on success, NULL on failure
  **/
@@ -236,7 +235,6 @@ i40evf_client_add_instance(struct i40evf_adapter *adapter)
 /**
  * i40evf_client_del_instance - removes a client instance from the list
  * @adapter: pointer to the board struct
- * @client: pointer to the client struct
  *
  **/
 static
@@ -440,7 +438,7 @@ static u32 i40evf_client_virtchnl_send(struct i40e_info *ldev,
  * i40evf_client_setup_qvlist - send a message to the PF to setup iwarp qv map
  * @ldev: pointer to L2 context.
  * @client: Client pointer.
- * @qv_info: queue and vector list
+ * @qvlist_info: queue and vector list
  *
  * Return 0 on success or < 0 on error
  **/
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
index 404595e..69efe0a 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
@@ -202,7 +202,7 @@ static void i40evf_get_strings(struct net_device *netdev, u32 sset, u8 *data)
 
 /**
  * i40evf_get_priv_flags - report device private flags
- * @dev: network interface device structure
+ * @netdev: network interface device structure
  *
  * The get string set count and the string set should be matched for each
  * flag returned.  Add new strings for each flag to the i40e_gstrings_priv_flags
@@ -229,7 +229,7 @@ static u32 i40evf_get_priv_flags(struct net_device *netdev)
 
 /**
  * i40evf_set_priv_flags - set private flags
- * @dev: network interface device structure
+ * @netdev: network interface device structure
  * @flags: bit flags to be set
  **/
 static int i40evf_set_priv_flags(struct net_device *netdev, u32 flags)
@@ -603,6 +603,7 @@ static int i40evf_set_per_queue_coalesce(struct net_device *netdev,
  * i40evf_get_rxnfc - command to get RX flow classification rules
  * @netdev: network interface device structure
  * @cmd: ethtool rxnfc command
+ * @rule_locs: pointer to store rule locations
  *
  * Returns Success if the command is supported.
  **/
@@ -722,6 +723,7 @@ static u32 i40evf_get_rxfh_indir_size(struct net_device *netdev)
  * @netdev: network interface device structure
  * @indir: indirection table
  * @key: hash key
+ * @hfunc: hash function in use
  *
  * Reads the indirection table directly from the hardware. Always returns 0.
  **/
@@ -750,6 +752,7 @@ static int i40evf_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key,
  * @netdev: network interface device structure
  * @indir: indirection table
  * @key: hash key
+ * @hfunc: hash function to use
  *
  * Returns -EINVAL if the table specifies an inavlid queue id, otherwise
  * returns 0 after programming the table.
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 8f775a8..28a8cc4 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -449,6 +449,7 @@ static void i40evf_irq_affinity_release(struct kref *ref) {}
 /**
  * i40evf_request_traffic_irqs - Initialize MSI-X interrupts
  * @adapter: board private structure
+ * @basename: device basename
  *
  * Allocates MSI-X vectors for tx and rx handling, and requests
  * interrupts from the kernel.
@@ -721,6 +722,7 @@ static void i40evf_del_vlan(struct i40evf_adapter *adapter, u16 vlan)
 /**
  * i40evf_vlan_rx_add_vid - Add a VLAN filter to a device
  * @netdev: network device struct
+ * @proto: unused protocol data
  * @vid: VLAN tag
  **/
 static int i40evf_vlan_rx_add_vid(struct net_device *netdev,
@@ -738,6 +740,7 @@ static int i40evf_vlan_rx_add_vid(struct net_device *netdev,
 /**
  * i40evf_vlan_rx_kill_vid - Remove a VLAN filter from a device
  * @netdev: network device struct
+ * @proto: unused protocol data
  * @vid: VLAN tag
  **/
 static int i40evf_vlan_rx_kill_vid(struct net_device *netdev,
@@ -3136,7 +3139,7 @@ static int i40evf_set_features(struct net_device *netdev,
 /**
  * i40evf_features_check - Validate encapsulated packet conforms to limits
  * @skb: skb buff
- * @netdev: This physical port's netdev
+ * @dev: This physical port's netdev
  * @features: Offload features that the stack believes apply
  **/
 static netdev_features_t i40evf_features_check(struct sk_buff *skb,
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index 8bcefb7..565677d 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -155,8 +155,7 @@ int i40evf_send_vf_config_msg(struct i40evf_adapter *adapter)
 
 /**
  * i40evf_get_vf_config
- * @hw: pointer to the hardware structure
- * @len: length of buffer
+ * @adapter: private adapter structure
  *
  * Get VF configuration from PF and populate hw structure. Must be called after
  * admin queue is initialized. Busy waits until response is received from PF,
@@ -399,8 +398,6 @@ int i40evf_request_queues(struct i40evf_adapter *adapter, int num)
 /**
  * i40evf_add_ether_addrs
  * @adapter: adapter structure
- * @addrs: the MAC address filters to add (contiguous)
- * @count: number of filters
  *
  * Request that the PF add one or more addresses to our filters.
  **/
@@ -473,8 +470,6 @@ void i40evf_add_ether_addrs(struct i40evf_adapter *adapter)
 /**
  * i40evf_del_ether_addrs
  * @adapter: adapter structure
- * @addrs: the MAC address filters to remove (contiguous)
- * @count: number of filtes
  *
  * Request that the PF remove one or more addresses from our filters.
  **/
@@ -547,8 +542,6 @@ void i40evf_del_ether_addrs(struct i40evf_adapter *adapter)
 /**
  * i40evf_add_vlans
  * @adapter: adapter structure
- * @vlans: the VLANs to add
- * @count: number of VLANs
  *
  * Request that the PF add one or more VLAN filters to our VSI.
  **/
@@ -619,8 +612,6 @@ void i40evf_add_vlans(struct i40evf_adapter *adapter)
 /**
  * i40evf_del_vlans
  * @adapter: adapter structure
- * @vlans: the VLANs to remove
- * @count: number of VLANs
  *
  * Request that the PF remove one or more VLAN filters from our VSI.
  **/
-- 
2.9.5

