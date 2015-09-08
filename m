From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 8 Sep 2015 18:16:40 +0000
Subject: [Intel-wired-lan] [next PATCH S11 03/15] i40e: stop VF rings
In-Reply-To: <1440616461-110869-4-git-send-email-catherine.sullivan@intel.com>
References: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
 <1440616461-110869-4-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A5A69@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Wednesday, August 26, 2015 12:14 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S11 03/15] i40e: stop VF rings
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Explicitly stop the rings belonging to each VF when disabling SR-IOV.
> Even though the VFs were gone, and the associated VSIs were removed, the
> rings were not stopped, and in some circumstances the hardware would
> continue to access the memory formerly used by the rings, causing memory
> corruption or DMAR errors, both of which would lead to general malaise of
> the kernel.
> 
> To relieve this condition, explicitly stop all the rings associated with each VF
> before releasing its resources.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I78c05d562c66e7b594b7e48d67860f49b3e5b6ec
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 5 +++++
>  1 file changed, 5 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree, memory released when VFs are removed.
