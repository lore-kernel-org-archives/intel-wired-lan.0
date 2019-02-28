From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 Feb 2019 23:53:12 +0000
Subject: [Intel-wired-lan] [PATCH S13 v2 05/17] ice: fix some function
 prototype and signature style issues
In-Reply-To: <20190227003523.28733-6-anirudh.venkataramanan@intel.com>
References: <20190227003523.28733-1-anirudh.venkataramanan@intel.com>
 <20190227003523.28733-6-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3672CE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, February 26, 2019 4:35 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S13 v2 05/17] ice: fix some function
> prototype and signature style issues
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> Put the return type on a separate line for function prototypes and signatures
> that would exceed the 80-character limit if both were on the same line.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice.h             |  5 ++-
>  drivers/net/ethernet/intel/ice/ice_common.c      | 35 +++++++++--------
>  drivers/net/ethernet/intel/ice/ice_common.h      | 18 +++++----
>  drivers/net/ethernet/intel/ice/ice_ethtool.c     | 25 +++++++-----
>  drivers/net/ethernet/intel/ice/ice_lib.c         |  5 ++-
>  drivers/net/ethernet/intel/ice/ice_main.c        | 34 +++++++++--------
>  drivers/net/ethernet/intel/ice/ice_switch.c      |  4 +-
>  drivers/net/ethernet/intel/ice/ice_switch.h      |  3 +-
>  drivers/net/ethernet/intel/ice/ice_txrx.c        | 48 ++++++++++++------------
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c |  9 +++--
> drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h |  9 +++--
>  11 files changed, 108 insertions(+), 87 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


