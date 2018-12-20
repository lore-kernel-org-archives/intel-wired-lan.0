From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 20 Dec 2018 21:39:46 +0000
Subject: [Intel-wired-lan] [PATCH S10 10/15] ice: Add support for
 adaptive interrupt moderation
In-Reply-To: <20181219180334.1104-11-anirudh.venkataramanan@intel.com>
References: <20181219180334.1104-1-anirudh.venkataramanan@intel.com>
 <20181219180334.1104-11-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D343A68@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, December 19, 2018 10:03 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S10 10/15] ice: Add support for adaptive
> interrupt moderation
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently the driver does not support adaptive/dynamic interrupt
> moderation. This patch adds support for this. Also, adaptive/dynamic
> interrupt moderation is turned on by default upon driver load.
> 
> In order to support adaptive interrupt moderation, two functions were
> added, ice_update_itr() and ice_itr_divisor(). These are used to determine
> the current packet load and to determine a divisor based on link speed
> respectively.
> 
> This patch also adds the ICE_ITR_GRAN_S define that is used in the hot-path
> when setting a new ITR value. The shift is used to pet two birds with one
> hand, set the ITR value while re-enabling the interrupt. Also, the
> ICE_ITR_GRAN_S is defined as 1 because the device has a ITR granularity of
> 2usecs.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h |  1 +
>  drivers/net/ethernet/intel/ice/ice_lib.c        | 24 ++++++---
>  drivers/net/ethernet/intel/ice/ice_main.c       | 23 +++++++--
>  drivers/net/ethernet/intel/ice/ice_txrx.c       | 65
> ++++++++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_txrx.h       | 30 +++++++-----
>  5 files changed, 120 insertions(+), 23 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


