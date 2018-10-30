From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Oct 2018 21:55:47 +0000
Subject: [Intel-wired-lan] [PATCH S8 04/16] ice: Free VSI contexts
 during for unload
In-Reply-To: <20181026174105.11628-5-anirudh.venkataramanan@intel.com>
References: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
 <20181026174105.11628-5-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D328CB9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, October 26, 2018 10:41 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S8 04/16] ice: Free VSI contexts during for
> unload
> 
> From: Victor Raj <victor.raj@intel.com>
> 
> In the unload path, all VSIs are freed. Also free the related VSI contexts to
> prevent memory leaks.
> 
> Signed-off-by: Victor Raj <victor.raj@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> rewrote
> commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c |  3 +++
> drivers/net/ethernet/intel/ice/ice_switch.c | 12 ++++++++++++
> drivers/net/ethernet/intel/ice/ice_switch.h |  2 ++
>  3 files changed, 17 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


