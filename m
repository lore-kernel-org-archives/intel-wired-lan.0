From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 30 Jan 2020 22:45:34 +0000
Subject: [Intel-wired-lan] [PATCH S39 04/15] ice: Always clear the
 QRXFLXP_CNTXT register for VF Rx queues
In-Reply-To: <20200127085927.13999-4-anthony.l.nguyen@intel.com>
References: <20200127085927.13999-1-anthony.l.nguyen@intel.com>
 <20200127085927.13999-4-anthony.l.nguyen@intel.com>
Message-ID: <8f4a3062aea74e349d3c63a8145ef0da@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Monday, January 27, 2020 12:59 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S39 04/15] ice: Always clear the
> QRXFLXP_CNTXT register for VF Rx queues
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently when the PF reduces its number of channels via ethtool and then
> VFs are created there may be stale data for some of the Rx queues belonging
> to VFs. This happens when a VF reuses an Rx queue that was previously used
> by the PF. Specifically, the QRXFLXP_CNTXT register will have incorrect
> values. Fix this by always clearing the relevant values in the QRXFLXP_CNTXT
> register for VF queues.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c       | 8 ++++++--
>  drivers/net/ethernet/intel/ice/ice_hw_autogen.h | 1 +
>  2 files changed, 7 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


