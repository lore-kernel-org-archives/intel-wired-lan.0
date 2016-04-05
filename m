From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 5 Apr 2016 19:43:31 +0000
Subject: [Intel-wired-lan] [v3 next PATCH S32 01/13] i40e: Inserting a
 HW	capability display info
In-Reply-To: <1459508173-22777-2-git-send-email-harshitha.ramamurthy@intel.com>
References: <1459508173-22777-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1459508173-22777-2-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9ACB84@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Harshitha Ramamurthy
> Sent: Friday, April 01, 2016 3:56 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [v3 next PATCH S32 01/13] i40e: Inserting a HW
> capability display info
> 
> From: Deepthi Kavalur <deepthi.kavalur@intel.com>
> 
> Display MSIx vector count for HW capabilities.
> 
> Signed-off-by: Deepthi Kavalur <deepthi.kavalur@intel.com>
> Change-ID: I4b41e9b50360cf660e7fbcb85b9390fedcf313b1
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
MSIX vector count message shows up with debug messages enabled
