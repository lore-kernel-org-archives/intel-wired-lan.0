From: Singhai, Anjali <anjali.singhai@intel.com>
Date: Wed, 11 Nov 2015 00:32:21 +0000
Subject: [Intel-wired-lan] [PATCH v4 1/6] i40e: Remove CONFIG_I40E_VXLAN
In-Reply-To: <1447183403.6967.13.camel@intel.com>
References: <1447178205-99510-1-git-send-email-anjali.singhai@intel.com>
 <1447178469.6967.4.camel@intel.com>
 <C40BE8378EF49C44B9184714DBC8EF2992FC9472@ORSMSX110.amr.corp.intel.com>
 <1447183403.6967.13.camel@intel.com>
Message-ID: <C40BE8378EF49C44B9184714DBC8EF2992FC9D39@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Ok, So I did do a check. This series does fix the issue where we no more have to worry about whether VXLAN or GENEVE is a module and the driver is in-built since udp_offload_get_port will always be defined..
But we will have to actually drop the previous patch that changes  the driver to start using CONFIG_VXLAN, and rebase this patch series.

I will go ahead and do that.

Anjali

> -----Original Message-----
> From: Keller, Jacob E
> Sent: Tuesday, November 10, 2015 11:23 AM
> To: intel-wired-lan at lists.osuosl.org; Singhai, Anjali
> Subject: Re: [Intel-wired-lan] [PATCH v4 1/6] i40e: Remove
> CONFIG_I40E_VXLAN
> 
> Ok. That should work, but a quick check would be helpful.
> 
> Regards,
> Jake
> 
> On Tue, 2015-11-10 at 19:08 +0000, Singhai, Anjali wrote:
> > Jake this patch doesn't change the use of CONFIG_VXLAN in our driver
> > to guard against a potential issue that you pointed out.
> > Our driver had already changed to using CONFIG_VXLAN in a previous
> > patch.
> >
> > But I believe that we will still be okay in the scenario that VXLAN
> > module is not loaded because of two reasons
> > 1) We check a flag in sync_vsi_filters if a filter was added or
> > deleted before proceeding to do anything and that will return very
> > quickly from the function when VXLAN or GENEVE module is not loaded.
> > 2) udp_offload_get_port function has empty definitions in the base
> > kernel that will always exist even when the module is not loaded.
> >
> > Having said that, I am still going to make sure that it's not an issue
> > with a previous patch for our driver. Although the shift to using
> > udp_offload_get_port with this patch series will help alleviate that
> > issue.
> >
> > Anjali
> >
> > > -----Original Message-----
> > > From: Keller, Jacob E
> > > Sent: Tuesday, November 10, 2015 10:01 AM
> > > To: intel-wired-lan at lists.osuosl.org; Singhai, Anjali
> > > Subject: Re: [Intel-wired-lan] [PATCH v4 1/6] i40e: Remove
> > > CONFIG_I40E_VXLAN
> > >
> > > Hi Anjali,
> > >
> > > On Tue, 2015-11-10 at 09:56 -0800, Anjali Singhai Jain wrote:
> > > > If the kernel flag CONFIG_VXLAN is true or CONFIG_VXLAN_MODULE is
> > > > true, enable VXLAN offload in the driver.
> > > >
> > > > v2: Fix bisection error for this patch series.
> > > >
> > > > Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> > > > Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> > > > ---
> > > > ?drivers/net/ethernet/intel/i40e/i40e.h??????|??2 --
> > > > ?drivers/net/ethernet/intel/i40e/i40e_main.c | 10 ++--------
> > > > ?2 files changed, 2 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/intel/i40e/i40e.h
> > > > b/drivers/net/ethernet/intel/i40e/i40e.h
> > > > index 8ed759e..6c4d154 100644
> > > > --- a/drivers/net/ethernet/intel/i40e/i40e.h
> > > > +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> > > > @@ -282,11 +282,9 @@ struct i40e_pf {
> > > > ?	u32 fd_atr_cnt;
> > > > ?	u32 fd_tcp_rule;
> > > >
> > > > -#if IS_ENABLED(CONFIG_VXLAN)
> > > > ?	__be16??vxlan_ports[I40E_MAX_PF_UDP_OFFLOAD_PORTS];
> > > > ?	u16 pending_vxlan_bitmap;
> > > >
> > > > -#endif
> > > > ?	enum i40e_interrupt_policy int_policy;
> > > > ?	u16 rx_itr_default;
> > > > ?	u16 tx_itr_default;
> > > > diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > > b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > > index b447af6..0235a8a 100644
> > > > --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > > +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > > > @@ -6990,13 +6990,13 @@ static void i40e_handle_mdd_event(struct
> > > > i40e_pf *pf)
> > > > ?	i40e_flush(hw);
> > > > ?}
> > > >
> > > > -#if IS_ENABLED(CONFIG_VXLAN)
> > > > ?/**
> > > > ? * i40e_sync_vxlan_filters_subtask - Sync the VSI filter list
> > > > with HW
> > > > ? * @pf: board private structure
> > > > ? **/
> > > > ?static void i40e_sync_vxlan_filters_subtask(struct i40e_pf *pf)
> > > > ?{
> > > > +#if IS_ENABLED(CONFIG_VXLAN)
> > >
> > > Direct use of CONFIG_VXLAN is not going to work. What happens in the
> > > case where CONFIG_VXLAN=m and CONFIG_I40E=y?
> > >
> > > The kernel will load i40e as it loads itself at boot and vxlan
> > > module will not get included (because i40e isn't a module so it
> > > doesn't run depmod etc) and then it will run and try to call vxlan
> > > code and fail because of an unknown symbol since vxlan won't have
> > > been started yet.
> > >
> > > This is the entire reason why CONFIG_XXX_VXLAN exists. The
> > > alternative is to use select VXLAN and force VXLAN on when we enable
> > > I40E.
> > >
> > > That's the primary reason why we can't directly use CONFIG_VXLAN as
> > > a check in driver code.
> > >
> > > Regards,
> > > Jake
> > >
> > > > ?	struct i40e_hw *hw = &pf->hw;
> > > > ?	i40e_status ret;
> > > > ?	__be16 port;
> > > > @@ -7030,9 +7030,9 @@ static void
> > > > i40e_sync_vxlan_filters_subtask(struct i40e_pf *pf)
> > > > ?			}
> > > > ?		}
> > > > ?	}
> > > > +#endif
> > > > ?}
> > > >
> > > > -#endif
> > > > ?/**
> > > > ? * i40e_service_task - Run the driver's async subtasks
> > > > ? * @work: pointer to work_struct containing our data @@ -7057,9
> > > > +7057,7 @@ static void i40e_service_task(struct work_struct
> > > > *work)
> > > > ?	i40e_watchdog_subtask(pf);
> > > > ?	i40e_fdir_reinit_subtask(pf);
> > > > ?	i40e_sync_filters_subtask(pf);
> > > > -#if IS_ENABLED(CONFIG_VXLAN)
> > > > ?	i40e_sync_vxlan_filters_subtask(pf);
> > > > -#endif
> > > > ?	i40e_clean_adminq_subtask(pf);
> > > >
> > > > ?	i40e_service_event_complete(pf); @@ -8433,7 +8431,6 @@ static
> > > > int i40e_set_features(struct net_device *netdev,
> > > > ?	return 0;
> > > > ?}
> > > >
> > > > -#if IS_ENABLED(CONFIG_VXLAN)
> > > > ?/**
> > > > ? * i40e_get_vxlan_port_idx - Lookup a possibly offloaded for Rx
> > > > UDP port
> > > > ? * @pf: board private structure
> > > > @@ -8528,7 +8525,6 @@ static void i40e_del_vxlan_port(struct
> > > > net_device *netdev,
> > > > ?	}
> > > > ?}
> > > >
> > > > -#endif
> > > > ?static int i40e_get_phys_port_id(struct net_device *netdev,
> > > > ?				?struct netdev_phys_item_id
> > > > *ppid)
> > > > ?{
> > > > @@ -8753,10 +8749,8 @@ static const struct net_device_ops
> > > > i40e_netdev_ops = {
> > > > ?	.ndo_get_vf_config	= i40e_ndo_get_vf_config,
> > > > ?	.ndo_set_vf_link_state	=
> > > > i40e_ndo_set_vf_link_state,
> > > > ?	.ndo_set_vf_spoofchk	= i40e_ndo_set_vf_spoofchk,
> > > > -#if IS_ENABLED(CONFIG_VXLAN)
> > > > ?	.ndo_add_vxlan_port	= i40e_add_vxlan_port,
> > > > ?	.ndo_del_vxlan_port	= i40e_del_vxlan_port,
> > > > -#endif
> > > > ?	.ndo_get_phys_port_id	= i40e_get_phys_port_id,
> > > > ?	.ndo_fdb_add		= i40e_ndo_fdb_add,
> > > > ?	.ndo_features_check	= i40e_features_check,
