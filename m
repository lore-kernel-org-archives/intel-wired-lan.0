From: Drewek, Wojciech <wojciech.drewek@intel.com>
Date: Wed, 20 Apr 2022 10:36:18 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: return proper error
 code in ice_add_adv_rule
In-Reply-To: <38b3db7f-af23-1ab5-ba5d-a79d02e90fda@molgen.mpg.de>
References: <20220401095958.438230-1-wojciech.drewek@intel.com>
 <38b3db7f-af23-1ab5-ba5d-a79d02e90fda@molgen.mpg.de>
Message-ID: <MW4PR11MB577638268472DE97373623B3FDF59@MW4PR11MB5776.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Paul,

Thanks for the review!

> -----Original Message-----
> From: Paul Menzel <pmenzel@molgen.mpg.de>
> Sent: ?roda, 20 kwietnia 2022 12:16
> To: Drewek, Wojciech <wojciech.drewek@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH net-next] ice: return proper error code in ice_add_adv_rule
> 
> Dear Wojciech,
> 
> 
> Thank you for your patch.
> 
> Am 01.04.22 um 11:59 schrieb Wojciech Drewek:
> > When number of words exceeds ICE_MAX_CHAIN_WORDS, -ENOSPC
> > should be returned not -EINVAL. Do not overwrite this
> > error code in ice_add_tc_flower_adv_fltr.
> 
> Maybe make that two commits?

IMO there is no need for that. Those changes are logically connected,
why bother changing error code when it?s overwritten later.

> 
> Also for the subject, instead of ?proper error code?, just name it. Maybe:
> 
> > ice: ice_add_adv_rule: return ENOSPC when exceeding ICE_MAX_CHAIN_WORDS

Yea, I think it sounds better, will send v2.

Regards,
Wojtek

> 
> 
> Kind regards,
> 
> Paul
> 
> 
> > Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> > Suggested-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> > Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> >   drivers/net/ethernet/intel/ice/ice_switch.c | 5 ++++-
> >   drivers/net/ethernet/intel/ice/ice_tc_lib.c | 1 -
> >   2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
> > index ed7130b7abfe..01f7029ec22f 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_switch.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_switch.c
> > @@ -5992,9 +5992,12 @@ ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
> >   				word_cnt++;
> >   	}
> >
> > -	if (!word_cnt || word_cnt > ICE_MAX_CHAIN_WORDS)
> > +	if (!word_cnt)
> >   		return -EINVAL;
> >
> > +	if (word_cnt > ICE_MAX_CHAIN_WORDS)
> > +		return -ENOSPC;
> > +
> >   	/* locate a dummy packet */
> >   	profile = ice_find_dummy_packet(lkups, lkups_cnt, rinfo->tun_type);
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> > index f3a51597f7f6..4cee0fcf91d1 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> > @@ -748,7 +748,6 @@ ice_add_tc_flower_adv_fltr(struct ice_vsi *vsi,
> >   	} else if (ret) {
> >   		NL_SET_ERR_MSG_MOD(tc_fltr->extack,
> >   				   "Unable to add filter due to error");
> > -		ret = -EIO;
> >   		goto exit;
> >   	}
> >
