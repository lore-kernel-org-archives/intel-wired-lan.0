From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 21 Dec 2015 09:32:46 -0800
Subject: [Intel-wired-lan] [PATCH 3/3] igb: add support of Rx VLAN
 priority filters
In-Reply-To: <1450680015-15285-4-git-send-email-gangfeng.huang@ni.com>
References: <1450680015-15285-1-git-send-email-gangfeng.huang@ni.com>
 <1450680015-15285-4-git-send-email-gangfeng.huang@ni.com>
Message-ID: <CAKgT0Ud_0RK=FzFbAg7puNjpn74QiqAvpp8YFh17CRVp0zJnjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Dec 20, 2015 at 10:40 PM, Gangfeng Huang <gangfeng.huang@ni.com> wrote:
> This patch is meant to allow for nfc to insert and remove VLAN priority
> filter by ethtool

I don't think you quite understood my suggestion.  You cannot disable
promiscuous mode.  They did it in this driver for SR-IOV and it is
something that will need to be fixed.  There are a set of patches for
ixgbe that were recently added that enable VLAN promiscuous when
SR-IOV is enabled.  I would suggest looking at them as you could
probably implement something similar to work with your patches on igb.
I would have fixed the SR-IOV myself but I don't have a NIC to test
with and and getting into the VLAN bits can be pretty complicated as
there are a number of corner cases.

> Example:
> Add an VLAN priority filter:
> $ ethtool -N eth0 flow-type ether vlan 0x6000 vlan-mask 0x1FFF action 2 loc 1
>
> Show all filters:
> $ ethtool -n eth0
> 4 RX rings available
> Total 1 rules
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

Your example is bad.  The VLAN you report here doesn't match what you
specified above.

> Delete the filter by location:
> $ ethtool -N delete 1
>
> Signed-off-by: Ruhao Gao <ruhao.gao@ni.com>
> Signed-off-by: Gangfeng Huang <gangfeng.huang@ni.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_defines.h |    6 ++
>  drivers/net/ethernet/intel/igb/e1000_regs.h    |    1 +
>  drivers/net/ethernet/intel/igb/igb.h           |    3 +
>  drivers/net/ethernet/intel/igb/igb_ethtool.c   |   92 ++++++++++++++++++++++--
>  drivers/net/ethernet/intel/igb/igb_main.c      |    3 +-
>  5 files changed, 97 insertions(+), 8 deletions(-)
>
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

What is the above define used for?  I don't see it referenced anywhere.

> +#define E1000_VLAPQF_QUEUE_SEL(_n, q_idx) (q_idx << ((_n) * 4))
> +#define E1000_VLAPQF_P_VALID(_n)          (0x1 << (3 + (_n) * 4))
> +#define E1000_VLAPQF_QUEUE_MASK           0x03
> +
>  #endif
> diff --git a/drivers/net/ethernet/intel/igb/e1000_regs.h b/drivers/net/ethernet/intel/igb/e1000_regs.h
> index 4af2870..9168c7d 100644
> --- a/drivers/net/ethernet/intel/igb/e1000_regs.h
> +++ b/drivers/net/ethernet/intel/igb/e1000_regs.h
> @@ -308,6 +308,7 @@
>                                         (0x054E0 + ((_i - 16) * 8)))
>  #define E1000_RAH(_i)  (((_i) <= 15) ? (0x05404 + ((_i) * 8)) : \
>                                         (0x054E4 + ((_i - 16) * 8)))
> +#define E1000_VLAPQF   0x055B0  /* VLAN Priority Queue Filter VLAPQF */
>  #define E1000_IP4AT_REG(_i)     (0x05840 + ((_i) * 8))
>  #define E1000_IP6AT_REG(_i)     (0x05880 + ((_i) * 4))
>  #define E1000_WUPM_REG(_i)      (0x05A00 + ((_i) * 4))
> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
> index 72fb7e6..f70cea0 100644
> --- a/drivers/net/ethernet/intel/igb/igb.h
> +++ b/drivers/net/ethernet/intel/igb/igb.h
> @@ -365,6 +365,7 @@ struct hwmon_buff {
>  enum igb_filter_match_flags {
>         IGB_FILTER_FLAG_NONE        = 0x0,

The IGB_FILTER_FLAG_NONE doesn't make much sense in this enum.  You
could probably drop it and just hold of on introducing this enum until
you introduce the EtherType filter.

>         IGB_FILTER_FLAG_ETHER_TYPE  = 0x1,
> +       IGB_FILTER_FLAG_VLAN_TCI    = 0x2,
>  };
>
>  #define IGB_MAX_RXNFC_FILTERS 16
> @@ -373,9 +374,11 @@ struct igb_nfc_input {
>         /* Byte layout in order, all values with MSB first:
>         * match_flags - 1 byte
>         * etype       - 2 bytes
> +       * vlan_tci    - 2 bytes
>         */
>         u8     match_flags;
>         __be16 etype;
> +       __be16 vlan_tci;
>  };
>
>  /* board specific private data structure */
> diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> index 6488e2b..0b77cfb 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> @@ -2439,11 +2439,19 @@ static int igb_get_ethtool_nfc_entry(struct igb_adapter *adapter,
>         if (!rule || fsp->location != rule->sw_idx)
>                 return -EINVAL;
>
> -       if (rule->filter.match_flags & IGB_FILTER_FLAG_ETHER_TYPE) {
> +       if (rule->filter.match_flags & (IGB_FILTER_FLAG_ETHER_TYPE |
> +                               IGB_FILTER_FLAG_VLAN_TCI)) {

Since the match_flags will be 0 if no rules are defined you could
probably drop the and with flags and instead just check for not zero.

>                 fsp->flow_type = ETHER_FLOW;
>                 fsp->ring_cookie = rule->action;
> -               fsp->h_u.ether_spec.h_proto = rule->filter.etype;
> -               fsp->m_u.ether_spec.h_proto = ETHER_TYPE_FULL_MASK;
> +               if (rule->filter.match_flags & IGB_FILTER_FLAG_ETHER_TYPE) {
> +                       fsp->h_u.ether_spec.h_proto = rule->filter.etype;
> +                       fsp->m_u.ether_spec.h_proto = ETHER_TYPE_FULL_MASK;
> +               }
> +               if (rule->filter.match_flags & IGB_FILTER_FLAG_VLAN_TCI) {
> +                       fsp->flow_type |= FLOW_EXT;
> +                       fsp->h_ext.vlan_tci = rule->filter.vlan_tci;
> +                       fsp->m_ext.vlan_tci = htons(VLAN_PRIO_MASK);
> +               }
>                 return 0;
>         }
>         return -EINVAL;
> @@ -2687,12 +2695,46 @@ static int igb_rxnfc_write_etype_filter(struct igb_adapter *adapter,
>         return 0;
>  }
>
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
>  int igb_add_filter(struct igb_adapter *adapter, struct igb_nfc_filter *input)
>  {
>         int err = -EINVAL;
>
> -       if (input->filter.etype != 0)
> +       if (input->filter.etype != 0) {
>                 err = igb_rxnfc_write_etype_filter(adapter, input);
> +               if (err)
> +                       return err;
> +       }
> +
> +       if (input->filter.vlan_tci != 0)
> +               err = igb_rxnfc_write_vlan_prio_filter(adapter, input);
>

Wouldn't it be possible to request a filter with a value of 0?  You
might want to use the flags to test for this instead of the values.

>         return err;
>  }
> @@ -2712,11 +2754,33 @@ static void igb_clear_etype_filter_regs(struct igb_adapter *adapter,
>         adapter->etype_bitmap[reg_index] = false;
>  }
>
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

Do you really need to clear the QUEUE_SEL field as well or is simply
clearing the valid bit enough?  If just clearing the valid bit is
enough I would say to do that just because it makes it easier to debug
where filters have been in the past.

> +
> +       wr32(E1000_VLAPQF, vlapqf);
> +}
> +
>  int igb_erase_filter(struct igb_adapter *adapter, struct igb_nfc_filter *input)
>  {
>         if (input->filter.etype != 0)
>                 igb_clear_etype_filter_regs(adapter,
>                                             input->etype_reg_index);
> +
> +       if (input->filter.vlan_tci != 0)
> +               igb_clear_vlan_prio_filter(adapter,
> +                                          ntohs(input->filter.vlan_tci));
> +

Same here, you are better off using the flags instead of the values.

>         return 0;
>  }
>
> @@ -2798,15 +2862,28 @@ static int igb_add_ethtool_nfc_entry(struct igb_adapter *adapter,
>         if ((fsp->flow_type & ~FLOW_EXT) != ETHER_FLOW)
>                 return -EINVAL;
>
> -       if (fsp->m_u.ether_spec.h_proto != ETHER_TYPE_FULL_MASK)
> +       if (fsp->m_u.ether_spec.h_proto != ETHER_TYPE_FULL_MASK &&
> +           fsp->m_ext.vlan_tci != htons(VLAN_PRIO_MASK))
>                 return -EINVAL;
>
>         input = kzalloc(sizeof(*input), GFP_KERNEL);
>         if (!input)
>                 return -ENOMEM;
>
> -       input->filter.etype = fsp->h_u.ether_spec.h_proto;
> -       input->filter.match_flags = IGB_FILTER_FLAG_ETHER_TYPE;
> +       if (fsp->m_u.ether_spec.h_proto == ETHER_TYPE_FULL_MASK) {
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
>         input->action = fsp->ring_cookie;
>         input->sw_idx = fsp->location;
>
> @@ -2833,6 +2910,7 @@ static int igb_add_ethtool_nfc_entry(struct igb_adapter *adapter,
>
>  err_out_w_lock:
>         spin_unlock(&adapter->nfc_lock);
> +err_out:
>         kfree(input);
>         return err;
>  }
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index b87e8a2..95981ab 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -4054,7 +4054,8 @@ static void igb_set_rx_mode(struct net_device *netdev)
>
>         if (netdev->flags & IFF_PROMISC) {
>                 /* retain VLAN HW filtering if in VT mode */
> -               if (adapter->vfs_allocated_count)
> +               if (adapter->vfs_allocated_count ||
> +                   netdev->hw_features & NETIF_F_NTUPLE)

This isn't what I had in mind.  SR-IOV should not be disabling VF
filtering as it causes other issues.  You should not be disabling it
just because ntuple filtering is enabled.  Otherwise you have stripped
a basic feature that needs to be supported for your feature that most
people won't be using.

>                         rctl |= E1000_RCTL_VFE;
>                 rctl |= (E1000_RCTL_UPE | E1000_RCTL_MPE);
>                 vmolr |= (E1000_VMOLR_ROPE | E1000_VMOLR_MPME);
> --
> 1.7.9.5
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
