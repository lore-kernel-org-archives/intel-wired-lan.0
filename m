From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Apr 2019 22:00:41 +0000
Subject: [Intel-wired-lan] [PATCH S19 11/15] ice: Use bitfields when
 possible
In-Reply-To: <20190416172439.27908-12-anirudh.venkataramanan@intel.com>
References: <20190416172439.27908-1-anirudh.venkataramanan@intel.com>
 <20190416172439.27908-12-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D399A0B@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:25 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S19 11/15] ice: Use bitfields when possible
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> We can use bitfields to store boolean values and when the bitfields are next
> to each other, the compiler will combine them (as long as the size holds
> enough).
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h             | 10 +++++-----
>  drivers/net/ethernet/intel/ice/ice_txrx.h        |  2 +-
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h | 10 +++++-----
>  3 files changed, 11 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


