From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 21 Jul 2017 18:50:13 +0000
Subject: [Intel-wired-lan] [next PATCH S77-V3 04/10] i40e: use newer
 generic	PM support instead of legacy PM callbacks
In-Reply-To: <20170714132709.52657-4-alice.michael@intel.com>
References: <20170714132709.52657-1-alice.michael@intel.com>
 <20170714132709.52657-4-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB2733@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S77-V3 04/10] i40e: use newer generic
> PM support instead of legacy PM callbacks
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Stop using the old legacy PM support, since we now have stable support for
> the newer generic PM callbacks.
> 
> This has several advantages. First, we no longer have to manage our own
> pci_save_state() and power changes, as it's preferred to have the PCI stack
> do this. Second, these routines get called for both hibernate and suspend to
> ram, so we can have the driver properly handle all the suspend/resume
> flows that it needs to.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 54 +++++++++------------------
> --
>  1 file changed, 17 insertions(+), 37 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


