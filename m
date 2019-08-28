From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Aug 2019 17:03:16 +0000
Subject: [Intel-wired-lan] [PATCH S28 3/9] ice: Check for DCB capability
 before initializing DCB
In-Reply-To: <20190827131354.12703-3-anthony.l.nguyen@intel.com>
References: <20190827131354.12703-1-anthony.l.nguyen@intel.com>
 <20190827131354.12703-3-anthony.l.nguyen@intel.com>
Message-ID: <f62eaffb870e439e921c8aaafb8e0ff1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Tuesday, August 27, 2019 6:14 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S28 3/9] ice: Check for DCB capability
> before initializing DCB
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> Check the ICE_FLAG_DCB_CAPABLE before calling ice_init_pf_dcb.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c |  3 ---
>  drivers/net/ethernet/intel/ice/ice_main.c    | 15 ++++++++-------
>  2 files changed, 8 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


