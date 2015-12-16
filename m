From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 16 Dec 2015 09:55:21 -0800
Subject: [Intel-wired-lan] [PATCH] igb: add support for nfc addition and
 removal of filters
In-Reply-To: <1450242905-3459-1-git-send-email-gangfeng.huang@ni.com>
References: <1450242905-3459-1-git-send-email-gangfeng.huang@ni.com>
Message-ID: <CAKgT0Uen4yG6QLhMfTcfcy6f2HTXpXnSmg_OuzHKO=f5DPdpAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Dec 15, 2015 at 9:15 PM, Gangfeng Huang <gangfeng.huang@ni.com> wrote:
> This patch is meant to allow for nfc to insert and remove ethertype filter
> and VLAN priority filter by ethtool. Ethtool interface has it's own rules
> manager

You should really break this out into several patches as it would make
this easier to review.  Ideally it would be nice to see one that
enables the ethtool interface infrastructure, one that adds support
for Ethertype filters, and one that adds support for the VLAN
filtering.

Also, I don't think your VLAN filtering will work when the interface
is in promiscuous mode.  You might need to double check that.  If that
is the case you may need to update things so that it does something
similar to the code I added to ixgbe in order to allow it to pull in
all VLANs when SR-IOV is enabled.

> Example:
> Add an ethertype filter:
> $ ethtool -N eth0 flow-type ether proto 0x88F8 action 2
> Add an VLAN priority filter:
> $ ethtool -N eth0 flow-type ether vlan 0x6002 vlan-mask 0xE000 action 2 loc 1

Your mask is inverted.  As such it doesn't match up with the mask
listed in your output below.

> Show all filters:
> $ ethtool -n eth0
> 4 RX rings available
> Total 2 rules
>
> Filter: 1
>         Flow Type: Raw Ethernet
>         Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
>         Dest MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
>         Ethertype: 0x0 mask: 0xFFFF
>         VLAN EtherType: 0x0 mask: 0xffff
>         VLAN: 0x6002 mask: 0x1fff
>         User-defined: 0x0 mask: 0xffffffffffffffff
>         Action: Direct to queue 2
>

A VLAN of 0x6002 with a mask of 0x1fff shouldn't be valid.  You will
never match 0x6002 if the lower 13 bits are masked off.  You need to
add a check in your code somewhere to verify that the rule doesn't
change when the mask is applied.  If it does then the rule is invalid.

> Filter: 15
>         Flow Type: Raw Ethernet
>         Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
>         Dest MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
>         Ethertype: 0x88F8 mask: 0x0
>         Action: Direct to queue 2
>
> Delete the filter by location:
> $ ethtool -N delete 15
>
> Signed-off-by: Ruhao Gao <ruhao.gao@ni.com>
> Signed-off-by: Gangfeng Huang <gangfeng.huang@ni.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_82575.h   |    5 +
>  drivers/net/ethernet/intel/igb/e1000_defines.h |    6 +
>  drivers/net/ethernet/intel/igb/e1000_regs.h    |    1 +
>  drivers/net/ethernet/intel/igb/igb.h           |   54 ++++
>  drivers/net/ethernet/intel/igb/igb_ethtool.c   |  339 ++++++++++++++++++++++++
>  drivers/net/ethernet/intel/igb/igb_main.c      |   36 +++
>  drivers/net/ethernet/intel/igb/igb_ptp.c       |    4 +-
>  7 files changed, 443 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/igb/e1000_82575.h b/drivers/net/ethernet/intel/igb/e1000_82575.h
> index 2154aea..c4a34e1 100644
> --- a/drivers/net/ethernet/intel/igb/e1000_82575.h
> +++ b/drivers/net/ethernet/intel/igb/e1000_82575.h
> @@ -187,7 +187,12 @@ struct e1000_adv_tx_context_desc {
>
>  /* ETQF register bit definitions */
>  #define E1000_ETQF_FILTER_ENABLE   (1 << 26)
> +#define E1000_ETQF_IMM_INT         (1 << 29)
>  #define E1000_ETQF_1588            (1 << 30)
> +#define E1000_ETQF_QUEUE_ENABLE    (1 << 31)
> +#define E1000_ETQF_QUEUE_SHIFT     16
> +#define E1000_ETQF_QUEUE_MASK      0x00070000
> +#define E1000_ETQF_ETYPE_MASK      0x0000FFFF
>
>  /* FTQF register bit definitions */
>  #define E1000_FTQF_VF_BP               0x00008000
> diff --git a/drivers/net/ethernet/intel/igb/e1000_defines.h b/drivers/net/ethernet/intel/igb/e1000_defines.h
> index b191504..3636067 100644
> --- a/drivers/net/ethernet/intel/igb/e1000_defines.h
> +++ b/drivers/net/ethernet/intel/igb/e1000_defines.h
> @@ -1019,4 +1019,10 @@
>  #define E1000_RTTBCNRC_RF_INT_MASK     \
>         (E1000_RTTBCNRC_RF_DEC_MASK << E1000_RTTBCNRC_RF_INT_SHIFT)
>
> +/* VLAN Priority Filter */
> +#define E1000_RCTL_VLAN_FILTER_ENABLE     (0x1 << 18)
> +#define E1000_VLAPQF_QUEUE_SEL(_n, q_idx) (q_idx << ((_n) * 4))
> +#define E1000_VLAPQF_P_VALID(_n)          (0x1 << (3 + (_n) * 4))
> +#define E1000_VLAPQF_QUEUE_MASK           0x03
> +
>  #endif
> diff --git a/drivers/net/ethernet/intel/igb/e1000_regs.h b/drivers/net/ethernet/intel/igb/e1000_regs.h
> index 4af2870..bba9048 100644
> --- a/drivers/net/ethernet/intel/igb/e1000_regs.h
> +++ b/drivers/net/ethernet/intel/igb/e1000_regs.h
> @@ -308,6 +308,7 @@
>                                         (0x054E0 + ((_i - 16) * 8)))
>  #define E1000_RAH(_i)  (((_i) <= 15) ? (0x05404 + ((_i) * 8)) : \
>                                         (0x054E4 + ((_i - 16) * 8)))
> +#define E1000_VLAPQF   0x55B0  /* VLAN Priority Queue Filter VLAPQF */
>  #define E1000_IP4AT_REG(_i)     (0x05840 + ((_i) * 8))
>  #define E1000_IP6AT_REG(_i)     (0x05880 + ((_i) * 4))
>  #define E1000_WUPM_REG(_i)      (0x05A00 + ((_i) * 4))
> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
> index 1a2f1cc..6c7473f 100644
> --- a/drivers/net/ethernet/intel/igb/igb.h
> +++ b/drivers/net/ethernet/intel/igb/igb.h
> @@ -343,11 +343,43 @@ struct hwmon_buff {
>         };
>  #endif
>
> +/* The number of L2 ether-type filter registers, Index 3 is reserved
> + * for PTP 1588 timestamp
> + */
> +#define MAX_ETYPE_FILTER  (4 - 1)
> +
> +/* ETQF filter list: one static filter per filter consumer. This is
> + *                   to avoid filter collisions later. Add new filters
> + *                   here!!
> + *
> + * Current filters:
> + *    1588 (0x88f7):         Filter 3
> + */
> +#define IGB_ETQF_FILTER_1588   3
> +
>  #define IGB_N_EXTTS    2
>  #define IGB_N_PEROUT   2
>  #define IGB_N_SDP      4
>  #define IGB_RETA_SIZE  128
>
> +enum igb_filter_match_flags {
> +       IGB_FILTER_FLAG_ETHER_TYPE  = 0x1,
> +       IGB_FILTER_FLAG_VLAN_TCI  = 0x2,
> +};
> +
> +#define IGB_MAX_RXNFC_FILTERS 16
> +
> +struct igb_nfc_input {
> +       /* Byte layout in order, all values with MSB first:
> +       * match_flags - 1 byte
> +       * vlan_tci    - 2 bytes
> +       * etype       - 2 bytes
> +       */
> +       u8     match_flags;
> +       __be16 vlan_tci;
> +       __be16 etype;
> +};
> +
>  /* board specific private data structure */
>  struct igb_adapter {
>         unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
> @@ -463,6 +495,21 @@ struct igb_adapter {
>         int copper_tries;
>         struct e1000_info ei;
>         u16 eee_advert;
> +
> +       /* rxnfc support */
> +       struct hlist_head nfc_filter_list;
> +       unsigned int nfc_filter_count;
> +       /* lock for nfc filter */
> +       spinlock_t nfc_lock;
> +       bool etype_bitmap[MAX_ETYPE_FILTER];
> +};
> +
> +struct igb_nfc_filter {
> +       struct hlist_node nfc_node;
> +       struct igb_nfc_input filter;
> +       u16 etype_reg_index;
> +       u16 sw_idx;
> +       u16 action;
>  };
>
>  #define IGB_FLAG_HAS_MSI               (1 << 0)
> @@ -582,4 +629,11 @@ static inline struct netdev_queue *txring_txq(const struct igb_ring *tx_ring)
>         return netdev_get_tx_queue(tx_ring->netdev, tx_ring->queue_index);
>  }
>
> +int igb_rxnfc_write_etype_filter(struct igb_adapter *adapter,
> +                                struct igb_nfc_filter *input);
> +int igb_rxnfc_write_vlan_prio_filter(struct igb_adapter *adapter,
> +                                    struct igb_nfc_filter *input);
> +int igb_erase_filter(struct igb_adapter *adapter,
> +                    struct igb_nfc_filter *input);
> +
>  #endif /* _IGB_H_ */
> diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> index 2529bc6..0d7313c 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> @@ -2421,6 +2421,64 @@ static int igb_get_ts_info(struct net_device *dev,
>         }
>  }
>
> +#define ETHER_TYPE_FULL_MASK ((__force __be16)~0)
> +static int igb_get_ethtool_nfc_entry(struct igb_adapter *adapter,
> +                                    struct ethtool_rxnfc *cmd)
> +{
> +       struct ethtool_rx_flow_spec *fsp = &cmd->fs;
> +       struct igb_nfc_filter *rule = NULL;
> +
> +       /* report total rule count */
> +       cmd->data = IGB_MAX_RXNFC_FILTERS;
> +
> +       hlist_for_each_entry(rule, &adapter->nfc_filter_list, nfc_node) {
> +               if (fsp->location <= rule->sw_idx)
> +                       break;
> +       }
> +
> +       if (!rule || fsp->location != rule->sw_idx)
> +               return -EINVAL;
> +
> +       if (rule->filter.match_flags & (IGB_FILTER_FLAG_ETHER_TYPE |
> +                               IGB_FILTER_FLAG_VLAN_TCI)) {
> +               fsp->flow_type = ETHER_FLOW;
> +               fsp->ring_cookie = rule->action;
> +               if (rule->filter.match_flags & IGB_FILTER_FLAG_ETHER_TYPE) {
> +                       fsp->h_u.ether_spec.h_proto = rule->filter.etype;
> +                       fsp->m_u.ether_spec.h_proto = ETHER_TYPE_FULL_MASK;
> +               }
> +               if (rule->filter.match_flags & IGB_FILTER_FLAG_VLAN_TCI) {
> +                       fsp->flow_type |= FLOW_EXT;
> +                       fsp->h_ext.vlan_tci = rule->filter.vlan_tci;
> +                       fsp->m_ext.vlan_tci = htons(VLAN_PRIO_MASK);
> +               }
> +               return 0;
> +       }
> +       return -EINVAL;
> +}
> +
> +static int igb_get_ethtool_nfc_all(struct igb_adapter *adapter,
> +                                  struct ethtool_rxnfc *cmd,
> +                                  u32 *rule_locs)
> +{
> +       struct igb_nfc_filter *rule;
> +       int cnt = 0;
> +
> +       /* report total rule count */
> +       cmd->data = IGB_MAX_RXNFC_FILTERS;
> +
> +       hlist_for_each_entry(rule, &adapter->nfc_filter_list, nfc_node) {
> +               if (cnt == cmd->rule_cnt)
> +                       return -EMSGSIZE;
> +               rule_locs[cnt] = rule->sw_idx;
> +               cnt++;
> +       }
> +
> +       cmd->rule_cnt = cnt;
> +
> +       return 0;
> +}
> +
>  static int igb_get_rss_hash_opts(struct igb_adapter *adapter,
>                                  struct ethtool_rxnfc *cmd)
>  {
> @@ -2474,6 +2532,16 @@ static int igb_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
>                 cmd->data = adapter->num_rx_queues;
>                 ret = 0;
>                 break;
> +       case ETHTOOL_GRXCLSRLCNT:
> +               cmd->rule_cnt = adapter->nfc_filter_count;
> +               ret = 0;
> +               break;
> +       case ETHTOOL_GRXCLSRULE:
> +               ret = igb_get_ethtool_nfc_entry(adapter, cmd);
> +               break;
> +       case ETHTOOL_GRXCLSRLALL:
> +               ret = igb_get_ethtool_nfc_all(adapter, cmd, rule_locs);
> +               break;
>         case ETHTOOL_GRXFH:
>                 ret = igb_get_rss_hash_opts(adapter, cmd);
>                 break;
> @@ -2588,6 +2656,272 @@ static int igb_set_rss_hash_opt(struct igb_adapter *adapter,
>         return 0;
>  }
>
> +static void igb_clear_etype_filter_regs(struct igb_adapter *adapter,
> +                                       u16 reg_index)
> +{
> +       struct e1000_hw *hw = &adapter->hw;
> +       u32 etqf = rd32(E1000_ETQF(reg_index));
> +
> +       etqf &= ~E1000_ETQF_QUEUE_ENABLE;
> +       etqf &= ~E1000_ETQF_QUEUE_MASK;
> +       etqf &= ~E1000_ETQF_FILTER_ENABLE;
> +
> +       wr32(E1000_ETQF(reg_index), etqf);
> +
> +       adapter->etype_bitmap[reg_index] = false;
> +}
> +
> +static void igb_clear_vlan_prio_filter(struct igb_adapter *adapter,
> +                                      u16 vlan_tci)
> +{
> +       struct e1000_hw *hw = &adapter->hw;
> +       u32 vlapqf;
> +       u8 vlan_priority;
> +
> +       vlan_priority = (vlan_tci & VLAN_PRIO_MASK) >> VLAN_PRIO_SHIFT;
> +
> +       vlapqf = rd32(E1000_VLAPQF);
> +       vlapqf &= ~E1000_VLAPQF_P_VALID(vlan_priority);
> +       vlapqf &= ~E1000_VLAPQF_QUEUE_SEL(vlan_priority,
> +                                               E1000_VLAPQF_QUEUE_MASK);
> +
> +       wr32(E1000_VLAPQF, vlapqf);
> +}
> +
> +int igb_erase_filter(struct igb_adapter *adapter, struct igb_nfc_filter *input)
> +{
> +       if (input->filter.etype != 0)
> +               igb_clear_etype_filter_regs(adapter,
> +                                           input->etype_reg_index);
> +
> +       if (input->filter.vlan_tci != 0)
> +               igb_clear_vlan_prio_filter(adapter,
> +                                          ntohs(input->filter.vlan_tci));
> +
> +       return 0;
> +}
> +
> +static int igb_update_ethtool_nfc_entry(struct igb_adapter *adapter,
> +                                       struct igb_nfc_filter *input,
> +                                       u16 sw_idx)
> +{
> +       struct igb_nfc_filter *rule, *parent;
> +       int err = -EINVAL;
> +
> +       parent = NULL;
> +       rule = NULL;
> +
> +       hlist_for_each_entry(rule, &adapter->nfc_filter_list, nfc_node) {
> +               /* hash found, or no matching entry */
> +               if (rule->sw_idx >= sw_idx)
> +                       break;
> +               parent = rule;
> +       }
> +
> +       /* if there is an old rule occupying our place remove it */
> +       if (rule && (rule->sw_idx == sw_idx)) {
> +               if (!input)
> +                       err = igb_erase_filter(adapter, rule);
> +
> +               hlist_del(&rule->nfc_node);
> +               kfree(rule);
> +               adapter->nfc_filter_count--;
> +       }
> +
> +       /* If no input this was a delete, err should be 0 if a rule was
> +        * successfully found and removed from the list else -EINVAL
> +        */
> +       if (!input)
> +               return err;
> +
> +       /* initialize node */
> +       INIT_HLIST_NODE(&input->nfc_node);
> +
> +       /* add filter to the list */
> +       if (parent)
> +               hlist_add_behind(&parent->nfc_node, &input->nfc_node);
> +       else
> +               hlist_add_head(&input->nfc_node, &adapter->nfc_filter_list);
> +
> +       /* update counts */
> +       adapter->nfc_filter_count++;
> +
> +       return 0;
> +}
> +
> +int igb_rxnfc_write_etype_filter(struct igb_adapter *adapter,
> +                                struct igb_nfc_filter *input)
> +{
> +       struct e1000_hw *hw = &adapter->hw;
> +       u8 i;
> +       u32 etqf;
> +       u16 etype;
> +
> +       /* find an empty etype filter register */
> +       for (i = 0; i < MAX_ETYPE_FILTER; ++i) {
> +               if (!adapter->etype_bitmap[i])
> +                       break;
> +       }
> +       if (i == MAX_ETYPE_FILTER) {
> +               dev_err(&adapter->pdev->dev, "ethtool -N: etype filters are all used.\n");
> +               return -EINVAL;
> +       }
> +
> +       adapter->etype_bitmap[i] = true;
> +
> +       etqf = rd32(E1000_ETQF(i));
> +       etype = ntohs(input->filter.etype & ETHER_TYPE_FULL_MASK);
> +
> +       etqf |= E1000_ETQF_FILTER_ENABLE;
> +       etqf &= ~E1000_ETQF_ETYPE_MASK;
> +       etqf |= (etype & E1000_ETQF_ETYPE_MASK);
> +
> +       etqf &= ~E1000_ETQF_QUEUE_MASK;
> +       etqf |= ((input->action << E1000_ETQF_QUEUE_SHIFT)
> +               & E1000_ETQF_QUEUE_MASK);
> +       etqf |= E1000_ETQF_QUEUE_ENABLE;
> +
> +       wr32(E1000_ETQF(i), etqf);
> +
> +       input->etype_reg_index = i;
> +
> +       return 0;
> +}
> +
> +int igb_rxnfc_write_vlan_prio_filter(struct igb_adapter *adapter,
> +                                    struct igb_nfc_filter *input)
> +{
> +       struct e1000_hw *hw = &adapter->hw;
> +       u32 vlapqf;
> +       u8 vlan_priority;
> +       u16 queue_index;
> +
> +       vlapqf = rd32(E1000_VLAPQF);
> +       vlan_priority = (ntohs(input->filter.vlan_tci) & VLAN_PRIO_MASK)
> +                               >> VLAN_PRIO_SHIFT;
> +       queue_index = (vlapqf >> (vlan_priority * 4)) & E1000_VLAPQF_QUEUE_MASK;
> +
> +       /* check whether this vlan prio is already set */
> +       if ((vlapqf & E1000_VLAPQF_P_VALID(vlan_priority)) &&
> +           (queue_index != input->action)) {
> +               dev_err(&adapter->pdev->dev, "ethtool rxnfc set vlan prio filter failed.\n");
> +               return -EEXIST;
> +       }
> +
> +       vlapqf |= E1000_VLAPQF_P_VALID(vlan_priority);
> +       vlapqf |= E1000_VLAPQF_QUEUE_SEL(vlan_priority, input->action);
> +
> +       wr32(E1000_VLAPQF, vlapqf);
> +
> +       return 0;
> +}
> +
> +static int igb_add_ethtool_nfc_entry(struct igb_adapter *adapter,
> +                                    struct ethtool_rxnfc *cmd)
> +{
> +       struct ethtool_rx_flow_spec *fsp =
> +               (struct ethtool_rx_flow_spec *)&cmd->fs;
> +       struct igb_nfc_filter *input, *rule;
> +       int err = 0;
> +

Do all of the adapters supported by igb support this feature?  If not
then you should only allow it for the interfaces that support it.
What you could do is use the NETIF_F_NTUPLE flag and just set it for
the hardware families that support this feature and then check for it
here to block access to the feature on those hardware families that
don't support it.

> +       /* Don't allow programming if the action is a queue greater than
> +        * the number of online Rx queues.
> +        */
> +       if ((fsp->ring_cookie == RX_CLS_FLOW_DISC) ||
> +           (fsp->ring_cookie >= adapter->num_rx_queues)) {
> +               dev_err(&adapter->pdev->dev, "ethtool -N: The specified action is invalid\n");
> +               return -EINVAL;
> +       }
> +
> +       /* Don't allow indexes to exist outside of available space */
> +       if (fsp->location >= IGB_MAX_RXNFC_FILTERS) {
> +               dev_err(&adapter->pdev->dev, "Location out of range\n");
> +               return -EINVAL;
> +       }
> +
> +       if ((fsp->flow_type & ~FLOW_EXT) != ETHER_FLOW)
> +               return -EINVAL;
> +
> +       if (!(fsp->m_u.ether_spec.h_proto || fsp->m_ext.vlan_tci))
> +               return -EINVAL;

This bit here isn't nearly thorough enough to verify you are setting
up the masks correctly.  The hardware supports either the entire the
full Ethertype or just the prio portion of the VLAN.  You should
verify that is what is being asked for since you cannot actually
support partial masks.

> +       input = kzalloc(sizeof(*input), GFP_KERNEL);
> +       if (!input)
> +               return -ENOMEM;
> +
> +       if (fsp->m_u.ether_spec.h_proto) {
> +               if (fsp->m_u.ether_spec.h_proto != ETHER_TYPE_FULL_MASK) {
> +                       err = -EINVAL;
> +                       goto err_out;
> +               }
> +               input->filter.etype = fsp->h_u.ether_spec.h_proto;
> +               input->filter.match_flags = IGB_FILTER_FLAG_ETHER_TYPE;
> +       }
> +
> +       if ((fsp->flow_type & FLOW_EXT) && fsp->m_ext.vlan_tci) {
> +               if (fsp->m_ext.vlan_tci != htons(VLAN_PRIO_MASK)) {
> +                       err = -EINVAL;
> +                       goto err_out;
> +               }
> +               input->filter.vlan_tci = fsp->h_ext.vlan_tci;
> +               input->filter.match_flags |= IGB_FILTER_FLAG_VLAN_TCI;
> +       }
> +
> +       input->action = fsp->ring_cookie;
> +       input->sw_idx = fsp->location;
> +
> +       spin_lock(&adapter->nfc_lock);
> +
> +       hlist_for_each_entry(rule, &adapter->nfc_filter_list, nfc_node) {
> +               if (!memcmp(&input->filter, &rule->filter,
> +                           sizeof(input->filter))) {
> +                       err = -EEXIST;
> +                       dev_err(&adapter->pdev->dev,
> +                               "ethtool: this filter is already set\n");
> +                       goto err_out_w_lock;
> +               }
> +       }
> +
> +       /* set etype filter register */
> +       if (input->filter.etype != 0) {
> +               err = igb_rxnfc_write_etype_filter(adapter, input);
> +               if (err)
> +                       goto err_out_w_lock;
> +       }
> +
> +       /* set vlan prio filter register */
> +       if (input->filter.vlan_tci != 0) {
> +               err = igb_rxnfc_write_vlan_prio_filter(adapter, input);
> +               if (err)
> +                       goto err_out_w_lock;
> +       }
> +
> +       igb_update_ethtool_nfc_entry(adapter, input, input->sw_idx);
> +
> +       spin_unlock(&adapter->nfc_lock);
> +       return 0;
> +
> +err_out_w_lock:
> +       spin_unlock(&adapter->nfc_lock);
> +err_out:
> +       kfree(input);
> +       return err;
> +}
> +
> +static int igb_del_ethtool_nfc_entry(struct igb_adapter *adapter,
> +                                    struct ethtool_rxnfc *cmd)
> +{
> +       struct ethtool_rx_flow_spec *fsp =
> +               (struct ethtool_rx_flow_spec *)&cmd->fs;
> +       int err;
> +
> +       spin_lock(&adapter->nfc_lock);
> +       err = igb_update_ethtool_nfc_entry(adapter, NULL, fsp->location);
> +       spin_unlock(&adapter->nfc_lock);
> +
> +       return err;
> +}
> +
>  static int igb_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
>  {
>         struct igb_adapter *adapter = netdev_priv(dev);
> @@ -2597,6 +2931,11 @@ static int igb_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
>         case ETHTOOL_SRXFH:
>                 ret = igb_set_rss_hash_opt(adapter, cmd);
>                 break;
> +       case ETHTOOL_SRXCLSRLINS:
> +               ret = igb_add_ethtool_nfc_entry(adapter, cmd);
> +               break;
> +       case ETHTOOL_SRXCLSRLDEL:
> +               ret = igb_del_ethtool_nfc_entry(adapter, cmd);
>         default:
>                 break;
>         }
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index ea7b098..ba97e8b 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -176,6 +176,9 @@ static int igb_ndo_get_vf_config(struct net_device *netdev, int vf,
>                                  struct ifla_vf_info *ivi);
>  static void igb_check_vf_rate_limit(struct igb_adapter *);
>
> +static void igb_nfc_filter_exit(struct igb_adapter *adapter);
> +static void igb_nfc_filter_restore(struct igb_adapter *adapter);
> +
>  #ifdef CONFIG_PCI_IOV
>  static int igb_vf_configure(struct igb_adapter *adapter, int vf);
>  static int igb_pci_enable_sriov(struct pci_dev *dev, int num_vfs);
> @@ -1610,6 +1613,7 @@ static void igb_configure(struct igb_adapter *adapter)
>         igb_setup_mrqc(adapter);
>         igb_setup_rctl(adapter);
>
> +       igb_nfc_filter_restore(adapter);
>         igb_configure_tx(adapter);
>         igb_configure_rx(adapter);
>
> @@ -2967,6 +2971,8 @@ static int igb_sw_init(struct igb_adapter *adapter)
>         adapter->min_frame_size = ETH_ZLEN + ETH_FCS_LEN;
>
>         spin_lock_init(&adapter->stats64_lock);
> +       spin_lock_init(&adapter->nfc_lock);
> +
>  #ifdef CONFIG_PCI_IOV
>         switch (hw->mac.type) {
>         case e1000_82576:
> @@ -3153,6 +3159,8 @@ static int __igb_close(struct net_device *netdev, bool suspending)
>         igb_down(adapter);
>         igb_free_irq(adapter);
>
> +       igb_nfc_filter_exit(adapter);
> +
>         igb_free_all_tx_resources(adapter);
>         igb_free_all_rx_resources(adapter);
>
> @@ -8104,4 +8112,32 @@ int igb_reinit_queues(struct igb_adapter *adapter)
>
>         return err;
>  }
> +
> +static void igb_nfc_filter_exit(struct igb_adapter *adapter)
> +{
> +       struct igb_nfc_filter *rule;
> +
> +       spin_lock(&adapter->nfc_lock);
> +
> +       hlist_for_each_entry(rule, &adapter->nfc_filter_list, nfc_node)
> +               igb_erase_filter(adapter, rule);
> +
> +       spin_unlock(&adapter->nfc_lock);
> +}
> +
> +static void igb_nfc_filter_restore(struct igb_adapter *adapter)
> +{
> +       struct igb_nfc_filter *rule;
> +
> +       spin_lock(&adapter->nfc_lock);
> +
> +       hlist_for_each_entry(rule, &adapter->nfc_filter_list, nfc_node) {
> +               if (rule->filter.etype != 0)
> +                       igb_rxnfc_write_etype_filter(adapter, rule);
> +               if (rule->filter.vlan_tci != 0)
> +                       igb_rxnfc_write_vlan_prio_filter(adapter, rule);
> +       }
> +       spin_unlock(&adapter->nfc_lock);
> +}
> +
>  /* igb_main.c */
> diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
> index c44df87..84c4943 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ptp.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
> @@ -940,12 +940,12 @@ static int igb_ptp_set_timestamp_mode(struct igb_adapter *adapter,
>
>         /* define ethertype filter for timestamped packets */
>         if (is_l2)
> -               wr32(E1000_ETQF(3),
> +               wr32(E1000_ETQF(IGB_ETQF_FILTER_1588),
>                      (E1000_ETQF_FILTER_ENABLE | /* enable filter */
>                       E1000_ETQF_1588 | /* enable timestamping */
>                       ETH_P_1588));     /* 1588 eth protocol type */
>         else
> -               wr32(E1000_ETQF(3), 0);
> +               wr32(E1000_ETQF(IGB_ETQF_FILTER_1588), 0);
>
>         /* L4 Queue Filter[3]: filter by destination port and protocol */
>         if (is_l4) {
> --
> 1.7.9.5
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
