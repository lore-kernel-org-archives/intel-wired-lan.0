From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Fri,  4 Feb 2022 11:08:28 +0100
Subject: [Intel-wired-lan] [PATCH net-next 16/19] iecm: implement flow
 director
In-Reply-To: <CO1PR11MB518650C6F3DCE7DBAF6CFE5D8F289@CO1PR11MB5186.namprd11.prod.outlook.com>
References: <20220128001009.721392-1-alan.brady@intel.com>
 <20220128001009.721392-17-alan.brady@intel.com>
 <20220128190403.30131-1-alexandr.lobakin@intel.com>
 <CO1PR11MB518650C6F3DCE7DBAF6CFE5D8F289@CO1PR11MB5186.namprd11.prod.outlook.com>
Message-ID: <20220204100828.77916-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>
Date: Thu, 3 Feb 2022 03:41:26 +0100

> > -----Original Message-----
> > From: Lobakin, Alexandr <alexandr.lobakin@intel.com>
> > Sent: Friday, January 28, 2022 11:04 AM
> > To: Brady, Alan <alan.brady@intel.com>
> > Cc: Lobakin, Alexandr <alexandr.lobakin@intel.com>; Wang, Haiyue
> > <haiyue.wang@intel.com>; Burra, Phani R <phani.r.burra@intel.com>;
> > Chittim, Madhu <madhu.chittim@intel.com>; Linga, Pavan Kumar
> > <pavan.kumar.linga@intel.com>; intel-wired-lan at lists.osuosl.org
> > Subject: Re: [Intel-wired-lan] [PATCH net-next 16/19] iecm: implement flow
> > director
> > 
> > From: Alan Brady <alan.brady@intel.com>
> > Date: Thu, 27 Jan 2022 16:10:06 -0800
> > 
> > > From: Haiyue Wang <haiyue.wang@intel.com>
> > >
> > > This adds everthing needed to do flow director commands.
> > >
> > > Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
> > > ---
> > >  .../net/ethernet/intel/iecm/iecm_ethtool.c    |   17 +-
> > >  drivers/net/ethernet/intel/iecm/iecm_lib.c    | 1528
> > ++++++++++++++++-
> > >  .../net/ethernet/intel/iecm/iecm_virtchnl.c   |  119 ++
> > >  drivers/net/ethernet/intel/include/iecm.h     |  112 ++
> > >  4 files changed, 1770 insertions(+), 6 deletions(-)
> > >

--- 8< ---

> > > +	switch (fltr->flow_type) {
> > > +	case IECM_FDIR_FLOW_IPV4_TCP:
> > > +	case IECM_FDIR_FLOW_IPV4_UDP:
> > > +	case IECM_FDIR_FLOW_IPV4_SCTP:
> > > +		dev_info(dev, "Rule ID: %u dst_ip: %pI4 src_ip %pI4 %s:
> > dst_port %hu src_port %hu\n",
> > > +			 fltr->loc,
> > > +			 &fltr->ip_data.v4_addrs.dst_ip,
> > > +			 &fltr->ip_data.v4_addrs.src_ip,
> > > +			 proto,
> > > +			 ntohs(fltr->ip_data.dst_port),
> > > +			 ntohs(fltr->ip_data.src_port));
> > 
> > Some of those can fit into previous line, there's no need to put
> > each argument onto separate one.
> > 
> 
> It technically can fit on one line, but it's much easier for humans to parse what's going where the way it's written now.

Not sure there's a choice here, usually it's preferred to compress
lines if there's a possibility.

> 
> > > +		break;
> > > +	case IECM_FDIR_FLOW_IPV4_AH:

--- 8< ---

> > > +	fdir_config = &adapter->config_data.fdir_config;
> > > +	list_for_each_entry(rule, &fdir_config->fdir_fltr_list, list)
> > > +		if (rule->loc == loc)
> > > +			return rule;
> > 
> > Here's a good example that a single `if` statement shouldn't be
> > placed into a pair of braces.
> > 
> 
> You're right it does need some braces on the list_for_each, will fix.

I said the opposite, please don't present your opinion as mine. I'm
not sure it's a correct thing to do during the review.
As mentioned previously plenty of times, braces are expected only
when they're purely necessary. Your approach doesn't even improve
the readability as you claim.

> 
> > > +
> > > +	return NULL;
> > > +}
> > > +
> > > +/**
> > > + * iecm_fdir_list_add_fltr - add a new node to the flow director filter list

--- 8< ---

> > > + * If the mask is fully set return true. If it is not valid for field return
> > > + * false.
> > > + */
> > > +static bool iecm_is_mask_valid(u64 mask, u64 field)
> > > +{
> > > +	return (mask & field) == field;
> > > +}
> > 
> > That is something really basic and should at least be placed
> > somewhere in the headers and used module-wide.
> > 
> 
> I'm not convinced it makes sense to do that if it's not actually being used module wide. I'm pretty sure this is only validating user input for flow director filters.

`(mask & field) == field` pattern is used widely across iecm code.
This function simply won't pass the review. If it reflects FD logics
somehow, this should be explained in the kdoc block, so there'll be
less questions why it's here at all. For now it looks like a generic
function, not FD-specific one.
Anyway, I've just highlighted all references to this function and
it's used only *once* throughout the code. So it's a pure overkill
and should be just open-coded there.

> 
> > > +
> > > +/**
> > > + * iecm_parse_rx_flow_user_data - deconstruct user-defined data

--- 8< ---

> > > +enum iecm_fdir_flow_type {
> > > +	/* NONE - used for undef/error */
> > > +	IECM_FDIR_FLOW_NONE = 0,
> > 
> > Enums always start with 0 unless other value specified, this is a
> > bit excessive.
> > 
> 
> AFAIK this is the normal thing to do in Linux kernel.  In cases where the value actually matters, as is here, it's better to be explicit even though yes you're right it should be getting the default value of zero.

Does it? It mostly only matters when it's being passed to HW anyhow,
but I'm not sure it's the case here.
Anyways, I admit it's rather a personal preference, so I don't mind.

> 
> E.g. in kernel/sched/sched.h you can find:
> 
> /* The regions in numa_faults array from task_struct */
> enum numa_faults_stats {
>         NUMA_MEM = 0,
>         NUMA_CPU,
>         NUMA_MEMBUF,
>         NUMA_CPUBUF
> };
> 
> and probably many more.
> 
> > > +	IECM_FDIR_FLOW_IPV4_TCP,

--- 8< ---

> > > --
> > > 2.33.0
> > 
> > Thanks,
> > Al

Thanks,
Al
