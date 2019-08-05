From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 5 Aug 2019 21:34:57 +0000
Subject: [Intel-wired-lan] [PATCH S26 05/15] ice: Rework
 ice_ena_msix_range
In-Reply-To: <20190802082533.23083-5-anthony.l.nguyen@intel.com>
References: <20190802082533.23083-1-anthony.l.nguyen@intel.com>
 <20190802082533.23083-5-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40F0A7@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, August 2, 2019 1:25 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S26 05/15] ice: Rework
> ice_ena_msix_range
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> The current implementation of ice_ena_msix_range is difficult to read and
> has subtle issues. This patch reworks the said function for clarity and
> correctness.
> 
> More specifically,
> 
> 1. Add more checks to bail out of 'needed' is greater than 'v_left'.
> 
> 2. Simplify fallback logic
> 
> 3. Do not set pf->num_avail_sw_msix in ice_ena_msix_range as it
>    gets overwritten by ice_init_interrupt_scheme.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 32 +++++++++++++++--------
>  1 file changed, 21 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


