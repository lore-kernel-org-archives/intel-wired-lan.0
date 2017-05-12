From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 12 May 2017 17:55:31 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 01/14] i40evf:
	drop	i40e_type.h include
In-Reply-To: <20170511182321.147850-2-jesse.brandeburg@intel.com>
References: <20170511182321.147850-1-jesse.brandeburg@intel.com>
 <20170511182321.147850-2-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA30D9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Thursday, May 11, 2017 11:23 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v3 01/14] i40evf: drop
> i40e_type.h include
> 
> This drops the i40e_type.h include in anticipation of the next patch which
> moves this file to a location where type.h doesn't exist, and all the places this
> file is included already include i40e_type.h before this file.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h | 2 --
>  1 file changed, 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


