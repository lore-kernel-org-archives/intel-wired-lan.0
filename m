From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 Feb 2019 23:48:25 +0000
Subject: [Intel-wired-lan] [PATCH S14 14/15] ice: Put
 __ICE_PREPARED_FOR_RESET check in ice_prepare_for_reset
In-Reply-To: <20190213185115.25877-15-anirudh.venkataramanan@intel.com>
References: <20190213185115.25877-1-anirudh.venkataramanan@intel.com>
 <20190213185115.25877-15-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D36725E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, February 13, 2019 10:51 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S14 14/15] ice: Put
> __ICE_PREPARED_FOR_RESET check in ice_prepare_for_reset
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently we check if the __ICE_PREPARED_FOR_RESET bit is set prior to
> calling ice_prepare_for_reset in ice_reset_subtask(), but we aren't checking
> that bit in ice_do_reset() before calling ice_prepare_for_reset(). This is not
> consistent and can cause issues if
> ice_prepare_for_reset() is called prior to ice_do_reset(). Fix this by checking
> if the __ICE_PREPARED_FOR_RESET bit is set internal to
> ice_prepare_for_reset().
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
