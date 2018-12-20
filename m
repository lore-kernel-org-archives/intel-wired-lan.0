From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 20 Dec 2018 21:42:21 +0000
Subject: [Intel-wired-lan] [PATCH S10 15/15] ice: add const qualifier to
 mac_addr parameter
In-Reply-To: <20181219180334.1104-16-anirudh.venkataramanan@intel.com>
References: <20181219180334.1104-1-anirudh.venkataramanan@intel.com>
 <20181219180334.1104-16-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D343ABD@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, December 19, 2018 10:04 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S10 15/15] ice: add const qualifier to
> mac_addr parameter
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The function ice_aq_manage_mac_write takes a pointer to a MAC address.
> The parameter is not marked const, even though the function doesn't need
> to modify it. This prevents passing a parameter that is already marked const.
> Update the function prototype to take a const pointer, to allow passing
> constant pointers to this function.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 6 +++---
> drivers/net/ethernet/intel/ice/ice_common.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


