From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Fri, 22 Feb 2019 22:28:36 +0000
Subject: [Intel-wired-lan] [PATCH S13 04/16] ice: fix some function
 prototype and signature style issues
In-Reply-To: <20190208205112.12180-5-anirudh.venkataramanan@intel.com>
References: <20190208205112.12180-1-anirudh.venkataramanan@intel.com>
 <20190208205112.12180-5-anirudh.venkataramanan@intel.com>
Message-ID: <804857E1F29AAC47BF68C404FC60A1840104F590B0@ORSMSX121.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Anirudh Venkataramanan
> Sent: Friday, February 08, 2019 12:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S13 04/16] ice: fix some function prototype
> and signature style issues
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> Put the return type on a separate line for function prototypes and
> signatures that would exceed the 80-character limit if both were on
> the same line.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up
> commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice.h             |  5 ++-
>  drivers/net/ethernet/intel/ice/ice_common.c      | 35 +++++++++--------
>  drivers/net/ethernet/intel/ice/ice_common.h      | 18 +++++----
>  drivers/net/ethernet/intel/ice/ice_ethtool.c     | 25 +++++++-----
>  drivers/net/ethernet/intel/ice/ice_lib.c         |  5 ++-
>  drivers/net/ethernet/intel/ice/ice_main.c        | 34 +++++++++--------
>  drivers/net/ethernet/intel/ice/ice_switch.c      |  4 +-
>  drivers/net/ethernet/intel/ice/ice_switch.h      |  3 +-
>  drivers/net/ethernet/intel/ice/ice_txrx.c        | 48 ++++++++++++------------
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c |  9 +++--
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h | 14 ++++---
>  11 files changed, 111 insertions(+), 89 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h
> b/drivers/net/ethernet/intel/ice/ice.h
> index 652dbfb5ab4e..ccacfd720436 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -369,8 +369,9 @@ struct ice_netdev_priv {
>   * @vsi: pointer to vsi struct, can be NULL
>   * @q_vector: pointer to q_vector, can be NULL
>   */
> -static inline void ice_irq_dynamic_ena(struct ice_hw *hw, struct ice_vsi *vsi,
> -				       struct ice_q_vector *q_vector)
> +static inline void
> +ice_irq_dynamic_ena(struct ice_hw *hw, struct ice_vsi *vsi,
> +		    struct ice_q_vector *q_vector)
>  {
>  	u32 vector = (vsi && q_vector) ? vsi->hw_base_vector + q_vector-
> >v_idx :
>  				((struct ice_pf *)hw->back)->hw_oicr_idx;
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c
> b/drivers/net/ethernet/intel/ice/ice_common.c
> index db6ec77506df..06a1a2cb5358 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -1100,8 +1100,9 @@ const struct ice_ctx_ele ice_tlan_ctx_info[] = {
>   *
>   * Dumps debug log about control command with descriptor contents.
>   */
> -void ice_debug_cq(struct ice_hw *hw, u32 __maybe_unused mask, void
> *desc,
> -		  void *buf, u16 buf_len)
> +void
> +ice_debug_cq(struct ice_hw *hw, u32 __maybe_unused mask, void *desc,
> void *buf,
> +	     u16 buf_len)
>  {
>  	struct ice_aq_desc *cq_desc = (struct ice_aq_desc *)desc;
>  	u16 len;
> @@ -1620,8 +1621,8 @@ ice_aq_discover_caps(struct ice_hw *hw, void *buf,
> u16 buf_size, u32 *cap_count,
>   * @hw: pointer to the hardware structure
>   * @opc: capabilities type to discover - pass in the command opcode
>   */
> -static enum ice_status ice_discover_caps(struct ice_hw *hw,
> -					 enum ice_adminq_opc opc)
> +static enum ice_status
> +ice_discover_caps(struct ice_hw *hw, enum ice_adminq_opc opc)
>  {
>  	enum ice_status status;
>  	u32 cap_count;
> @@ -2548,8 +2549,8 @@ ice_aq_dis_lan_txq(struct ice_hw *hw, u8
> num_qgrps,
>   * @dest_ctx: the context to be written to
>   * @ce_info:  a description of the struct to be filled
>   */
> -static void ice_write_byte(u8 *src_ctx, u8 *dest_ctx,
> -			   const struct ice_ctx_ele *ce_info)
> +static void
> +ice_write_byte(u8 *src_ctx, u8 *dest_ctx, const struct ice_ctx_ele *ce_info)
>  {
>  	u8 src_byte, dest_byte, mask;
>  	u8 *from, *dest;
> @@ -2587,8 +2588,8 @@ static void ice_write_byte(u8 *src_ctx, u8 *dest_ctx,
>   * @dest_ctx: the context to be written to
>   * @ce_info:  a description of the struct to be filled
>   */
> -static void ice_write_word(u8 *src_ctx, u8 *dest_ctx,
> -			   const struct ice_ctx_ele *ce_info)
> +static void
> +ice_write_word(u8 *src_ctx, u8 *dest_ctx, const struct ice_ctx_ele *ce_info)
>  {
>  	u16 src_word, mask;
>  	__le16 dest_word;
> @@ -2630,8 +2631,8 @@ static void ice_write_word(u8 *src_ctx, u8
> *dest_ctx,
>   * @dest_ctx: the context to be written to
>   * @ce_info:  a description of the struct to be filled
>   */
> -static void ice_write_dword(u8 *src_ctx, u8 *dest_ctx,
> -			    const struct ice_ctx_ele *ce_info)
> +static void
> +ice_write_dword(u8 *src_ctx, u8 *dest_ctx, const struct ice_ctx_ele *ce_info)
>  {
>  	u32 src_dword, mask;
>  	__le32 dest_dword;
> @@ -2681,8 +2682,8 @@ static void ice_write_dword(u8 *src_ctx, u8
> *dest_ctx,
>   * @dest_ctx: the context to be written to
>   * @ce_info:  a description of the struct to be filled
>   */
> -static void ice_write_qword(u8 *src_ctx, u8 *dest_ctx,
> -			    const struct ice_ctx_ele *ce_info)
> +static void
> +ice_write_qword(u8 *src_ctx, u8 *dest_ctx, const struct ice_ctx_ele *ce_info)
>  {
>  	u64 src_qword, mask;
>  	__le64 dest_qword;
> @@ -3026,8 +3027,9 @@ void ice_replay_post(struct ice_hw *hw)
>   * @prev_stat: ptr to previous loaded stat value
>   * @cur_stat: ptr to current stat value
>   */
> -void ice_stat_update40(struct ice_hw *hw, u32 hireg, u32 loreg,
> -		       bool prev_stat_loaded, u64 *prev_stat, u64 *cur_stat)
> +void
> +ice_stat_update40(struct ice_hw *hw, u32 hireg, u32 loreg,
> +		  bool prev_stat_loaded, u64 *prev_stat, u64 *cur_stat)
>  {
>  	u64 new_data;
> 
> @@ -3057,8 +3059,9 @@ void ice_stat_update40(struct ice_hw *hw, u32
> hireg, u32 loreg,
>   * @prev_stat: ptr to previous loaded stat value
>   * @cur_stat: ptr to current stat value
>   */
> -void ice_stat_update32(struct ice_hw *hw, u32 reg, bool prev_stat_loaded,
> -		       u64 *prev_stat, u64 *cur_stat)
> +void
> +ice_stat_update32(struct ice_hw *hw, u32 reg, bool prev_stat_loaded,
> +		  u64 *prev_stat, u64 *cur_stat)
>  {
>  	u32 new_data;
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.h
> b/drivers/net/ethernet/intel/ice/ice_common.h
> index d7c7c2ed8823..38578f7c3622 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.h
> +++ b/drivers/net/ethernet/intel/ice/ice_common.h
> @@ -9,8 +9,8 @@
>  #include "ice_switch.h"
>  #include <linux/avf/virtchnl.h>
> 
> -void ice_debug_cq(struct ice_hw *hw, u32 mask, void *desc, void *buf,
> -		  u16 buf_len);
> +void
> +ice_debug_cq(struct ice_hw *hw, u32 mask, void *desc, void *buf, u16
> buf_len);
>  enum ice_status ice_init_hw(struct ice_hw *hw);
>  void ice_deinit_hw(struct ice_hw *hw);
>  enum ice_status ice_check_reset(struct ice_hw *hw);
> @@ -28,8 +28,8 @@ ice_acquire_res(struct ice_hw *hw, enum ice_aq_res_ids
> res,
>  		enum ice_aq_res_access_type access, u32 timeout);
>  void ice_release_res(struct ice_hw *hw, enum ice_aq_res_ids res);
>  enum ice_status ice_init_nvm(struct ice_hw *hw);
> -enum ice_status ice_read_sr_buf(struct ice_hw *hw, u16 offset, u16 *words,
> -				u16 *data);
> +enum ice_status
> +ice_read_sr_buf(struct ice_hw *hw, u16 offset, u16 *words, u16 *data);
>  enum ice_status
>  ice_sq_send_cmd(struct ice_hw *hw, struct ice_ctl_q_info *cq,
>  		struct ice_aq_desc *desc, void *buf, u16 buf_size,
> @@ -106,8 +106,10 @@ ice_ena_vsi_txq(struct ice_port_info *pi, u16
> vsi_handle, u8 tc, u8 num_qgrps,
>  enum ice_status ice_replay_vsi(struct ice_hw *hw, u16 vsi_handle);
>  void ice_replay_post(struct ice_hw *hw);
>  void ice_output_fw_log(struct ice_hw *hw, struct ice_aq_desc *desc, void
> *buf);
> -void ice_stat_update40(struct ice_hw *hw, u32 hireg, u32 loreg,
> -		       bool prev_stat_loaded, u64 *prev_stat, u64 *cur_stat);
> -void ice_stat_update32(struct ice_hw *hw, u32 reg, bool prev_stat_loaded,
> -		       u64 *prev_stat, u64 *cur_stat);
> +void
> +ice_stat_update40(struct ice_hw *hw, u32 hireg, u32 loreg,
> +		  bool prev_stat_loaded, u64 *prev_stat, u64 *cur_stat);
> +void
> +ice_stat_update32(struct ice_hw *hw, u32 reg, bool prev_stat_loaded,
> +		  u64 *prev_stat, u64 *cur_stat);
>  #endif /* _ICE_COMMON_H_ */
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index b906c7d15d46..a76292988c18 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -1156,8 +1156,9 @@ ice_get_settings_link_down(struct
> ethtool_link_ksettings *ks,
>   *
>   * Reports speed/duplex settings based on media_type
>   */
> -static int ice_get_link_ksettings(struct net_device *netdev,
> -				  struct ethtool_link_ksettings *ks)
> +static int
> +ice_get_link_ksettings(struct net_device *netdev,
> +		       struct ethtool_link_ksettings *ks)
>  {
>  	struct ice_netdev_priv *np = netdev_priv(netdev);
>  	struct ice_link_status *hw_link_info;
> @@ -1565,8 +1566,9 @@ ice_set_link_ksettings(struct net_device *netdev,
>   *
>   * Returns Success if the command is supported.
>   */
> -static int ice_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
> -			 u32 __always_unused *rule_locs)
> +static int
> +ice_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
> +	      u32 __always_unused *rule_locs)
>  {
>  	struct ice_netdev_priv *np = netdev_priv(netdev);
>  	struct ice_vsi *vsi = np->vsi;
> @@ -2023,8 +2025,9 @@ ice_get_rxfh(struct net_device *netdev, u32 *indir,
> u8 *key, u8 *hfunc)
>   * Returns -EINVAL if the table specifies an invalid queue id, otherwise
>   * returns 0 after programming the table.
>   */
> -static int ice_set_rxfh(struct net_device *netdev, const u32 *indir,
> -			const u8 *key, const u8 hfunc)
> +static int
> +ice_set_rxfh(struct net_device *netdev, const u32 *indir, const u8 *key,
> +	     const u8 hfunc)
>  {
>  	struct ice_netdev_priv *np = netdev_priv(netdev);
>  	struct ice_vsi *vsi = np->vsi;
> @@ -2262,8 +2265,9 @@ ice_get_coalesce(struct net_device *netdev, struct
> ethtool_coalesce *ec)
>  	return __ice_get_coalesce(netdev, ec, -1);
>  }
> 
> -static int ice_get_per_q_coalesce(struct net_device *netdev, u32 q_num,
> -				  struct ethtool_coalesce *ec)
> +static int
> +ice_get_per_q_coalesce(struct net_device *netdev, u32 q_num,
> +		       struct ethtool_coalesce *ec)
>  {
>  	return __ice_get_coalesce(netdev, ec, q_num);
>  }
> @@ -2407,8 +2411,9 @@ ice_set_coalesce(struct net_device *netdev, struct
> ethtool_coalesce *ec)
>  	return __ice_set_coalesce(netdev, ec, -1);
>  }
> 
> -static int ice_set_per_q_coalesce(struct net_device *netdev, u32 q_num,
> -				  struct ethtool_coalesce *ec)
> +static int
> +ice_set_per_q_coalesce(struct net_device *netdev, u32 q_num,
> +		       struct ethtool_coalesce *ec)
>  {
>  	return __ice_set_coalesce(netdev, ec, q_num);
>  }
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c
> b/drivers/net/ethernet/intel/ice/ice_lib.c
> index f33097bcc4ae..6be1fd391da0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -2133,8 +2133,9 @@ ice_vsi_stop_tx_rings(struct ice_vsi *vsi, enum
> ice_disq_rst_src rst_src,
>   * @rst_src: reset source
>   * @rel_vmvf_num: Relative id of VF/VM
>   */
> -int ice_vsi_stop_lan_tx_rings(struct ice_vsi *vsi,
> -			      enum ice_disq_rst_src rst_src, u16 rel_vmvf_num)
> +int
> +ice_vsi_stop_lan_tx_rings(struct ice_vsi *vsi, enum ice_disq_rst_src rst_src,
> +			  u16 rel_vmvf_num)
>  {
>  	return ice_vsi_stop_tx_rings(vsi, rst_src, rel_vmvf_num, vsi->tx_rings,
>  				     0);
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index f43ce0e4f82f..ff95e5aceb41 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -1113,8 +1113,9 @@ static void ice_set_ctrlq_len(struct ice_hw *hw)
>   * This is a callback function used by the irq_set_affinity_notifier function
>   * so that we may register to receive changes to the irq affinity masks.
>   */
> -static void ice_irq_affinity_notify(struct irq_affinity_notify *notify,
> -				    const cpumask_t *mask)
> +static void
> +ice_irq_affinity_notify(struct irq_affinity_notify *notify,
> +			const cpumask_t *mask)
>  {
>  	struct ice_q_vector *q_vector =
>  		container_of(notify, struct ice_q_vector, affinity_notify);
> @@ -1658,8 +1659,9 @@ ice_pf_vsi_setup(struct ice_pf *pf, struct
> ice_port_info *pi)
>   *
>   * net_device_ops implementation for adding vlan ids
>   */
> -static int ice_vlan_rx_add_vid(struct net_device *netdev,
> -			       __always_unused __be16 proto, u16 vid)
> +static int
> +ice_vlan_rx_add_vid(struct net_device *netdev, __always_unused __be16
> proto,
> +		    u16 vid)
>  {
>  	struct ice_netdev_priv *np = netdev_priv(netdev);
>  	struct ice_vsi *vsi = np->vsi;
> @@ -1696,8 +1698,9 @@ static int ice_vlan_rx_add_vid(struct net_device
> *netdev,
>   *
>   * net_device_ops implementation for removing vlan ids
>   */
> -static int ice_vlan_rx_kill_vid(struct net_device *netdev,
> -				__always_unused __be16 proto, u16 vid)
> +static int
> +ice_vlan_rx_kill_vid(struct net_device *netdev, __always_unused __be16
> proto,
> +		     u16 vid)
>  {
>  	struct ice_netdev_priv *np = netdev_priv(netdev);
>  	struct ice_vsi *vsi = np->vsi;
> @@ -2057,8 +2060,8 @@ static void ice_verify_cacheline_size(struct ice_pf
> *pf)
>   *
>   * Returns 0 on success, negative on failure
>   */
> -static int ice_probe(struct pci_dev *pdev,
> -		     const struct pci_device_id __always_unused *ent)
> +static int
> +ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused
> *ent)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct ice_pf *pf;
> @@ -2493,9 +2496,10 @@ ice_fdb_add(struct ndmsg *ndm, struct nlattr
> __always_unused *tb[],
>   * @addr: the MAC address entry being added
>   * @vid: VLAN id
>   */
> -static int ice_fdb_del(struct ndmsg *ndm, __always_unused struct nlattr *tb[],
> -		       struct net_device *dev, const unsigned char *addr,
> -		       __always_unused u16 vid)
> +static int
> +ice_fdb_del(struct ndmsg *ndm, __always_unused struct nlattr *tb[],
> +	    struct net_device *dev, const unsigned char *addr,
> +	    __always_unused u16 vid)
>  {
>  	int err;
> 
> @@ -2519,8 +2523,8 @@ static int ice_fdb_del(struct ndmsg *ndm,
> __always_unused struct nlattr *tb[],
>   * @netdev: ptr to the netdev being adjusted
>   * @features: the feature set that the stack is suggesting
>   */
> -static int ice_set_features(struct net_device *netdev,
> -			    netdev_features_t features)
> +static int
> +ice_set_features(struct net_device *netdev, netdev_features_t features)
>  {
>  	struct ice_netdev_priv *np = netdev_priv(netdev);
>  	struct ice_vsi *vsi = np->vsi;
> @@ -2674,8 +2678,8 @@ int ice_up(struct ice_vsi *vsi)
>   * This function fetches stats from the ring considering the atomic operations
>   * that needs to be performed to read u64 values in 32 bit machine.
>   */
> -static void ice_fetch_u64_stats_per_ring(struct ice_ring *ring, u64 *pkts,
> -					 u64 *bytes)
> +static void
> +ice_fetch_u64_stats_per_ring(struct ice_ring *ring, u64 *pkts, u64 *bytes)
>  {
>  	unsigned int start;
>  	*pkts = 0;
> diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c
> b/drivers/net/ethernet/intel/ice/ice_switch.c
> index 2a30caef6687..cf5bada75a7e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_switch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_switch.c
> @@ -322,8 +322,8 @@ struct ice_vsi_ctx *ice_get_vsi_ctx(struct ice_hw *hw,
> u16 vsi_handle)
>   *
>   * save the VSI context entry for a given VSI handle
>   */
> -static void ice_save_vsi_ctx(struct ice_hw *hw, u16 vsi_handle,
> -			     struct ice_vsi_ctx *vsi)
> +static void
> +ice_save_vsi_ctx(struct ice_hw *hw, u16 vsi_handle, struct ice_vsi_ctx *vsi)
>  {
>  	hw->vsi_ctx[vsi_handle] = vsi;
>  }
> diff --git a/drivers/net/ethernet/intel/ice/ice_switch.h
> b/drivers/net/ethernet/intel/ice/ice_switch.h
> index d5ef0bd58bf9..2d3a2dfcb0de 100644
> --- a/drivers/net/ethernet/intel/ice/ice_switch.h
> +++ b/drivers/net/ethernet/intel/ice/ice_switch.h
> @@ -199,7 +199,8 @@ enum ice_status
> ice_update_sw_rule_bridge_mode(struct ice_hw *hw);
>  enum ice_status ice_add_mac(struct ice_hw *hw, struct list_head *m_lst);
>  enum ice_status ice_remove_mac(struct ice_hw *hw, struct list_head *m_lst);
>  void ice_remove_vsi_fltr(struct ice_hw *hw, u16 vsi_handle);
> -enum ice_status ice_add_vlan(struct ice_hw *hw, struct list_head *m_list);
> +enum ice_status
> +ice_add_vlan(struct ice_hw *hw, struct list_head *m_list);
>  enum ice_status ice_remove_vlan(struct ice_hw *hw, struct list_head *v_list);
>  enum ice_status
>  ice_cfg_dflt_vsi(struct ice_hw *hw, u16 vsi_handle, bool set, u8 direction);
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c
> b/drivers/net/ethernet/intel/ice/ice_txrx.c
> index fad308c936b2..64baedee6336 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> @@ -100,8 +100,8 @@ void ice_free_tx_ring(struct ice_ring *tx_ring)
>   *
>   * Returns true if there's any budget left (e.g. the clean is finished)
>   */
> -static bool ice_clean_tx_irq(struct ice_vsi *vsi, struct ice_ring *tx_ring,
> -			     int napi_budget)
> +static bool
> +ice_clean_tx_irq(struct ice_vsi *vsi, struct ice_ring *tx_ring, int napi_budget)
>  {
>  	unsigned int total_bytes = 0, total_pkts = 0;
>  	unsigned int budget = vsi->work_lmt;
> @@ -389,8 +389,8 @@ static void ice_release_rx_desc(struct ice_ring
> *rx_ring, u32 val)
>   * Returns true if the page was successfully allocated or
>   * reused.
>   */
> -static bool ice_alloc_mapped_page(struct ice_ring *rx_ring,
> -				  struct ice_rx_buf *bi)
> +static bool
> +ice_alloc_mapped_page(struct ice_ring *rx_ring, struct ice_rx_buf *bi)
>  {
>  	struct page *page = bi->page;
>  	dma_addr_t dma;
> @@ -510,9 +510,9 @@ static bool ice_page_is_reserved(struct page *page)
>   * The function will then update the page offset if necessary and return
>   * true if the buffer can be reused by the adapter.
>   */
> -static bool ice_add_rx_frag(struct ice_rx_buf *rx_buf,
> -			    union ice_32b_rx_flex_desc *rx_desc,
> -			    struct sk_buff *skb)
> +static bool
> +ice_add_rx_frag(struct ice_rx_buf *rx_buf, union ice_32b_rx_flex_desc
> *rx_desc,
> +		struct sk_buff *skb)
>  {
>  #if (PAGE_SIZE < 8192)
>  	unsigned int truesize = ICE_RXBUF_2048;
> @@ -587,8 +587,8 @@ static bool ice_add_rx_frag(struct ice_rx_buf *rx_buf,
>   *
>   * Synchronizes page for reuse by the adapter
>   */
> -static void ice_reuse_rx_page(struct ice_ring *rx_ring,
> -			      struct ice_rx_buf *old_buf)
> +static void
> +ice_reuse_rx_page(struct ice_ring *rx_ring, struct ice_rx_buf *old_buf)
>  {
>  	u16 nta = rx_ring->next_to_alloc;
>  	struct ice_rx_buf *new_buf;
> @@ -613,8 +613,8 @@ static void ice_reuse_rx_page(struct ice_ring *rx_ring,
>   * correctly, as well as handling calling the page recycle function if
>   * necessary.
>   */
> -static struct sk_buff *ice_fetch_rx_buf(struct ice_ring *rx_ring,
> -					union ice_32b_rx_flex_desc *rx_desc)
> +static struct sk_buff *
> +ice_fetch_rx_buf(struct ice_ring *rx_ring, union ice_32b_rx_flex_desc
> *rx_desc)
>  {
>  	struct ice_rx_buf *rx_buf;
>  	struct sk_buff *skb;
> @@ -751,8 +751,8 @@ static bool ice_cleanup_headers(struct sk_buff *skb)
>   * The status_error_len doesn't need to be shifted because it begins
>   * at offset zero.
>   */
> -static bool ice_test_staterr(union ice_32b_rx_flex_desc *rx_desc,
> -			     const u16 stat_err_bits)
> +static bool
> +ice_test_staterr(union ice_32b_rx_flex_desc *rx_desc, const u16
> stat_err_bits)
>  {
>  	return !!(rx_desc->wb.status_error0 &
>  		  cpu_to_le16(stat_err_bits));
> @@ -769,9 +769,9 @@ static bool ice_test_staterr(union
> ice_32b_rx_flex_desc *rx_desc,
>   * sk_buff in the next buffer to be chained and return true indicating
>   * that this is in fact a non-EOP buffer.
>   */
> -static bool ice_is_non_eop(struct ice_ring *rx_ring,
> -			   union ice_32b_rx_flex_desc *rx_desc,
> -			   struct sk_buff *skb)
> +static bool
> +ice_is_non_eop(struct ice_ring *rx_ring, union ice_32b_rx_flex_desc
> *rx_desc,
> +	       struct sk_buff *skb)
>  {
>  	u32 ntc = rx_ring->next_to_clean + 1;
> 
> @@ -838,8 +838,9 @@ ice_rx_hash(struct ice_ring *rx_ring, union
> ice_32b_rx_flex_desc *rx_desc,
>   *
>   * skb->protocol must be set before this function is called
>   */
> -static void ice_rx_csum(struct ice_vsi *vsi, struct sk_buff *skb,
> -			union ice_32b_rx_flex_desc *rx_desc, u8 ptype)
> +static void
> +ice_rx_csum(struct ice_vsi *vsi, struct sk_buff *skb,
> +	    union ice_32b_rx_flex_desc *rx_desc, u8 ptype)
>  {
>  	struct ice_rx_ptype_decoded decoded;
>  	u32 rx_error, rx_status;
> @@ -909,9 +910,10 @@ static void ice_rx_csum(struct ice_vsi *vsi, struct
> sk_buff *skb,
>   * order to populate the hash, checksum, VLAN, protocol, and
>   * other fields within the skb.
>   */
> -static void ice_process_skb_fields(struct ice_ring *rx_ring,
> -				   union ice_32b_rx_flex_desc *rx_desc,
> -				   struct sk_buff *skb, u8 ptype)
> +static void
> +ice_process_skb_fields(struct ice_ring *rx_ring,
> +		       union ice_32b_rx_flex_desc *rx_desc,
> +		       struct sk_buff *skb, u8 ptype)
>  {
>  	ice_rx_hash(rx_ring, rx_desc, skb, ptype);
> 
> @@ -930,8 +932,8 @@ static void ice_process_skb_fields(struct ice_ring
> *rx_ring,
>   * This function sends the completed packet (via. skb) up the stack using
>   * gro receive functions (with/without vlan tag)
>   */
> -static void ice_receive_skb(struct ice_ring *rx_ring, struct sk_buff *skb,
> -			    u16 vlan_tag)
> +static void
> +ice_receive_skb(struct ice_ring *rx_ring, struct sk_buff *skb, u16 vlan_tag)
>  {
>  	if ((rx_ring->netdev->features & NETIF_F_HW_VLAN_CTAG_RX) &&
>  	    (vlan_tag & VLAN_VID_MASK)) {
> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> index c4f2bea0b670..62201977b074 100644
> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> @@ -1227,8 +1227,9 @@ static void ice_vc_dis_vf(struct ice_vf *vf)
>   *
>   * send msg to VF
>   */
> -static int ice_vc_send_msg_to_vf(struct ice_vf *vf, u32 v_opcode,
> -				 enum ice_status v_retval, u8 *msg, u16
> msglen)
> +static int
> +ice_vc_send_msg_to_vf(struct ice_vf *vf, u32 v_opcode, enum ice_status
> v_retval,
> +		      u8 *msg, u16 msglen)
>  {
>  	enum ice_status aq_ret;
>  	struct ice_pf *pf;
> @@ -2498,8 +2499,8 @@ void ice_vc_process_vf_msg(struct ice_pf *pf, struct
> ice_rq_event_info *event)
>   *
>   * return VF configuration
>   */
> -int ice_get_vf_cfg(struct net_device *netdev, int vf_id,
> -		   struct ifla_vf_info *ivi)
> +int
> +ice_get_vf_cfg(struct net_device *netdev, int vf_id, struct ifla_vf_info *ivi)
>  {
>  	struct ice_netdev_priv *np = netdev_priv(netdev);
>  	struct ice_vsi *vsi = np->vsi;
> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
> b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
> index 7bf3535feffb..5682f58110e7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h
> @@ -78,8 +78,8 @@ struct ice_vf {
>  void ice_process_vflr_event(struct ice_pf *pf);
>  int ice_sriov_configure(struct pci_dev *pdev, int num_vfs);
>  int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac);
> -int ice_get_vf_cfg(struct net_device *netdev, int vf_id,
> -		   struct ifla_vf_info *ivi);
> +int
> +ice_get_vf_cfg(struct net_device *netdev, int vf_id, struct ifla_vf_info *ivi);
> 
>  void ice_free_vfs(struct ice_pf *pf);
>  void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info
> *event);
> @@ -87,11 +87,13 @@ void ice_vc_notify_link_state(struct ice_pf *pf);
>  void ice_vc_notify_reset(struct ice_pf *pf);
>  bool ice_reset_all_vfs(struct ice_pf *pf, bool is_vflr);
> 
> -int ice_set_vf_port_vlan(struct net_device *netdev, int vf_id,
> -			 u16 vlan_id, u8 qos, __be16 vlan_proto);
> +int
> +ice_set_vf_port_vlan(struct net_device *netdev, int vf_id, u16 vlan_id, u8 qos,
> +		     __be16 vlan_proto);
> 
> -int ice_set_vf_bw(struct net_device *netdev, int vf_id, int min_tx_rate,
> -		  int max_tx_rate);

This function prototype is not used/needed, nor is its related and previously existing inline
function in this same file when CONFIG_PCI_IOV is not defined.

> +int
> +ice_set_vf_bw(struct net_device *netdev, int vf_id, int min_tx_rate,
> +	      int max_tx_rate);
> 
>  int ice_set_vf_trust(struct net_device *netdev, int vf_id, bool trusted);
> 
> --
> 2.14.5
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
