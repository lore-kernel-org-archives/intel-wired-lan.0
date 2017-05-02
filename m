From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 2 May 2017 19:17:12 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 2/3] i40evf: fix merge
 error	in older patch
In-Reply-To: <1493423597-18306-3-git-send-email-jesse.brandeburg@intel.com>
References: <1493423597-18306-1-git-send-email-jesse.brandeburg@intel.com>
 <1493423597-18306-2-git-send-email-jesse.brandeburg@intel.com>
 <1493423597-18306-3-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA1F5F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Friday, April 28, 2017 4:53 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v1 2/3] i40evf: fix merge error in
> older patch
> 
> This patch fixes a missing line that was missed while merging, which results in
> a driver feature in the VF not working to enable RSS as a negotiated feature.
> 
> Fixes: 43a3d9ba34c9c ("i40evf: Allow PF driver to configure RSS")
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


