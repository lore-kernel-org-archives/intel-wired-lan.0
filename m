From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 21 Jul 2017 20:47:06 +0000
Subject: [Intel-wired-lan] [next PATCH S77-V3 07/10] i40e: shutdown all
 IRQs	and disable MSI-X when suspended
In-Reply-To: <20170714132709.52657-7-alice.michael@intel.com>
References: <20170714132709.52657-1-alice.michael@intel.com>
 <20170714132709.52657-7-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB2792@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, July 14, 2017 6:27 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S77-V3 07/10] i40e: shutdown all IRQs
> and disable MSI-X when suspended
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> On some platforms with a large number of CPUs, we will allocate many IRQ
> vectors. When hibernating, the system will attempt to migrate all of the
> vectors back to CPU0 when shutting down all the other CPUs. It is possible
> that we have so many vectors that it cannot re-assign them to CPU0. This is
> even more likely if we have many devices installed in one platform.
> 
> The end result is failure to hibernate, as it is not possible to shutdown the
> CPUs. We can avoid this by disabling MSI-X and clearing our interrupt scheme
> when the device is suspended. A more ideal solution would be some method
> for the stack to properly handle this for all drivers, rather than on a case-by-
> case basis for each driver to fix itself.
> 
> However, until this more ideal solution exists, we can do our part and
> shutdown our IRQs during suspend, which should allow systems with a large
> number of CPUs to safely suspend or hibernate.
> 
> It may be worth investigating if we should shut down even further when we
> suspend as it may make the path cleaner, but this was the minimum fix for
> the hibernation issue mentioned here.
> 
> Testing-hints:
>   This affects systems with a large number of CPUs, and with multiple
>   devices enabled. Without this change, those platforms are unable to
>   hibernate at all.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c     | 68
> ++++++++++++++++++++++++-
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c |  2 +-
>  2 files changed, 68 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


