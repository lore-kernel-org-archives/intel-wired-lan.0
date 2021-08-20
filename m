From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Fri, 20 Aug 2021 17:58:13 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 1/3] ice-linux: update dim
 usage and moderation
In-Reply-To: <CO1PR11MB48352C797E4F83E105174C67F5C09@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20210819192959.590146-1-jesse.brandeburg@intel.com>
 <20210819192959.590146-2-jesse.brandeburg@intel.com>
 <CO1PR11MB48352C797E4F83E105174C67F5C09@CO1PR11MB4835.namprd11.prod.outlook.com>
Message-ID: <86aabb2dd6051305786669ac45ddb9e4d9475bff.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2021-08-19 at 20:55 +0000, Creeley, Brett wrote:
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On
> > Behalf Of Jesse Brandeburg
> > Sent: Thursday, August 19, 2021 12:30 PM
> > To: intel-wired-lan at lists.osuosl.org
> > Subject: [Intel-wired-lan] [PATCH net-next v2 1/3] ice-linux:
> > update dim usage and moderation
> 
> I think the subject should be "ice: ..." instead of "ice-linux: ...".
> Same
> goes for 2/3 and 3/3.

I agree with Brett. ice, not ice-linux. I was going to fix that up
myself, however, this isn't applying after Maciej's series [1]. It
looked largely due to the split of ice_ring [2], but I didn't see if
there were other conflicts. Could you update and accommodate the
series' changes so it'll apply?

Thanks,
Tony


[1] 
https://patchwork.ozlabs.org/project/intel-wired-lan/list/?series=258748
[2] https://patchwork.ozlabs.org/patch/1518639

> > The driver was having trouble with unreliable latency when doing
> > single
> > threaded ping-pong tests. This was root caused to the DIM algorithm
> > landing on a too slow interrupt value, which caused high latency,
> > and it
> > was especially present when queues were being switched frequently
> > by the
> > scheduler as happens on default setups today.
> > 
> > In attempting to improve this, we allow the upper rate limit for
> > interrupts to move to rate limit of 4 microseconds as a max, which
> > means
> > that no vector can generate more than 250,000 interrupts per
> > second. The
> > old config was up to 100,000. The driver previously tried to
> > program the
> > rate limit too frequently and if the receive and transmit side were
> > both
> > active on the same vector, the INTRL would be set incorrectly, and
> > this
> > change fixes that issue as a side effect of the redesign.
> > 
> > This driver will operate from now on with a slightly changed DIM
> > table
> > with more emphasis towards latency sensitivity by having more table
> > entries with lower latency than with high latency (high being >= 64
> > microseconds).
> > 
> > The driver also resets the DIM algorithm state with a new stats set
> > when
> > there is no work done and the data becomes stale (older than 1
> > second),
> > for the respective receive or transmit portion of the interrupt.
> > 
> > Add a new helper for setting rate limit, which will be used more
> > in a followup patch.
> > 
> > Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_lib.c  |  25 +++++
> >  drivers/net/ethernet/intel/ice/ice_lib.h  |   1 +
> >  drivers/net/ethernet/intel/ice/ice_main.c | 118 ++++++++++++----
> > ------
> >  drivers/net/ethernet/intel/ice/ice_txrx.c |  73 ++++++-------
> >  4 files changed, 130 insertions(+), 87 deletions(-)
> 
> <snip>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
