From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 19 Jul 2017 19:26:32 +0000
Subject: [Intel-wired-lan] [next PATCH S76-V2 04/13] i40e: initialize
 our	affinity_mask based on cpu_possible_mask
In-Reply-To: <20170714131019.52530-4-alice.michael@intel.com>
References: <20170714131019.52530-1-alice.michael@intel.com>
 <20170714131019.52530-4-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB24D9@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S76-V2 04/13] i40e: initialize our
> affinity_mask based on cpu_possible_mask
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> On older kernels a call to irq_set_affinity_hint does not guarantee that the
> IRQ affinity will be set. If nothing else on the system sets the IRQ affinity this
> can result in a bug in the i40e_napi_poll() routine where we notice that our
> interrupt fired on the "wrong" CPU according to our internal affinity_mask
> variable.
> 
> This results in a bug where we continuously tell napi to stop polling to move
> the interrupt to a new CPU, but the CPU never changes because our affinity
> mask does not match the actual mask setup for the IRQ.
> 
> The root problem is a mismatched affinity mask value. So lets initialize the
> value to cpu_possible_mask instead. This ensures that prior to the first time
> we get an irq affinity notification we'll have the mask set to include every
> possible CPU.
> 
> We use cpu_possible_mask instead of cpu_online_mask since the former is
> almost certainly never going to change, while the later might change after
> we've made a copy.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c     | 12 +++++++-----
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c |  7 +++++--
>  2 files changed, 12 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


