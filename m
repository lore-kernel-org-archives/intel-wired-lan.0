From: Ramamurthy, Harshitha <harshitha.ramamurthy@intel.com>
Date: Thu, 3 Jan 2019 22:28:23 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Add macvlan support on i40e
In-Reply-To: <CAP-MU4ORzeGXK3sn6qkx2=R0jGeMqZKsvUfgCjM9cc=6wpx-xg@mail.gmail.com>
References: <20181218215456.15494-1-harshitha.ramamurthy@intel.com>
 <CAP-MU4ORzeGXK3sn6qkx2=R0jGeMqZKsvUfgCjM9cc=6wpx-xg@mail.gmail.com>
Message-ID: <3839150ac3645bc30dba8ea81cd80f18c2839579.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2018-12-26 at 11:01 -0800, Shannon Nelson wrote:
> On Tue, Dec 18, 2018 at 1:55 PM Harshitha Ramamurthy
> <harshitha.ramamurthy@intel.com> wrote:
> > 
> > This patch enables macvlan offloads on Fortville devices. The idea
> > is to use channels as macvlan interfaces. The channels are VSIs of
> > type VMDQ. When the first macvlan is created, the maximum no. of
> > channels possible are created. From then on, as a macvlan interface
> > is created, a mac filter is added to these already created channels
> > (VSIs).
> > 
> > This patch builds on top of the recent changes which move
> > away from the select_queue implementation of picking the tx queue.
> > 
> > Steps to configure the macvlan:
> > 1. sudo ethtool -K ens261f1 l2-fwd-offload on
> > 2. ip link add link ens261f1 name macvlan1 type macvlan
> > 3. sudo ip link add link ens261f1 name macvlan1 type macvlan
> > 4. sudo ip link set macvlan1 up
> 
> Nice to see this finally coming out, thanks.  A few nit-pics below,
> otherwise
> Acked-by: Shannon Nelson <shannon.lee.nelson@gmail.com>

Thanks for the review, responses inline to some comments below. Will
address the rest of the comments in the next version.

> 
> Cheers,
> sln
> 
> > 
> > Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com
> > >
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e.h      |  26 ++
> >  drivers/net/ethernet/intel/i40e/i40e_main.c | 425
> > +++++++++++++++++++-
> >  2 files changed, 449 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e.h
> > b/drivers/net/ethernet/intel/i40e/i40e.h
> > index 4f4de85887a6..7416625e091e 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e.h
> > +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> > @@ -27,6 +27,7 @@
> >  #include <net/ip6_checksum.h>
> >  #include <linux/ethtool.h>
> >  #include <linux/if_vlan.h>
> > +#include <linux/if_macvlan.h>
> >  #include <linux/if_bridge.h>
> >  #include <linux/clocksource.h>
> >  #include <linux/net_tstamp.h>
> > @@ -390,6 +391,11 @@ struct i40e_flex_pit {
> >         u8 pit_index;
> >  };
> > 
> > +struct i40e_fwd_adapter {
> > +       struct net_device *netdev;
> > +       int bit_no;
> > +};
> > +
> >  struct i40e_channel {
> >         struct list_head list;
> >         bool initialized;
> > @@ -404,11 +410,25 @@ struct i40e_channel {
> >         struct i40e_aqc_vsi_properties_data info;
> > 
> >         u64 max_tx_rate;
> > +       struct i40e_fwd_adapter *fwd;
> > 
> >         /* track this channel belongs to which VSI */
> >         struct i40e_vsi *parent_vsi;
> >  };
> > 
> > +static inline bool i40e_is_channel_macvlan(struct i40e_channel
> > *ch)
> > +{
> > +       return !!ch->fwd;
> > +}
> > +
> > +static inline u8 *i40e_channel_mac(struct i40e_channel *ch)
> > +{
> > +       if (i40e_is_channel_macvlan(ch))
> > +               return ch->fwd->netdev->dev_addr;
> > +       else
> > +               return NULL;
> > +}
> > +
> >  /* struct that defines the Ethernet device */
> >  struct i40e_pf {
> >         struct pci_dev *pdev;
> > @@ -784,6 +804,12 @@ struct i40e_vsi {
> >         struct list_head ch_list;
> >         u16 tc_seid_map[I40E_MAX_TRAFFIC_CLASS];
> > 
> > +       /* macvlan fields */
> > +#define I40E_MAX_MACVLANS      128 /* Max HW capable vectors - 1
> > on FVL */
> > +       DECLARE_BITMAP(fwd_bitmask, I40E_MAX_MACVLANS);
> > +       struct list_head macvlan_list;
> > +       int macvlan_cnt;
> > +
> >         void *priv;     /* client driver data reference. */
> > 
> >         /* VSI specific handlers */
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > index 1ab1f579343f..1e61c22c27f4 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > @@ -5818,8 +5818,10 @@ static int i40e_add_channel(struct i40e_pf
> > *pf, u16 uplink_seid,
> >                 return -ENOENT;
> >         }
> > 
> > -       /* Success, update channel */
> > -       ch->enabled_tc = enabled_tc;
> > +       /* Success, update channel, set enabled_tc only if the
> > channel
> > +        * is not a macvlan
> > +        */
> > +       ch->enabled_tc = !i40e_is_channel_macvlan(ch) &&
> > enabled_tc;
> >         ch->seid = ctxt.seid;
> >         ch->vsi_number = ctxt.vsi_number;
> >         ch->stat_counter_idx =
> > cpu_to_le16(ctxt.info.stat_counter_idx);
> > @@ -6811,6 +6813,417 @@ static void
> > i40e_vsi_set_default_tc_config(struct i40e_vsi *vsi)
> >         }
> >  }
> > 
> > +/**
> > + * i40e_del_macvlan_filter
> > + * @hw: pointer to the HW structure
> > + * @seid: seid of the channel VSI
> > + * @macaddr: the mac address to apply as a filter
> > + * @aq_err: store the admin Q error
> > + *
> > + * This function deletes a mac filter on the channel VSI which
> > serves as the
> > + * macvlan. Returns 0 on success.
> > + **/
> > +static i40e_status i40e_del_macvlan_filter(struct i40e_hw *hw, u16
> > seid,
> > +                                          const u8 *macaddr, int
> > *aq_err)
> > +{
> > +       struct i40e_aqc_remove_macvlan_element_data element;
> > +       i40e_status status;
> > +
> > +       memset(&element, 0, sizeof(element));
> > +       ether_addr_copy(element.mac_addr, macaddr);
> > +       element.vlan_tag = 0;
> > +       element.flags = I40E_AQC_MACVLAN_DEL_PERFECT_MATCH;
> > +       status = i40e_aq_remove_macvlan(hw, seid, &element, 1,
> > NULL);
> > +       *aq_err = hw->aq.asq_last_status;
> > +       return status;
> > +}
> > +
> > +/**
> > + * i40e_add_macvlan_filter
> > + * @hw: pointer to the HW structure
> > + * @seid: seid of the channel VSI
> > + * @macaddr: the mac address to apply as a filter
> > + * @aq_err: store the admin Q error
> > + *
> > + * This function adds a mac filter on the channel VSI which serves
> > as the
> > + * macvlan. Returns 0 on success.
> > + **/
> > +static i40e_status i40e_add_macvlan_filter(struct i40e_hw *hw, u16
> > seid,
> > +                                          const u8 *macaddr, int
> > *aq_err)
> > +{
> > +       struct i40e_aqc_add_macvlan_element_data element;
> > +       i40e_status status;
> > +       u16 cmd_flags = 0;
> > +
> > +       ether_addr_copy(element.mac_addr, macaddr);
> > +       element.vlan_tag = 0;
> > +       element.queue_number = 0;
> > +       element.match_method = I40E_AQC_MM_ERR_NO_RES;
> > +       cmd_flags |= I40E_AQC_MACVLAN_ADD_PERFECT_MATCH;
> > +       element.flags = cpu_to_le16(cmd_flags);
> > +       status = i40e_aq_add_macvlan(hw, seid, &element, 1, NULL);
> > +       *aq_err = hw->aq.asq_last_status;
> > +       return status;
> > +}
> > +
> > +/**
> > + * i40e_fwd_ring_up - bring the macvlan device up
> > + * @vsi: the VSI we want to access
> > + * @vdev: macvlan netdevice
> > + * @fwd: the private fwd structure
> > + */
> > +static int i40e_fwd_ring_up(struct i40e_vsi *vsi, struct
> > net_device *vdev,
> > +                           struct i40e_fwd_adapter *fwd)
> > +{
> > +       int ret = 0, num_tc = 1,  i, aq_err;
> > +       struct i40e_channel *ch, *ch_tmp;
> > +       struct i40e_pf *pf = vsi->back;
> > +       struct i40e_hw *hw = &pf->hw;
> > +
> > +       if (list_empty(&vsi->macvlan_list))
> > +               return -EINVAL;
> > +
> > +       /* Go through the list and find an avaialble channel */
> 
> s/avaialble/available/
> 
> > +       list_for_each_entry_safe(ch, ch_tmp, &vsi->macvlan_list,
> > list) {
> > +               if (!i40e_is_channel_macvlan(ch)) {
> 
> Will the channel ever be used for anything else?
> Perhaps the sense of this should be to check for in use rather than
> is
> it a macvlan?

So the i40e_is_channel_macvlan macro checks if the channel is in use as
a macvlan. The idea is to go through the vsi->macvlan_list and identify
the next channel in the list which is available to be handed off to the
macvlan device. The macro does this by checking if ch->fwd is valid or
not.

> 
> > +                       ch->fwd = fwd;
> > +                       /* record configuration for macvlan
> > interface in vdev */
> > +                       for (i = 0; i < num_tc; i++)
> > +                               netdev_bind_sb_channel_queue(vsi-
> > >netdev, vdev,
> > +                                                            i,
> > +                                                            ch-
> > >num_queue_pairs,
> > +                                                            ch-
> > >base_queue);
> > +                       for (i = 0; i < ch->num_queue_pairs; i++) {
> > +                               struct i40e_ring *tx_ring,
> > *rx_ring;
> > +                               u16 pf_q;
> > +
> > +                               pf_q = ch->base_queue + i;
> > +
> > +                               /* Get to TX ring ptr */
> > +                               tx_ring = vsi->tx_rings[pf_q];
> > +                               tx_ring->ch = ch;
> > +
> > +                               /* Get the RX ring ptr */
> > +                               rx_ring = vsi->rx_rings[pf_q];
> > +                               rx_ring->ch = ch;
> > +                       }
> > +                       break;
> > +               }
> > +       }
> > +
> > +       /* Guarantee all rings are updated before we update the
> > +        * MAC address filter.
> > +        */
> > +       wmb();
> > +
> > +       /* Add a mac filter */
> > +       ret = i40e_add_macvlan_filter(hw, ch->seid, vdev->dev_addr, 
> > &aq_err);
> > +       if (ret) {
> > +               /* if we cannot add the MAC rule then disable the
> > offload */
> > +               macvlan_release_l2fw_offload(vdev);
> > +               for (i = 0; i < ch->num_queue_pairs; i++) {
> > +                       struct i40e_ring *rx_ring;
> > +                       u16 pf_q;
> > +
> > +                       pf_q = ch->base_queue + i;
> > +                       rx_ring = vsi->rx_rings[pf_q];
> > +                       rx_ring->netdev = NULL;
> > +               }
> > +               dev_info(&pf->pdev->dev,
> > +                        "Error adding mac filter on macvlan err
> > %s, aq_err %s\n",
> > +                         i40e_stat_str(hw, ret),
> > +                         i40e_aq_str(hw, aq_err));
> > +               netdev_err(vdev, "L2fwd offload disabled to L2
> > filter error\n");
> > +       }
> > +       return ret;
> > +}
> > +
> > +/**
> > + * i40e_setup_macvlans - create the channels which will be
> > macvlans
> > + * @vsi: the VSI we want to access
> > + * @macvlan_cnt: no. of macvlans to be setup
> > + * @qcnt: no. of Qs per macvlan
> > + * @vdev: macvlan netdevice
> > + */
> > +static int i40e_setup_macvlans(struct i40e_vsi *vsi, u16
> > macvlan_cnt, u16 qcnt,
> > +                              struct net_device *vdev)
> > +{
> > +       struct i40e_pf *pf = vsi->back;
> > +       struct i40e_hw *hw = &pf->hw;
> > +       struct i40e_vsi_context ctxt;
> > +       u16 sections, qmap, num_qps;
> > +       struct i40e_channel *ch;
> > +       int i, pow, ret = 0;
> > +       u8 offset = 0;
> > +
> > +       if (vsi->type != I40E_VSI_MAIN)
> > +               return -EINVAL;
> > +       if (!macvlan_cnt)
> > +               return -EBUSY;
> 
> EBUSY doesn't look right here, maybe EINVAL?
> 
> > +
> > +       num_qps = vsi->num_queue_pairs - (macvlan_cnt * qcnt);
> > +
> > +       /* find the next higher power-of-2 of num queue pairs */
> > +       pow = fls(roundup_pow_of_two(num_qps) - 1);
> > +
> > +       qmap = (offset << I40E_AQ_VSI_TC_QUE_OFFSET_SHIFT) |
> > +               (pow << I40E_AQ_VSI_TC_QUE_NUMBER_SHIFT);
> > +
> > +       /* Setup context bits for the main VSI */
> > +       sections = I40E_AQ_VSI_PROP_QUEUE_MAP_VALID;
> > +       sections |= I40E_AQ_VSI_PROP_SCHED_VALID;
> > +       ctxt.seid = vsi->seid;
> 
> Perhaps memset( 0 ) the ctxt before using it?
> 
> > +       ctxt.pf_num = vsi->back->hw.pf_id;
> > +       ctxt.vf_num = 0;
> > +       ctxt.uplink_seid = vsi->uplink_seid;
> > +       ctxt.info = vsi->info;
> > +       ctxt.info.tc_mapping[0] = cpu_to_le16(qmap);
> > +       ctxt.info.mapping_flags |=
> > cpu_to_le16(I40E_AQ_VSI_QUE_MAP_CONTIG);
> > +       ctxt.info.queue_mapping[0] = cpu_to_le16(vsi->base_queue);
> > +       ctxt.info.valid_sections |= cpu_to_le16(sections);
> > +
> > +       /* Reconfigure RSS for main VSI with max queue count */
> 
> s/with max/with new max/
> 
> > +       vsi->rss_size = max_t(u16, num_qps, qcnt);
> > +       ret = i40e_vsi_config_rss(vsi);
> > +       if (ret) {
> > +               dev_info(&vsi->back->pdev->dev,
> > +                        "Failed to reconfig rss for num_queues
> > (%u)\n",
> 
> RSS should be capitalized in log messages
> 
> > +                        vsi->rss_size);
> > +               goto err_free;
> > +       }
> > +       vsi->reconfig_rss = true;
> > +       dev_dbg(&vsi->back->pdev->dev,
> > +               "Reconfigured rss with num_queues (%u)\n", vsi-
> > >rss_size);
> 
> Ditto
> 
> > +       vsi->next_base_queue = num_qps;
> > +       vsi->cnt_q_avail = vsi->num_queue_pairs - num_qps;
> > +
> > +       /* Update the VSI after updating the VSI queue-mapping
> > +        * information
> > +        */
> > +       ret = i40e_aq_update_vsi_params(hw, &ctxt, NULL);
> > +       if (ret) {
> > +               dev_info(&pf->pdev->dev,
> > +                        "Update vsi tc config failed, err %s
> > aq_err %s\n",
> > +                        i40e_stat_str(hw, ret),
> > +                        i40e_aq_str(hw, hw->aq.asq_last_status));
> > +               goto err_free;
> > +       }
> > +       /* update the local VSI info with updated queue map */
> > +       i40e_vsi_update_queue_map(vsi, &ctxt);
> > +       vsi->info.valid_sections = 0;
> > +
> > +       /* Create channels for macvlans */
> > +       INIT_LIST_HEAD(&vsi->macvlan_list);
> > +       vsi->macvlan_cnt = macvlan_cnt;
> > +       for (i = 0; i < macvlan_cnt; i++) {
> > +               ch = kzalloc(sizeof(*ch), GFP_KERNEL);
> > +               if (!ch) {
> > +                       ret = -ENOMEM;
> > +                       goto err_free;
> > +               }
> > +               INIT_LIST_HEAD(&ch->list);
> > +               ch->num_queue_pairs = qcnt;
> > +               if (!i40e_setup_channel(pf, vsi, ch)) {
> > +                       dev_info(&pf->pdev->dev, "Failed to setup
> > macvlan\n");
> > +                       return -EINVAL;
> 
> Why doesn't this goto err_free?
> 
> > +               }
> > +               ch->parent_vsi = vsi;
> > +               vsi->cnt_q_avail -= ch->num_queue_pairs;
> > +               list_add_tail(&ch->list, &vsi->macvlan_list);
> > +       }
> > +err_free:
> 
> Is there anything that should be freed here?

Good point. I guess in this stage where we are setting up all the
macvlan VSIs if there is an error, I should free memory and also remove
the other channels that have been setup. I will add another function to
 do that and send the next version along with the other suggested
changes.
> 
> > +       return ret;
> > +}
> > +
> > +/**
> > + * i40e_fwd_add - configure macvlans
> > + * @netdev: net device to configure
> > + * @vdev: macvlan netdevice
> > + **/
> > +static void *i40e_fwd_add(struct net_device *netdev, struct
> > net_device *vdev)
> > +{
> > +       struct i40e_netdev_priv *np = netdev_priv(netdev);
> > +       u16 q_per_macvlan = 0, macvlan_cnt = 0, vectors;
> > +       struct i40e_vsi *vsi = np->vsi;
> > +       struct i40e_pf *pf = vsi->back;
> > +       struct i40e_fwd_adapter *fwd;
> > +       int avail_macvlan, ret;
> > +
> > +       if ((pf->flags & I40E_FLAG_DCB_ENABLED)) {
> > +               netdev_info(netdev, "Macvlans are not supported
> > when DCB is enabled\n");
> > +               return ERR_PTR(-EINVAL);
> > +       }
> > +       if ((pf->flags & I40E_FLAG_TC_MQPRIO)) {
> > +               netdev_info(netdev, "Macvlans are not supported
> > when HW TC offload is on\n");
> > +               return ERR_PTR(-EINVAL);
> > +       }
> > +
> > +       /* The macvlan device can't be a multiqueue device */
> > +       if (netif_is_multiqueue(vdev))
> > +               return ERR_PTR(-ERANGE);
> > +
> > +       if (!vsi->macvlan_cnt) {
> > +               /* reserve bit 0 for the pf device */
> > +               set_bit(0, vsi->fwd_bitmask);
> > +
> > +               /* Try to reserve as many queues for macvlans.
> > First reserve
> > +                *  3/4th of max vectors, then half, then quarter
> > and calculate
> > +                *  Qs per macvlan as you go
> > +                */
> > +               vectors = pf->num_lan_msix;
> > +               if (vectors <= I40E_MAX_MACVLANS && vectors > 96) {
> > +                       /* allocate 4 Qs per macvlan and 32 Qs to
> > the PF*/
> > +                       q_per_macvlan = 4;
> > +                       macvlan_cnt = (vectors - 32) / 4;
> > +               } else if (vectors <= 96 && vectors > 64) {
> > +                       /* allocate 4 Qs per macvlan and 32 Qs to
> > the PF*/
> > +                       q_per_macvlan = 4;
> > +                       macvlan_cnt = (vectors - 32) / 4;
> > +               } else if (vectors <= 64 && vectors > 32) {
> > +                       /* allocate 2 Qs per macvlan and 16 Qs to
> > the PF*/
> > +                       q_per_macvlan = 2;
> > +                       macvlan_cnt = (vectors - 16) / 2;
> > +               } else {
> > +                       /* allocate 1 Q per macvlan 16 Qs to the
> > PF*/
> > +                       q_per_macvlan = 1;
> > +                       macvlan_cnt = (vectors - 16);
> > +               }
> > +               if (macvlan_cnt == 0)
> > +                       return ERR_PTR(-EBUSY);
> > +
> > +               /* Quiesce VSI queues */
> > +               i40e_quiesce_vsi(vsi);
> > +
> > +               /* sets up the macvlans but does not "enable" them
> > */
> > +               ret = i40e_setup_macvlans(vsi, macvlan_cnt,
> > q_per_macvlan,
> > +                                         vdev);
> > +               if (ret)
> > +                       return ERR_PTR(ret);
> > +
> > +               /* Unquiesce VSI */
> > +               i40e_unquiesce_vsi(vsi);
> > +       }
> > +       avail_macvlan = find_first_zero_bit(vsi->fwd_bitmask,
> > +                                           vsi->macvlan_cnt);
> > +
> > +       /* create the fwd struct */
> > +       fwd = kzalloc(sizeof(*fwd), GFP_KERNEL);
> > +       if (!fwd)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       set_bit(avail_macvlan, vsi->fwd_bitmask);
> > +       fwd->bit_no = avail_macvlan;
> > +       netdev_set_sb_channel(vdev, avail_macvlan);
> > +       fwd->netdev = vdev;
> > +
> > +       if (!netif_running(netdev))
> > +               return fwd;
> > +
> > +       /* Set fwd ring up */
> > +       ret = i40e_fwd_ring_up(vsi, vdev, fwd);
> > +       if (ret) {
> > +               /* unbind the queues and drop the subordinate
> > channel config */
> > +               netdev_unbind_sb_channel(netdev, vdev);
> > +               netdev_set_sb_channel(vdev, 0);
> > +
> > +               kfree(fwd);
> > +               return ERR_PTR(-EINVAL);
> > +       }
> > +       return fwd;
> > +}
> > +
> > +/**
> > + * i40e_reset_ch_rings - Reset the queue contexts in a channel
> > + * @vsi: the VSI we want to access
> > + * @ch: the channel we want to access
> > + */
> > +static void i40e_reset_ch_rings(struct i40e_vsi *vsi, struct
> > i40e_channel *ch)
> > +{
> > +       struct i40e_ring *tx_ring, *rx_ring;
> > +       u16 pf_q;
> > +       int i;
> > +
> > +       for (i = 0; i < ch->num_queue_pairs; i++) {
> > +               pf_q = ch->base_queue + i;
> > +               tx_ring = vsi->tx_rings[pf_q];
> > +               tx_ring->ch = NULL;
> > +               rx_ring = vsi->rx_rings[pf_q];
> > +               rx_ring->ch = NULL;
> > +       }
> > +}
> > +
> > +/**
> > + * i40e_del_all_macvlans - Delete all the mac filters on the
> > channels
> > + * @vsi: the VSI we want to access
> > + */
> > +static void i40e_del_all_macvlans(struct i40e_vsi *vsi)
> > +{
> > +       struct i40e_channel *ch, *ch_tmp;
> > +       struct i40e_pf *pf = vsi->back;
> > +       struct i40e_hw *hw = &pf->hw;
> > +       int aq_err, ret = 0;
> > +
> > +       list_for_each_entry_safe(ch, ch_tmp, &vsi->macvlan_list,
> > list) {
> > +               if (i40e_is_channel_macvlan(ch)) {
> > +                       ret = i40e_del_macvlan_filter(hw, ch->seid,
> > +                                                     i40e_channel_
> > mac(ch),
> > +                                                     &aq_err);
> > +                       if (!ret) {
> > +                               /* Reset queue contexts */
> > +                               i40e_reset_ch_rings(vsi, ch);
> > +                               clear_bit(ch->fwd->bit_no, vsi-
> > >fwd_bitmask);
> > +                               netdev_unbind_sb_channel(vsi-
> > >netdev,
> > +                                                        ch->fwd-
> > >netdev);
> > +                               netdev_set_sb_channel(ch->fwd-
> > >netdev, 0);
> > +                               kfree(ch->fwd);
> > +                               ch->fwd = NULL;
> > +                       }
> > +               }
> > +       }
> > +}
> > +
> > +/**
> > + * i40e_fwd_del - delete macvlan interfaces
> > + * @netdev: net device to configure
> > + * @vdev: macvlan netdevice
> > + */
> > +static void i40e_fwd_del(struct net_device *netdev, void *vdev)
> > +{
> > +       struct i40e_netdev_priv *np = netdev_priv(netdev);
> > +       struct i40e_fwd_adapter *fwd = vdev;
> > +       struct i40e_channel *ch, *ch_tmp;
> > +       struct i40e_vsi *vsi = np->vsi;
> > +       struct i40e_pf *pf = vsi->back;
> > +       struct i40e_hw *hw = &pf->hw;
> > +       int aq_err, ret = 0;
> > +
> > +       /* Find the channel associated with the macvlan and del mac
> > filter */
> > +       list_for_each_entry_safe(ch, ch_tmp, &vsi->macvlan_list,
> > list) {
> > +               if (i40e_is_channel_macvlan(ch) &&
> > +                   ether_addr_equal(i40e_channel_mac(ch),
> > +                                    fwd->netdev->dev_addr)) {
> > +                       ret = i40e_del_macvlan_filter(hw, ch->seid,
> > +                                                     i40e_channel_
> > mac(ch),
> > +                                                     &aq_err);
> > +                       if (!ret) {
> > +                               /* Reset queue contexts */
> > +                               i40e_reset_ch_rings(vsi, ch);
> > +                               clear_bit(ch->fwd->bit_no, vsi-
> > >fwd_bitmask);
> > +                               netdev_unbind_sb_channel(netdev,
> > fwd->netdev);
> > +                               netdev_set_sb_channel(fwd->netdev,
> > 0);
> > +                               kfree(ch->fwd);
> > +                               ch->fwd = NULL;
> > +                               } else {
> > +                                       dev_info(&pf->pdev->dev,
> > +                                                "Error deleting
> > mac filter on macvlan err %s, aq_err %s\n",
> > +                                                i40e_stat_str(hw,
> > ret),
> > +                                                i40e_aq_str(hw,
> > aq_err));
> > +                               }
> > +                       break;
> > +               }
> > +       }
> > +}
> > +
> >  /**
> >   * i40e_setup_tc - configure multiple traffic classes
> >   * @netdev: net device to configure
> > @@ -11580,6 +11993,9 @@ static int i40e_set_features(struct
> > net_device *netdev,
> >                 return -EINVAL;
> >         }
> > 
> > +       if (!(features & NETIF_F_HW_L2FW_DOFFLOAD))
> > +               i40e_del_all_macvlans(vsi);
> > +
> >         need_reset = i40e_set_ntuple(pf, features);
> > 
> >         if (need_reset)
> > @@ -12313,6 +12729,8 @@ static const struct net_device_ops
> > i40e_netdev_ops = {
> >         .ndo_bpf                = i40e_xdp,
> >         .ndo_xdp_xmit           = i40e_xdp_xmit,
> >         .ndo_xsk_async_xmit     = i40e_xsk_async_xmit,
> > +       .ndo_dfwd_add_station   = i40e_fwd_add,
> > +       .ndo_dfwd_del_station   = i40e_fwd_del,
> >  };
> > 
> >  /**
> > @@ -12372,6 +12790,9 @@ static int i40e_config_netdev(struct
> > i40e_vsi *vsi)
> >         /* record features VLANs can make use of */
> >         netdev->vlan_features |= hw_enc_features |
> > NETIF_F_TSO_MANGLEID;
> > 
> > +       /* enable macvlan offloads */
> > +       netdev->hw_features |= NETIF_F_HW_L2FW_DOFFLOAD;
> > +
> >         hw_features = hw_enc_features           |
> >                       NETIF_F_HW_VLAN_CTAG_TX   |
> >                       NETIF_F_HW_VLAN_CTAG_RX;
> > --
> > 2.17.1
> > 
> > _______________________________________________
> > Intel-wired-lan mailing list
> > Intel-wired-lan at osuosl.org
> > https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 
> 
> 
