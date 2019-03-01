From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 1 Mar 2019 23:53:41 +0000
Subject: [Intel-wired-lan] [PATCH S15 13/14] ice: Fix incorrect use of
 abbreviations
In-Reply-To: <20190219230414.25627-14-anirudh.venkataramanan@intel.com>
References: <20190219230414.25627-1-anirudh.venkataramanan@intel.com>
 <20190219230414.25627-14-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D367641@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, February 19, 2019 3:04 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S15 13/14] ice: Fix incorrect use of
> abbreviations
> 
> Capitalize abbreviations and spell out some that aren't obvious.
> 
> Reviewed-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h             |  10 +--
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h  |  20 ++---
>  drivers/net/ethernet/intel/ice/ice_common.c      |  94 ++++++++++----------
>  drivers/net/ethernet/intel/ice/ice_controlq.c    |  10 +--
>  drivers/net/ethernet/intel/ice/ice_ethtool.c     |  20 ++---
>  drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h   |  12 +--
>  drivers/net/ethernet/intel/ice/ice_lib.c         |  24 ++---
>  drivers/net/ethernet/intel/ice/ice_main.c        |  74 ++++++++--------
>  drivers/net/ethernet/intel/ice/ice_nvm.c         |   6 +-
>  drivers/net/ethernet/intel/ice/ice_sched.c       | 104 +++++++++++-----------
>  drivers/net/ethernet/intel/ice/ice_switch.c      | 108 +++++++++++------------
>  drivers/net/ethernet/intel/ice/ice_switch.h      |  10 +--
>  drivers/net/ethernet/intel/ice/ice_txrx.c        |  20 ++---
>  drivers/net/ethernet/intel/ice/ice_type.h        |  22 ++---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c |  58 ++++++------
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h |   8 +-
>  16 files changed, 300 insertions(+), 300 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


