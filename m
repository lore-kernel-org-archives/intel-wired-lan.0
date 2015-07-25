From: Michael Ellerman <mpe@ellerman.id.au>
Date: Sat, 25 Jul 2015 19:12:58 +1000
Subject: [Intel-wired-lan] [PATCH] e1000e: Move
 e1000e_disable_aspm_locked() inside CONFIG_PM
In-Reply-To: <1437660446.23223.3.camel@intel.com>
References: <1436846075-29366-1-git-send-email-mpe@ellerman.id.au>
 <1436956216.13597.8.camel@intel.com>
 <1437529280.16792.9.camel@ellerman.id.au>
 <1437660446.23223.3.camel@intel.com>
Message-ID: <1437815578.8513.3.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2015-07-23 at 07:07 -0700, Jeff Kirsher wrote:
> On Wed, 2015-07-22 at 11:41 +1000, Michael Ellerman wrote:
> > On Wed, 2015-07-15 at 03:30 -0700, Jeff Kirsher wrote:
> > > On Tue, 2015-07-14 at 13:54 +1000, Michael Ellerman wrote:
> > > > e1000e_disable_aspm_locked() is only used in __e1000_resume()
> > which is
> > > > inside CONFIG_PM. So when CONFIG_PM=n we get a "defined but not
> > used"
> > > > warning for e1000e_disable_aspm_locked().
> > > > 
> > > > Move it inside the existing CONFIG_PM block to avoid the warning.
> > > > 
> > > > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > > > ---
> > > >  drivers/net/ethernet/intel/e1000e/netdev.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > NACK, this is already fixed in my next-queue tree.  Raanan submitted
> > a
> > > patch back on July 6th to resolve this issue, see commit id
> > > a75787d2246a93d256061db602f252703559af65 in my dev-queue branch of
> > my
> > > next-queue tree.
> > 
> > OK. I take it your next-queue is destined for 4.3, so we'll just have
> > to suck
> > on the warning until then?
> 
> Yes, but I can queue Raanan's patch up for 4.2 (and possibly stable) if
> necessary.  I have no issue with doing that.

For 4.2 would be nice, it would make my builds green again. But it's not the
end of the world if it has to wait until 4.3.

cheers


