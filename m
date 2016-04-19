From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 19 Apr 2016 21:57:39 +0000
Subject: [Intel-wired-lan] [PATCH next S35 v3 3/9] i40e/i40evf:
	Remove	reference to ring->dtype
In-Reply-To: <1461004429-34316-4-git-send-email-jesse.brandeburg@intel.com>
References: <1461004429-34316-1-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-2-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-3-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-4-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D2362@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Monday, April 18, 2016 11:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH next S35 v3 3/9] i40e/i40evf: Remove
> reference to ring->dtype
> 
> As part of the rx-refactor, the dtype variable in the i40e_ring struct is no
> longer used, so remove it.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 8 ++------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h    | 1 -
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h  | 1 -
>  3 files changed, 2 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
References no longer present in dump stats
