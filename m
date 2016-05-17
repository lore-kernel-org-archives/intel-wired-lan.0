From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 17 May 2016 16:44:01 +0000
Subject: [Intel-wired-lan] [next PATCH S37 07/15] i40e: Clean up MSIX
 irqs	before suspend
In-Reply-To: <1463419605-30746-8-git-send-email-bimmy.pujari@intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
 <1463419605-30746-8-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D68A1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, May 16, 2016 10:27 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S37 07/15] i40e: Clean up MSIX irqs
> before suspend
> 
> From: Greg Rose <gregory.v.rose@intel.com>
> 
> The i40e_suspend() function calls another function that preps the device for
> the power save and resume by freeing all the tx/rx resources and interrupts
> but that function does not free the "other" causes interrupt vector and irq. It
> also fails to call synchronize_irq() before freeing the irq vectors.  This
> sometimes may result in some AER errors on those systems with that PCIe
> error reporting feature enabled.
> 
> Call synchronize_irq() before freeing irq vectors and explicitly free the other
> causes interrupt resources and shut down that MSIX interrupt.
> 
> Signed-off-by: Greg Rose <gregory.v.rose@intel.com>
> Change-ID: Ib88e4536756518a352446da0232189716618ad81
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Device suspends and resumes as expected
