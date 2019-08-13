From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 13 Aug 2019 17:26:19 +0000
Subject: [Intel-wired-lan] [PATCH S27 14/15] ice: small efficiency fixes
In-Reply-To: <20190808143938.4968-14-anthony.l.nguyen@intel.com>
References: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
 <20190808143938.4968-14-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D4116BB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, August 8, 2019 7:40 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S27 14/15] ice: small efficiency fixes
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Add a small bit of efficiency to the code by adding a prefetch of the port_info
> structure in order to help avoid a cache miss a little later on in execution.
> 
> Also add an unlikely statement to a branch which generally will never happen
> in normal operation.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


