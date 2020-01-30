From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 30 Jan 2020 22:48:09 +0000
Subject: [Intel-wired-lan] [PATCH S39 09/15] ice: Don't reject odd
 values of usecs set by user
In-Reply-To: <20200127085927.13999-9-anthony.l.nguyen@intel.com>
References: <20200127085927.13999-1-anthony.l.nguyen@intel.com>
 <20200127085927.13999-9-anthony.l.nguyen@intel.com>
Message-ID: <b6741c8eba044ea99003fa6c04018c4d@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S39 09/15] ice: Don't reject odd values of
> usecs set by user
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently if a user sets an odd [tx|rx]-usecs value through ethtool, the
> request is denied because the hardware is set to have an ITR granularity of
> 2us. This caused poor customer experience. Fix this by aligning to a register
> allowed value, which results in rounding down.
> Also, print a once per ring container type message to be clear about our
> intentions.
> 
> Also, change the ITR_TO_REG define to be the bitwise and of the ITR setting
> and the ICE_ITR_MASK. This makes the purpose of ITR_TO_REG more
> obvious.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 49 +++++++++++++++-----
>  drivers/net/ethernet/intel/ice/ice_txrx.h    |  2 +-
>  2 files changed, 39 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


