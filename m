From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Apr 2019 21:54:05 +0000
Subject: [Intel-wired-lan] [PATCH S19 04/15] ice: Call out dev/func caps
 when printing
In-Reply-To: <20190416172439.27908-5-anirudh.venkataramanan@intel.com>
References: <20190416172439.27908-1-anirudh.venkataramanan@intel.com>
 <20190416172439.27908-5-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3999CB@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:24 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S19 04/15] ice: Call out dev/func caps when
> printing
> 
> ice_parse_caps is used to parse both device and function capabilities.
> Currently, capabilities are printed with a cryptic "HW caps" prefix, which
> makes it difficult to distinguish whether the capabilities being printed are
> device or function capabilities.
> 
> This patch makes a change to add a "func cap" prefix when printing function
> capabilities, and a "dev cap" prefix when printing device capabilities.
> 
> This patch also changes some of the capability print strings for consistency.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 56 +++++++++++----------
>  1 file changed, 30 insertions(+), 26 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


