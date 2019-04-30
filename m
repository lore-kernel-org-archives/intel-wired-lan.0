From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Apr 2019 22:48:07 +0000
Subject: [Intel-wired-lan] [PATCH S21 01/14] ice: Introduce
 ice_init_mac_fltr and move ice_napi_del
In-Reply-To: <20190416173503.29847-2-anirudh.venkataramanan@intel.com>
References: <20190416173503.29847-1-anirudh.venkataramanan@intel.com>
 <20190416173503.29847-2-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39AF4D@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:35 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S21 01/14] ice: Introduce ice_init_mac_fltr
> and move ice_napi_del
> 
> From: Tony Nguyen <anthony.l.nguyen@intel.com>
> 
> Consolidate adding unicast and broadcast MAC filters in a single new function
> ice_init_mac_fltr.
> 
> Move ice_napi_del to ice_lib.c
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> rewrote
> commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c  |  15 +++
>  drivers/net/ethernet/intel/ice/ice_lib.h  |   2 +
>  drivers/net/ethernet/intel/ice/ice_main.c | 106 +++++++++++++---------
>  3 files changed, 79 insertions(+), 44 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


