From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 21 Aug 2018 21:17:13 +0000
Subject: [Intel-wired-lan] [PATCH v3 04/15] ice: Prevent control queue
 operations during reset
In-Reply-To: <20180809132958.23036-5-anirudh.venkataramanan@intel.com>
References: <20180809132958.23036-1-anirudh.venkataramanan@intel.com>
 <20180809132958.23036-5-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD26195459C2@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, August 9, 2018 6:30 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3 04/15] ice: Prevent control queue
> operations during reset
> 
> Once reset is issued, the driver loses all control queue interfaces.
> Exercising control queue operations during reset is incorrect and may result
> in long timeouts.
> 
> This patch introduces a new field 'reset_ongoing' in the hw structure.
> This is set to 1 by the core driver when it receives a reset interrupt.
> ice_sq_send_cmd checks reset_ongoing before actually issuing the control
> queue operation. If a reset is in progress, it returns a soft error code
> (ICE_ERR_RESET_PENDING) to the caller. The caller may or may not have to
> take any action based on this return. Once the driver knows that the reset is
> done, it has to set reset_ongoing back to 0. This will allow control queue
> operations to be posted to the hardware again.
> 
> This "bail out" logic was specifically added to ice_sq_send_cmd (which is
> pretty low level function) so that we have one solution in one place that
> applies to all types of control queues.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_controlq.c |  3 ++
>  drivers/net/ethernet/intel/ice/ice_main.c     | 34 ++++++++++++++++---
>  drivers/net/ethernet/intel/ice/ice_status.h   |  1 +
>  drivers/net/ethernet/intel/ice/ice_type.h     |  1 +
>  4 files changed, 34 insertions(+), 5 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


