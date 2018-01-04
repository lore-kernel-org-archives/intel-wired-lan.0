From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 4 Jan 2018 22:42:40 +0000
Subject: [Intel-wired-lan] [next PATCH S84-V2 04/13] i40e/i40evf: Use
 ring pointers to clean up _set_itr_per_queue
In-Reply-To: <20171227131551.23675-1-alice.michael@intel.com>
References: <20171227131551.23675-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D70C0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, December 27, 2017 5:16 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S84-V2 04/13] i40e/i40evf: Use ring
> pointers to clean up _set_itr_per_queue
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This change cleans up the i40e/i40evf_set_itr_per_queue function by
> dropping all the unneeded pointer chases. Instead we can just pull out the
> pointers for the Tx and Rx rings and use them throughout the function.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 22 +++++++++--------
>  drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 28 +++++++++++-------
> ----
>  2 files changed, 26 insertions(+), 24 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


