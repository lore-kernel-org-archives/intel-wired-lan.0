From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 1 Nov 2019 16:42:38 +0000
Subject: [Intel-wired-lan] [PATCH S32 05/15] ice: Fix to change Rx/Tx
 ring descriptor size via ethtool with DCBx
In-Reply-To: <20191025143441.50151-5-anthony.l.nguyen@intel.com>
References: <20191025143441.50151-1-anthony.l.nguyen@intel.com>
 <20191025143441.50151-5-anthony.l.nguyen@intel.com>
Message-ID: <d8628ba727204ffb9ac8f2a085b9556b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, October 25, 2019 7:35 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S32 05/15] ice: Fix to change Rx/Tx ring
> descriptor size via ethtool with DCBx
> 
> From: Usha Ketineni <usha.k.ketineni@intel.com>
> 
> This patch fixes the call trace caused by the kernel when the Rx/Tx descriptor
> size change request is initiated via ethtool when DCB is configured.
> ice_set_ringparam() should use vsi->num_txq instead of
> vsi->alloc_txq as it represents the queues that are enabled in the
> driver when DCB is enabled/disabled. Otherwise, queue index being used
> can go out of range.
> 
> For example, when vsi->alloc_txq has 104 queues and with 3 TCS enabled via
> DCB, each TC gets 34 queues, vsi->num_txq will be 102 and only 102 queues
> will be enabled.
> 
> Signed-off-by: Usha Ketineni <usha.k.ketineni@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


