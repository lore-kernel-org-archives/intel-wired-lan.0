From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Thu, 3 Feb 2022 11:46:26 +0100
Subject: [Intel-wired-lan] [PATCH net-next 18/19] iecm: add advanced rss
In-Reply-To: <CO1PR11MB51860C64005BE3D05A0D72A18F289@CO1PR11MB5186.namprd11.prod.outlook.com>
References: <20220128001009.721392-1-alan.brady@intel.com>
 <20220128001009.721392-19-alan.brady@intel.com>
 <20220128195358.31333-1-alexandr.lobakin@intel.com>
 <CO1PR11MB51860C64005BE3D05A0D72A18F289@CO1PR11MB5186.namprd11.prod.outlook.com>
Message-ID: <YfuygnSgPRg3jdUl@boxer>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Feb 03, 2022 at 02:55:57AM +0000, Brady, Alan wrote:
> > -----Original Message-----
> > From: Lobakin, Alexandr <alexandr.lobakin@intel.com>
> > Sent: Friday, January 28, 2022 11:54 AM
> > To: Brady, Alan <alan.brady@intel.com>
> > Cc: Lobakin, Alexandr <alexandr.lobakin@intel.com>; Wang, Haiyue
> > <haiyue.wang@intel.com>; intel-wired-lan at lists.osuosl.org; Burra, Phani R
> > <phani.r.burra@intel.com>; Chittim, Madhu <madhu.chittim@intel.com>;
> > Linga, Pavan Kumar <pavan.kumar.linga@intel.com>
> > Subject: Re: [Intel-wired-lan] [PATCH net-next 18/19] iecm: add advanced
> > rss
> > 
> > From: Alan Brady <alan.brady@intel.com>
> > Date: Thu, 27 Jan 2022 16:10:08 -0800
> > 
> > > From: Haiyue Wang <haiyue.wang@intel.com>
> > >
> > > Continuing with advanced features this implements what's needed to do
> > > advanced rss.
> > 
> > I'm sorry for not mentioned it before, but most of the series'
> > commit messages are poor and would probably get rejected upstream.
> > If they were explaining at least some very basics, it would be better. Even
> > better if there were explanations of some tricky code that happens time to
> > time.

I agree this should be improved. I don't know if this would be rejected
upstream, but in the future when looking at the commit history it would
just be more convenient for us and future readers if the description would
have more content in it.

> > 
> > >
> > > Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> > > ---
> > >  drivers/net/ethernet/intel/iecm/iecm_lib.c    | 547
> > ++++++++++++++++++
> > >  .../net/ethernet/intel/iecm/iecm_virtchnl.c   |  71 +++
> > >  drivers/net/ethernet/intel/include/iecm.h     |  73 +++
> > >  3 files changed, 691 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/intel/iecm/iecm_lib.c
> > > b/drivers/net/ethernet/intel/iecm/iecm_lib.c
> > > index d11413cb438c..baa1e312652a 100644
> > > --- a/drivers/net/ethernet/intel/iecm/iecm_lib.c
> > > +++ b/drivers/net/ethernet/intel/iecm/iecm_lib.c
> > > @@ -1013,6 +1013,52 @@ static void iecm_remove_vlan_filters(struct
> > iecm_vport *vport)
> > >  	}
> > >  }
> > >
> > > +/**
> > > + * iecm_remove_adv_rss_cfgs - Remove all RSS configuration
> > > + * @vport: vport structure
> > > + */
> > > +static void iecm_remove_adv_rss_cfgs(struct iecm_vport *vport) {
> > > +	struct iecm_adapter *adapter = vport->adapter;
> > > +
> > > +	if (!iecm_is_cap_ena(adapter, IECM_OTHER_CAPS,
> > VIRTCHNL2_CAP_ADV_RSS))
> > > +		return;
> > > +
> > > +	if (!list_empty(&adapter->config_data.adv_rss_list)) {
> > > +		struct iecm_adv_rss *rss;
> > > +
> > > +		spin_lock_bh(&adapter->adv_rss_list_lock);
> > > +		list_for_each_entry(rss, &adapter-
> > >config_data.adv_rss_list,
> > > +				    list) {
> > > +			rss->remove = true;
> > > +		}
> > 
> > Redundant braces arond an one-liner.
> > 
> 
> Maybe will fix.

? :D this one-liner is not even spread onto multiple lines, right? So why
'maybe' ?

> 
> > > +		spin_unlock_bh(&adapter->adv_rss_list_lock);
> > > +		iecm_send_add_del_adv_rss_cfg_msg(vport, false);
> > > +	}
> > 
> > Invert the condition for -1 indent level.
> > 
> 
> Will fix.
> 
