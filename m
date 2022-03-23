From: Ivan Vecera <ivecera@redhat.com>
Date: Wed, 23 Mar 2022 18:49:36 +0100
Subject: [Intel-wired-lan] [PATCH net] ice: Fix MAC address setting
In-Reply-To: <20220323190519.GA23730@kplh.igk.intel.com>
References: <20220323135829.4015645-1-ivecera@redhat.com>
 <20220323190519.GA23730@kplh.igk.intel.com>
Message-ID: <20220323184936.01a4d117@ceranb>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 23 Mar 2022 20:10:10 +0100
Piotr Raczynski <piotr.raczynski@intel.com> wrote:

> On Wed, Mar 23, 2022 at 02:58:29PM +0100, Ivan Vecera wrote:
> > Commit 2ccc1c1ccc671b ("ice: Remove excess error variables") merged
> > the usage of 'status' and 'err' variables into single one in
> > function ice_set_mac_address(). Unfortunately this causes
> > a regression when call of ice_fltr_add_mac() returns -EEXIST because
> > this return value does not indicate an error in this case but
> > value of 'err' value remains to be -EEXIST till the end of
> > the function and is returned to caller.
> > 
> > Prior this commit this does not happen because return value of
> > ice_fltr_add_mac() was stored to 'status' variable first and
> > if it was -EEXIST then 'err' remains to be zero.
> > 
> > The patch fixes the problem by reset 'err' to zero when
> > ice_fltr_add_mac() returns -EEXIST.
> > 
> > Fixes: 2ccc1c1ccc671b ("ice: Remove excess error variables")
> > Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_main.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> > index 168a41ea37b8..420558d1cd21 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > @@ -5474,14 +5474,15 @@ static int ice_set_mac_address(struct net_device *netdev, void *pi)
> >  
> >  	/* Add filter for new MAC. If filter exists, return success */
> >  	err = ice_fltr_add_mac(vsi, mac, ICE_FWD_TO_VSI);
> > -	if (err == -EEXIST)
> > +	if (err == -EEXIST) {
> >  		/* Although this MAC filter is already present in hardware it's
> >  		 * possible in some cases (e.g. bonding) that dev_addr was
> >  		 * modified outside of the driver and needs to be restored back
> >  		 * to this value.
> >  		 */
> >  		netdev_dbg(netdev, "filter for MAC %pM already exists\n", mac);
> > -	else if (err)
> > +		err = 0;  
> 
> Thanks Ivan, This looks fine. It is a regression as I checked since
> driver used to return success in such case. It seems that the only
> way to have EEXIST here is when the same MAC is requested, I'd also
> consider just return 0 here to skip later firwmare write which seems
> redundant here.

Yes, firmware write looks for me also redundant but to be I wanted to restore
only the previous behavior broken by mentioned commit.

Thanks,
Ivan

