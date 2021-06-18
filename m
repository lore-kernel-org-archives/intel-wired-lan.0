From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Fri, 18 Jun 2021 21:51:46 +0000
Subject: [Intel-wired-lan] [PATCH net v3 0/3] iavf: Fix init and
 watchdog state machines
In-Reply-To: <20210618092746.vhj334aaoiqinok4@p50>
References: <20210618090346.12405-1-mateusz.palczewski@intel.com>
 <20210618092746.vhj334aaoiqinok4@p50>
Message-ID: <dd3ae8d68410a7aa766153e1cbecd1ccb4657730.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2021-06-18 at 11:27 +0200, Stefan Assmann wrote:
> On 2021-06-18 11:03, Mateusz Palczewski wrote:
> > Use single state machine for driver initialization
> > and for service initialized driver. The init state
> > machine implemented in init_task() is merged
> > into the watchdog_task(). The init_task() function
> > is removed.
> 
> Since this is code refactoring I think this should be applied via
> net-next.

I agree with Stefan. This seems like a better fit for net-next unless
you have a specific bug/issue you are resolving. If so, please include
that in the descriptions and put the fix in net patches with refactors
in net-next patches.

Also, are you using the correct tree and branch? Rebasing before you
send these? This does not apply to either tree (net-queue or next-
queue).

> > ---
> > v3: Added new file to patch series
> 
> Thanks for splitting the patches up!
> 
>   Stefan
> 
> > v2: Splitted the patch into 2 to make them smaller
> > ---
> > 
> > Jan Sokolowski (3):
> >   iavf: Refactor iavf state machine tracking
> >   iavf: Add __IAVF_INIT_FAILED state
> >   iavf: Fix init and watchdog state machines
> > 
> >  drivers/net/ethernet/intel/iavf/iavf.h        |  12 +-
> >  drivers/net/ethernet/intel/iavf/iavf_main.c   | 188 +++++++++-----
> > ----
> >  .../net/ethernet/intel/iavf/iavf_virtchnl.c   |   2 +-
> >  3 files changed, 103 insertions(+), 99 deletions(-)
> > 
> > -- 
> > 2.27.0
> > 
> > _______________________________________________
> > Intel-wired-lan mailing list
> > Intel-wired-lan at osuosl.org
> > https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> > 
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
