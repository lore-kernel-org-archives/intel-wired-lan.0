From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 19 Jul 2017 20:37:18 +0000
Subject: [Intel-wired-lan] [next PATCH S76-V2 05/13] i40e: invert logic
 for	checking incorrect cpu vs irq affinity
In-Reply-To: <20170714131019.52530-5-alice.michael@intel.com>
References: <20170714131019.52530-1-alice.michael@intel.com>
 <20170714131019.52530-5-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB2501@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, July 14, 2017 6:10 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S76-V2 05/13] i40e: invert logic for
> checking incorrect cpu vs irq affinity
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> In commit 96db776a3682 ("i40e/vf: fix interrupt affinity bug") we added
> some code to force exit of polling incase we did not have the correct CPU.
> This is important since it was possible for the IRQ affinity to be changed while
> the CPU is pegged at 100%. This can result in the polling routine being stuck
> on the wrong CPU until traffic finally stops.
> 
> Unfortunately, the implementation, "if the CPU is correct, exit as normal,
> otherwise, fall-through to the end-polling exit" is incredibly confusing to
> reason about. In this case, the normal flow looks like the exception, while the
> exception actually occurs far away from the if statement and comment.
> 
> We recently discovered and fixed a bug in this code because we were
> incorrectly initializing the affinity mask.
> 
> Re-write the code so that the exceptional case is handled at the check, rather
> than having the logic be spread through the regular exit flow.
> This does end up with minor code duplication, but the resulting code is much
> easier to reason about.
> 
> The new logic is identical, but inverted. If we are running on a CPU not in our
> affinity mask, we'll exit polling. However, the code flow is much easier to
> understand.
> 
> Note that we don't actually have to check for MSI-X, because in the MSI case
> we'll only have one q_vector, but its default affinity mask should be correct
> as it includes all CPUs when it's initialized. Further, we could at some point
> add code to setup the notifier for the non-MSI-X case and enable this
> workaround for that case too, if desired, though there isn't much gain since
> its unlikely to be the common case.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 31 +++++++++++++------------
> --
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 30 +++++++++++++----------
> ---
>  2 files changed, 30 insertions(+), 31 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


