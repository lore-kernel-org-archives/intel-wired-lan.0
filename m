From: Ivan Vecera <ivecera@redhat.com>
Date: Fri, 25 Mar 2022 13:33:41 +0100
Subject: [Intel-wired-lan] [PATCH net] ice: Fix MAC address setting
In-Reply-To: <YjxVRqTppQeYKb1h@boxer>
References: <20220323135829.4015645-1-ivecera@redhat.com>
 <CO1PR11MB508946CC906E8B851D69D31AD6189@CO1PR11MB5089.namprd11.prod.outlook.com>
 <YjxVRqTppQeYKb1h@boxer>
Message-ID: <20220325133341.78821438@ceranb>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 24 Mar 2022 12:25:58 +0100
Maciej Fijalkowski <maciej.fijalkowski@intel.com> wrote:

> On Wed, Mar 23, 2022 at 05:28:02PM +0000, Keller, Jacob E wrote:
> > 
> >   
> > > -----Original Message-----
> > > From: Ivan Vecera <ivecera@redhat.com>
> > > Sent: Wednesday, March 23, 2022 6:58 AM
> > > To: netdev at vger.kernel.org
> > > Cc: poros at redhat.com; mschmidt at redhat.com; Brandeburg, Jesse
> > > <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> > > <anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>; Jakub
> > > Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; moderated
> > > list:INTEL ETHERNET DRIVERS <intel-wired-lan@lists.osuosl.org>; open list <linux-  
> > > kernel at vger.kernel.org>  
> > > Subject: [PATCH net] ice: Fix MAC address setting
> > > 
> > > Commit 2ccc1c1ccc671b ("ice: Remove excess error variables") merged
> > > the usage of 'status' and 'err' variables into single one in
> > > function ice_set_mac_address(). Unfortunately this causes
> > > a regression when call of ice_fltr_add_mac() returns -EEXIST because
> > > this return value does not indicate an error in this case but
> > > value of 'err' value remains to be -EEXIST till the end of  
> 
> s/'err' value/'err'
> 
> > > the function and is returned to caller.
> > > 
> > > Prior this commit this does not happen because return value of  
> 
> s/this/mentioned ?
> 
> > > ice_fltr_add_mac() was stored to 'status' variable first and
> > > if it was -EEXIST then 'err' remains to be zero.
> > > 
> > > The patch fixes the problem by reset 'err' to zero when
> > > ice_fltr_add_mac() returns -EEXIST.  
> 
> Again, i'd recommend imperative mood. Besides, good catch!
> 
> > > 
> > > Fixes: 2ccc1c1ccc671b ("ice: Remove excess error variables")
> > > Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> > > ---
> > >  drivers/net/ethernet/intel/ice/ice_main.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> > > b/drivers/net/ethernet/intel/ice/ice_main.c
> > > index 168a41ea37b8..420558d1cd21 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > > @@ -5474,14 +5474,15 @@ static int ice_set_mac_address(struct net_device
> > > *netdev, void *pi)
> > > 
> > >  	/* Add filter for new MAC. If filter exists, return success */
> > >  	err = ice_fltr_add_mac(vsi, mac, ICE_FWD_TO_VSI);
> > > -	if (err == -EEXIST)
> > > +	if (err == -EEXIST) {
> > >  		/* Although this MAC filter is already present in hardware it's
> > >  		 * possible in some cases (e.g. bonding) that dev_addr was
> > >  		 * modified outside of the driver and needs to be restored back
> > >  		 * to this value.
> > >  		 */
> > >  		netdev_dbg(netdev, "filter for MAC %pM already exists\n", mac);
> > > -	else if (err)
> > > +		err = 0;
> > > +	} else if (err)
> > >  		/* error if the new filter addition failed */
> > >  		err = -EADDRNOTAVAIL;
> > >   
> > 
> > Style wise, don't we typically use {} for all branches if its needed on one?  
> 
> +1, please add braces around second branch as well.
> 
> > 
> > I'm ok takin this fix as-is now and doing the {} fix up afterwards if we want to avoid delay.
> > 
> > Thanks,
> > Jake
> >   
> > > --
> > > 2.34.1  
> >   
> 

Will fix by v2

Ivan

