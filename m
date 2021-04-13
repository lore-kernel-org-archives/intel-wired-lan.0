From: Salil Mehta <salil.mehta@huawei.com>
Date: Tue, 13 Apr 2021 08:25:58 +0000
Subject: [Intel-wired-lan] [PATCH net] ice: Re-organizes reqstd/avail {R,
 T}XQ check/code for efficiency+readability
In-Reply-To: <03655fb6faa595a20a1143fb3b01561042cd317f.camel@intel.com>
References: <20210411014530.25060-1-salil.mehta@huawei.com>
 <03655fb6faa595a20a1143fb3b01561042cd317f.camel@intel.com>
Message-ID: <8fd160b556fc4d45bff2d607918aad33@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Anthony,
Thanks for reviewing!

> From: Nguyen, Anthony L [mailto:anthony.l.nguyen at intel.com]
> Sent: Monday, April 12, 2021 11:41 PM
> To: davem at davemloft.net; kuba at kernel.org; Salil Mehta <salil.mehta@huawei.com>
> Cc: netdev at vger.kernel.org; linux-kernel at vger.kernel.org; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; linuxarm at openeuler.org; Tieman, Henry W
> <henry.w.tieman@intel.com>; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH net] ice: Re-organizes reqstd/avail {R,T}XQ check/code for
> efficiency+readability
> 
> On Sun, 2021-04-11 at 02:45 +0100, Salil Mehta wrote:
> > If user has explicitly requested the number of {R,T}XQs, then it is
> > unnecessary
> > to get the count of already available {R,T}XQs from the PF
> > avail_{r,t}xqs
> > bitmap. This value will get overriden by user specified value in any
> 
> s/overriden/overridden

Ok.

> 
> > case.
> >
> > This patch does minor re-organization of the code for improving the
> > flow and
> > readabiltiy. This scope of improvement was found during the review of
> > the ICE
> > driver code.
> 
> The changes themselves look ok, but there are some checkpatch issues.
> Also, could you include intel-wired-lan at lists.osuosl.org

Sure. will fix them.

> 
> > FYI, I could not test this change due to unavailability of the
> > hardware. It
> > would helpful if somebody can test this and provide Tested-by Tag.
> > Many thanks!
> >
> > Fixes: 11b7551e096d ("ice: Implement ethtool ops for channels")
> 
> This commit id doesn't exist.

Will fix. Sorry about this.

> 
> > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_lib.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c
> > b/drivers/net/ethernet/intel/ice/ice_lib.c
> > index d13c7fc8fb0a..161e8dfe548c 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> > @@ -161,12 +161,13 @@ static void ice_vsi_set_num_qs(struct ice_vsi
> > *vsi, u16 vf_id)
> >
> >  	switch (vsi->type) {
> >  	case ICE_VSI_PF:
> > -		vsi->alloc_txq = min3(pf->num_lan_msix,
> > -				      ice_get_avail_txq_count(pf),
> > -				      (u16)num_online_cpus());
> >  		if (vsi->req_txq) {
> >  			vsi->alloc_txq = vsi->req_txq;
> >  			vsi->num_txq = vsi->req_txq;
> > +		} else {
> > +			vsi->alloc_txq = min3(pf->num_lan_msix,
> > +					 ice_get_avail_txq_count(pf),
> > +					 (u16)num_online_cpus());
> 
> Alignment is incorrect.

Ok. Will check, perhaps the cause of the checkpatch.pl errors.

> 
> >  		}
> >
> >  		pf->num_lan_tx = vsi->alloc_txq;
> > @@ -175,12 +176,13 @@ static void ice_vsi_set_num_qs(struct ice_vsi
> > *vsi, u16 vf_id)
> >  		if (!test_bit(ICE_FLAG_RSS_ENA, pf->flags)) {
> >  			vsi->alloc_rxq = 1;
> >  		} else {
> > -			vsi->alloc_rxq = min3(pf->num_lan_msix,
> > -					      ice_get_avail_rxq_count(p
> > f),
> > -					      (u16)num_online_cpus());
> >  			if (vsi->req_rxq) {
> >  				vsi->alloc_rxq = vsi->req_rxq;
> >  				vsi->num_rxq = vsi->req_rxq;
> > +			} else {
> > +				vsi->alloc_rxq = min3(pf->num_lan_msix,
> > +						 ice_get_avail_rxq_coun
> > t(pf),
> > +						 (u16)num_online_cpus()
> 
> Same, alignment is incorrect.

Ok. Will fix.

Thanks
Salil.
