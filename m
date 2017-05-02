From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 2 May 2017 19:17:36 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 3/3] i40evf: disable
 unused	flags
In-Reply-To: <1493423597-18306-4-git-send-email-jesse.brandeburg@intel.com>
References: <1493423597-18306-1-git-send-email-jesse.brandeburg@intel.com>
 <1493423597-18306-2-git-send-email-jesse.brandeburg@intel.com>
 <1493423597-18306-3-git-send-email-jesse.brandeburg@intel.com>
 <1493423597-18306-4-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA1F6C@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next v1 3/3] i40evf: disable unused
> flags
> 
> The i40evf hardware doesn't have any way to ever report FCoE enabled so
> just force the code to always report FCoE is disabled, remove the unused
> defines, and mark the OP as reserved.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40e_common.c   | 3 +--
>  drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


