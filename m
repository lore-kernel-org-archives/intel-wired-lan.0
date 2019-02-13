From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Feb 2019 20:24:01 +0000
Subject: [Intel-wired-lan] [next PATCH S2-V2 11/12] i40e: Able to add up
 to 16 MAC filters on an untrusted VF
In-Reply-To: <20190206230826.24970-11-alice.michael@intel.com>
References: <20190206230826.24970-1-alice.michael@intel.com>
 <20190206230826.24970-11-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D36600F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, February 6, 2019 3:08 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Ludkiewicz, Adam <adam.ludkiewicz@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S2-V2 11/12] i40e: Able to add up to
> 16 MAC filters on an untrusted VF
> 
> From: Adam Ludkiewicz <adam.ludkiewicz@intel.com>
> 
> This patch fixes the problem with the driver being able to add only 7 multicast
> MAC address filters instead of 16. The problem is fixed by changing the
> maximum number of MAC address filters to 16+1+1 (two extra are needed
> because the driver uses 1 for unicast MAC address and 1 for broadcast).
> 
> Signed-off-by: Adam Ludkiewicz <adam.ludkiewicz@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


