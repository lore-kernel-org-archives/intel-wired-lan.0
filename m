From: Ertman, David M <david.m.ertman@intel.com>
Date: Thu, 10 Mar 2022 19:26:02 +0000
Subject: [Intel-wired-lan] [PATCH net] ice: Fix race condition during
 interface enslave
In-Reply-To: <20220310190642.556063ae@ceranb>
References: <20220310171641.3863659-1-ivecera@redhat.com>
 <MW5PR11MB58114999381C7B98598BB568DD0B9@MW5PR11MB5811.namprd11.prod.outlook.com>
 <20220310190642.556063ae@ceranb>
Message-ID: <MW5PR11MB5811049F89D38725FBE7FC26DD0B9@MW5PR11MB5811.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Ivan Vecera <ivecera@redhat.com>
> Sent: Thursday, March 10, 2022 10:07 AM
> To: Ertman, David M <david.m.ertman@intel.com>
> Cc: netdev at vger.kernel.org; Petr Oros <poros@redhat.com>; Brandeburg,
> Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>;
> Jakub Kicinski <kuba@kernel.org>; moderated list:INTEL ETHERNET DRIVERS"
> <intel-wired-lan@lists.osuosl.org>, open list <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH net] ice: Fix race condition during interface enslave
> 
> On Thu, 10 Mar 2022 17:48:16 +0000
> "Ertman, David M" <david.m.ertman@intel.com> wrote:
> 
> > This only addresses one case of unplugging the auxiliary bus.  Rather than
> controlling one instance of
> > calling ice_unplig_aux_dev(), it seems like it would be better to modify
> ice_unplug_aux_dev so that it
> > will pause until any plugging is done by the service task (check for the pf-
> >flag bit and wait until it clears
> > before progressing).
> 
> You cannot wait in ice_unplug_aux_dev() for ICE_FLAG_PLUG_AUX_DEV to
> be cleared because
> ice_clear_rdma_cap() is called under RTNL.
> This patch is a counter part for commit 5dbbbd01cbba83 ("ice: Avoid RTNL
> lock when
> re-creating auxiliary device") that eliminates ice_plug_aux() and fixed first
> part
> of deadlock and this patch fixes a second part and eliminates also
> ice_unplug_aux_dev()
> to be called under RTNL.
> 
> Thanks,
> Ivan

You are correct.  I forgot about the RTNL context!

With this in mind - I agree with your approach.

Reviewed-by: Dave Ertman <david.m.ertman@intel.com>


