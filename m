From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Oct 2018 22:26:30 +0000
Subject: [Intel-wired-lan] [PATCH S9 15/15] ice: Use Tx|Rx in comments
In-Reply-To: <20181026184447.13547-16-anirudh.venkataramanan@intel.com>
References: <20181026184447.13547-1-anirudh.venkataramanan@intel.com>
 <20181026184447.13547-16-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D328E79@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, October 26, 2018 11:45 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S9 15/15] ice: Use Tx|Rx in comments
> 
> In code comments, use Tx|Rx instead of tx|rx
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          | 20 ++++++++++----------
>  drivers/net/ethernet/intel/ice/ice_common.c   |  6 +++---
>  drivers/net/ethernet/intel/ice/ice_controlq.c |  1 -
> drivers/net/ethernet/intel/ice/ice_ethtool.c  | 12 ++++++------
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  8 ++++----
>  drivers/net/ethernet/intel/ice/ice_main.c     |  2 +-
>  drivers/net/ethernet/intel/ice/ice_sched.c    |  6 +++---
>  drivers/net/ethernet/intel/ice/ice_switch.c   |  8 ++++----
>  drivers/net/ethernet/intel/ice/ice_txrx.c     | 21 +++++++++++----------
>  9 files changed, 42 insertions(+), 42 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


