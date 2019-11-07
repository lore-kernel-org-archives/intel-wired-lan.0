From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 7 Nov 2019 18:41:19 +0000
Subject: [Intel-wired-lan] [PATCH S32 v3 14/15] ice: use more accurate
 ICE_DBG mask types
In-Reply-To: <20191106100541.48639-14-anthony.l.nguyen@intel.com>
References: <20191106100541.48639-1-anthony.l.nguyen@intel.com>
 <20191106100541.48639-14-anthony.l.nguyen@intel.com>
Message-ID: <7ec30bdd50954f10a5c41d8dcbeb3791@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, November 6, 2019 2:06 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S32 v3 14/15] ice: use more accurate
> ICE_DBG mask types
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> ice_debug_cq is passed a mask which is always ICE_DBG_AQ_CMD. Modify
> this function, removing the mask parameter entirely, and directly use the
> more appropriate ICE_DBG_AQ_DESC and ICE_DBG_AQ_DESC_BUF.
> 
> The function is only called from ice_controlq.c, and has no other callers
> outside of that file. Move it and mark it static to avoid namespace pollution.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c   | 50 ----------------
>  drivers/net/ethernet/intel/ice/ice_common.h   |  2 -
>  drivers/net/ethernet/intel/ice/ice_controlq.c | 57 +++++++++++++++++--
>  drivers/net/ethernet/intel/ice/ice_type.h     |  2 +
>  4 files changed, 53 insertions(+), 58 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


