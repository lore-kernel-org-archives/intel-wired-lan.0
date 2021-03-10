From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 10 Mar 2021 00:01:09 +0000
Subject: [Intel-wired-lan] [PATCH RESEND][next] ice: Fix fall-through
 warnings for Clang
In-Reply-To: <833549f5-a191-b532-50bf-4ec343c48dd0@molgen.mpg.de>
References: <20210305085257.GA138498@embeddedor>
 <833549f5-a191-b532-50bf-4ec343c48dd0@molgen.mpg.de>
Message-ID: <CO1PR11MB51052F33DA15B71D28E29993FA919@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Paul Menzel
> Sent: Friday, March 5, 2021 1:04 AM
> To: Gustavo A. R. Silva <gustavoars@kernel.org>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>;
> Jakub Kicinski <kuba@kernel.org>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> hardening at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: Re: [Intel-wired-lan] [PATCH RESEND][next] ice: Fix fall-through
> warnings for Clang
> 
> Dear Gustavo,
> 
> 
> Thank you for working on that.
> 
> Am 05.03.21 um 09:52 schrieb Gustavo A. R. Silva:
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix a
> > warning by explicitly adding a break statement instead of just letting
> > the code fall through to the next case.
> 
> It would be nice to have a short summary of the discrepancy between GCC
> and clang, and it was decided to go with the ?clang decision?, and not have
> clang adapt to GCC.
> 
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >   drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 1 +
> >   1 file changed, 1 insertion(+)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


