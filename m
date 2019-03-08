From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 8 Mar 2019 00:34:03 +0000
Subject: [Intel-wired-lan] [PATCH S17 10/17] ice: Remove unnecessary
 wait when disabling/enabling Rx queues
In-Reply-To: <20190228232603.32156-11-anirudh.venkataramanan@intel.com>
References: <20190228232603.32156-1-anirudh.venkataramanan@intel.com>
 <20190228232603.32156-11-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D368ECA@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, February 28, 2019 3:26 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S17 10/17] ice: Remove unnecessary wait
> when disabling/enabling Rx queues
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> In ice_vsi_ctrl_rx_rings() we are unnecessarily waiting for
> QRX_CTRL_QENA_REQ and QRX_CTRL_QENA_STAT to be the same value
> prior to disabling each Rx queue. There is no reason to do this so remove this
> wait loop as we already have a wait loop after disabling/enabling the Rx
> queue through the QRX_CTRL register to make sure it gets successfully
> disabled/enabled.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


