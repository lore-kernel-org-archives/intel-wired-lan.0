From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Wed, 30 Mar 2022 14:18:35 +0200
Subject: [Intel-wired-lan] [PATCH net v2] ice: Fix MAC address setting
In-Reply-To: <CO1PR11MB508954503C974FD6D9E162FCD61D9@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20220325132524.1765342-1-ivecera@redhat.com>
 <CO1PR11MB508954503C974FD6D9E162FCD61D9@CO1PR11MB5089.namprd11.prod.outlook.com>
Message-ID: <20220330121835.2737360-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 28 Mar 2022 17:53:19 +0000

Hey netdev maintainers,

> > -----Original Message-----
> > From: Ivan Vecera <ivecera@redhat.com>
> > Sent: Friday, March 25, 2022 6:25 AM
> > To: netdev at vger.kernel.org
> > Cc: poros <poros@redhat.com>; mschmidt <mschmidt@redhat.com>;
> > Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>; Jakub
> > Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; moderated
> > list:INTEL ETHERNET DRIVERS <intel-wired-lan@lists.osuosl.org>; open list <linux-
> > kernel at vger.kernel.org>
> > Subject: [PATCH net v2] ice: Fix MAC address setting
> > 
> > Commit 2ccc1c1ccc671b ("ice: Remove excess error variables") merged
> > the usage of 'status' and 'err' variables into single one in
> > function ice_set_mac_address(). Unfortunately this causes
> > a regression when call of ice_fltr_add_mac() returns -EEXIST because
> > this return value does not indicate an error in this case but
> > value of 'err' remains to be -EEXIST till the end of the function
> > and is returned to caller.
> > 
> > Prior mentioned commit this does not happen because return value of
> > ice_fltr_add_mac() was stored to 'status' variable first and
> > if it was -EEXIST then 'err' remains to be zero.
> > 
> > Fix the problem by reset 'err' to zero when ice_fltr_add_mac()
> > returns -EEXIST.
> > 
> > Fixes: 2ccc1c1ccc671b ("ice: Remove excess error variables")
> > Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> > ---
> 
> Thanks for the v2. This looks great. Good analysis of how this happened in the commit message, I appreciate that.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

This is an urgent fix, so we would like it to go through -net, not
IWL.
It has this Reviewed-by, and also

Acked-by: Alexander Lobakin <alexandr.lobakin@intel.com>

> 
> >  drivers/net/ethernet/intel/ice/ice_main.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 

--- 8< ---

> > --
> > 2.34.1

Thanks,
Al
