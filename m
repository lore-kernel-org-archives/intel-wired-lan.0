From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 3 Mar 2020 19:07:30 +0000
Subject: [Intel-wired-lan] [PATCH S40 09/15] ice: Correct setting VLAN
 pruning
In-Reply-To: <20200227181505.61720-9-anthony.l.nguyen@intel.com>
References: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
 <20200227181505.61720-9-anthony.l.nguyen@intel.com>
Message-ID: <cf1804a05a24465888a69fc0adc38434@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 27, 2020 10:15 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S40 09/15] ice: Correct setting VLAN
> pruning
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> VLAN pruning is not always being set correctly due to a previous change that
> set Tx antispoof off. ice_vsi_is_vlan_pruning_ena() currently checks for both
> Tx antispoof and Rx pruning. The expectation for this function is to only check
> Rx pruning so fix the check.
> 
> Fixes: cd6d6b83316a ("ice: Fix VF spoofchk")
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


