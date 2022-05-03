From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Tue,  3 May 2022 18:23:16 +0200
Subject: [Intel-wired-lan] [PATCH net-next v1] ice: Expose RSS
 indirection tables for queue groups via ethtool
In-Reply-To: <IA1PR11MB626623C27C5766E09B8A74BEE4C09@IA1PR11MB6266.namprd11.prod.outlook.com>
References: <20220503132428.1859432-1-sudheer.mogilappagari@intel.com>
 <20220503152908.395702-1-alexandr.lobakin@intel.com>
 <IA1PR11MB626623C27C5766E09B8A74BEE4C09@IA1PR11MB6266.namprd11.prod.outlook.com>
Message-ID: <20220503162316.397823-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
Date: Tue, 3 May 2022 16:04:12 +0000

> > -----Original Message-----
> > From: Lobakin, Alexandr <alexandr.lobakin@intel.com>
> > Sent: Tuesday, May 3, 2022 8:29 AM
> > To: Mogilappagari, Sudheer <sudheer.mogilappagari@intel.com>
> > Cc: Lobakin, Alexandr <alexandr.lobakin@intel.com>; Samudrala, Sridhar
> > <sridhar.samudrala@intel.com>; Paul Menzel <pmenzel@molgen.mpg.de>;
> > intel-wired-lan at osuosl.org
> > Subject: Re: [Intel-wired-lan] [PATCH net-next v1] ice: Expose RSS
> > indirection tables for queue groups via ethtool
> > 
> > From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> > Date: Tue,  3 May 2022 06:24:28 -0700
> > 
> > > From: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > >
> > > When ADQ queue groups(TCs) are created via tc mqprio command, RSS
> > > contexts and associated RSS indirection tables are configured
> > > automatically per TC based on the queue ranges specified for each
> > > traffic class.
> > >
> > > For ex:
> > > tc qdisc add dev enp175s0f0 root mqprio num_tc 3 map 0 1 2 \
> > > 	queues 2 at 0 8 at 2 4 at 10 hw 1 mode channel
> > >
> > > will create 3 queue groups(TC 0-2) with queue ranges 2, 8 and 4 in 3
> > > queue groups. Each queue group is associated with its own RSS context
> > > and RSS indirection table.
> > >
> > > Add support to expose RSS indirection tables for all ADQ queue groups
> > > using ethtool RSS contexts interface.
> > > 	ethtool -x enp175s0f0 context <tc-num>
> > >
> > > Signed-off-by: Sridhar Samudrala<sridhar.samudrala@intel.com>
> > > Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> > 
> > You didn't answer to any of my comments or questions during the internal
> > review, including the ones that Paul has just asked, and now you're
> > posting the same version to IWL to get it accepted upstream.
> > That's not how it works, NAK.
> > 
> 
> I had responded to your comments (on 4/22) and posted v2 (on 4/23).
> Posted here since there were no further comments. Will incorporate
> Paul's comments in v2.

Oh Gods, I'm super sorry. I completely overlooked your response.
It's present in my inbox. Please ignore my mail, sorry again.

> 
> > > ---
> > >  drivers/net/ethernet/intel/ice/ice_ethtool.c | 69
> > > +++++++++++++++-----
> > >  1 file changed, 51 insertions(+), 18 deletions(-)

[...]

> > > --
> > > 2.27.0
> > 
> > Thanks,
> > Al

Thanks,
Al
