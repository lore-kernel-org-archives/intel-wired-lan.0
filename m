From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 19 Feb 2020 19:41:44 +0000
Subject: [Intel-wired-lan] [PATCH S39 v2 09/15] ice: Don't reject odd
 values of usecs set by user
In-Reply-To: <20200213213129.34023-8-anthony.l.nguyen@intel.com>
References: <20200213213129.34023-1-anthony.l.nguyen@intel.com>
 <20200213213129.34023-8-anthony.l.nguyen@intel.com>
Message-ID: <5daeb62c2aad4f8faea5346ed293ff88@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 13, 2020 1:31 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S39 v2 09/15] ice: Don't reject odd values of
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


