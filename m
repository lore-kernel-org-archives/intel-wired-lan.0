From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Nov 2019 19:35:58 +0000
Subject: [Intel-wired-lan] [PATCH S33 12/15] ice: implement VF stats NDO
In-Reply-To: <20191108142331.10221-12-anthony.l.nguyen@intel.com>
References: <20191108142331.10221-1-anthony.l.nguyen@intel.com>
 <20191108142331.10221-12-anthony.l.nguyen@intel.com>
Message-ID: <ca477e33a101448190bd2b5469272f8f@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S33 12/15] ice: implement VF stats NDO
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Implement the VF stats gathering via the kernel via ndo_get_vf_stats().
> The driver will show per-VF stats in the output of the ip -s link show dev <PF>
> command.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c     |  1 +
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 45 +++++++++++++++++++
> .../net/ethernet/intel/ice/ice_virtchnl_pf.h  | 11 +++++
>  3 files changed, 57 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


