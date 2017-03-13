From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 13 Mar 2017 14:50:41 +0000
Subject: [Intel-wired-lan] [next PATCH S61 04/10] i40e: Fixed
	race	conditions in VF reset
In-Reply-To: <1487721348-25617-5-git-send-email-bimmy.pujari@intel.com>
References: <1487721348-25617-1-git-send-email-bimmy.pujari@intel.com>
 <1487721348-25617-5-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A104027C4@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, February 21, 2017 3:56 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Konklewski, RobertX <robertx.konklewski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S61 04/10] i40e: Fixed race conditions
> in VF reset
> 
> From: Robert Konklewski <robertx.konklewski@intel.com>
> 
> First, this patch eliminates IOMMU DMAR Faults caused by VF hardware.
> This is done by enabling VF hardware only after VSI resources are freed.
> Otherwise, hardware could DMA into memory that is (or just has
> been) being freed.
> 
> Then, the VF driver is activated only after VSI resources have been
> reallocated. That's because the VF driver can request resources immediately
> after it's activated. So they need to be ready at that point.
> 
> The second race condition happens when the OS initiates a VF reset, and
> then before it's finished modifies VF's settings by changing its MAC, VLAN ID,
> bandwidth allocation, anti-spoof checking, etc. These functions needed to be
> blocked while VF is undergoing reset. Otherwise, they could operate on data
> structures that had just been freed or not yet fully initialized.
> 
> Signed-off-by: Robert Konklewski <robertx.konklewski@intel.com>
> Change-ID: I43ba5a7ae2c9a1cce3911611ffc4598ae33ae3ff
> ---
> Testing Hints:
>  Create 8 VMs with 8 VFs each (the more the better).
>  Set MTU=9000 for all VFs on Guest OS boot (this triggers VF reset).
>  Reboot all VMs at once, wait until they are up, repeat.
> 
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 43
> ++++++++++++++++++----
>  1 file changed, 35 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


