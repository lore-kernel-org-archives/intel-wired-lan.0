From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 17 May 2016 16:45:08 +0000
Subject: [Intel-wired-lan] [next PATCH S37 08/15] i40e: Save PCI
	state	before suspend
In-Reply-To: <1463419605-30746-9-git-send-email-bimmy.pujari@intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
 <1463419605-30746-9-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D68B1@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S37 08/15] i40e: Save PCI state before
> suspend
> 
> From: Greg Rose <gregory.v.rose@intel.com>
> 
> The i40e_suspend() function was failing to save PCI state and this would
> result in a kernel stack trace from a WARN_ONCE in the
> pci_legacy_suspend() function.
> 
> Add a call to pci_save_state() to fix that problem.
> 
> Signed-off-by: Greg Rose <gregory.v.rose@intel.com>
> Change-ID: I4736e62bb660966bd208cc8af617a14cb07fc4bd
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Device suspends and resumes as expected
