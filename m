From: Shannon Nelson <shannon.lee.nelson@gmail.com>
Date: Thu, 14 Mar 2019 16:04:36 -0700
Subject: [Intel-wired-lan] [PATCH v4] i40e: Add macvlan support on i40e
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B96663CCA@ORSMSX101.amr.corp.intel.com>
References: <20190313170329.4569-1-harshitha.ramamurthy@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B96663CCA@ORSMSX101.amr.corp.intel.com>
Message-ID: <CAP-MU4NChuuRMpSUEyF0tchyZ4Fq84_jtobCNbiAy9BoZKRQ9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I was just noticing the same thing about the example steps.  You might
also want to add an "add address" command in there before the "set up"
command.
sln

On Thu, Mar 14, 2019 at 3:14 PM Brown, Aaron F <aaron.f.brown@intel.com> wrote:
>
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of
> > Harshitha Ramamurthy
> > Sent: Wednesday, March 13, 2019 10:03 AM
> > To: intel-wired-lan at lists.osuosl.org
> > Subject: [Intel-wired-lan] [PATCH v4] i40e: Add macvlan support on i40e
> >
> > This patch enables macvlan offloads for i40e. The idea is to use
> > channels as macvlan interfaces. The channels are VSIs of
> > type VMDQ. When the first macvlan is created, the maximum number of
> > channels possible are created. From then on, as a macvlan interface
> > is created, a mac filter is added to these already created channels
> > (VSIs).
> >
> > This patch builds on top of the recent changes which move
> > away from the select_queue implementation of picking the tx queue.
> >
> > Steps to configure macvlan offloads:
> > 1. sudo ethtool -K ens261f1 l2-fwd-offload on
> > 2. ip link add link ens261f1 name macvlan1 type macvlan
> > 3. sudo ip link add link ens261f1 name macvlan1 type macvlan
> > 4. sudo ip link set macvlan1 up
> >
> > Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> > ---
> > v4: Added code to check for a non-empty list of macvlans before deleting them
> >
> > v3: Renamed i40e_remove_macvlan_channels() to
> > i40e_free_macvlan_channels()
> >     Fixed an indentation issue and added some comments
> >     Removed a code name from the commit message
> >     Addressed some more of Shannon's comments
> >
> > v2: Addressed Shannon's comments
> >     Added a new function to remove all macvlan VSIs
> >
> >  drivers/net/ethernet/intel/i40e/i40e.h      |  26 ++
> >  drivers/net/ethernet/intel/i40e/i40e_main.c | 484 +++++++++++++++++++-
> >  2 files changed, 508 insertions(+), 2 deletions(-)
> >
>
> Step 2 and 3 in the example to configure macvlans are the same except for the use of sudo (which I suspect Jeff can fix up without another spin.)  Aside from that:
>
> Tested-by: Aaron Brown <aaron.f.brown@intel.com>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan



-- 
==============================================
Mr. Shannon Nelson         Parents can't afford to be squeamish.
