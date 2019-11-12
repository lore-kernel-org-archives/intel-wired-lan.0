From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Nov 2019 19:33:32 +0000
Subject: [Intel-wired-lan] [PATCH S33 07/15] ice: Fix setting coalesce
 to handle DCB configuration
In-Reply-To: <20191108142331.10221-7-anthony.l.nguyen@intel.com>
References: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
 <20191108142331.10221-7-anthony.l.nguyen@intel.com>
Message-ID: <d1802d3e4f204f4a83dd8e93e48441b7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, November 8, 2019 6:23 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S33 07/15] ice: Fix setting coalesce to
> handle DCB configuration
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently there can be a case where a DCB map is applied and there are more
> interrupt vectors (vsi->num_q_vectors) than Rx queues (vsi->num_rxq) and
> Tx queues (vsi->num_txq). If we try to set coalesce settings in this case it will
> report a false failure. Fix this by checking if vector index is valid with respect
> to the number of Tx and Rx queues configured.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


