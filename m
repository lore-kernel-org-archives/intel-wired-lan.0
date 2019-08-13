From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 13 Aug 2019 17:07:22 +0000
Subject: [Intel-wired-lan] [PATCH S27 02/15] ice: Correctly handle
 return values for init DCB
In-Reply-To: <20190808143938.4968-2-anthony.l.nguyen@intel.com>
References: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
 <20190808143938.4968-2-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D4115F6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, August 8, 2019 7:39 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S27 02/15] ice: Correctly handle return
> values for init DCB
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> In the init path for DCB, the call to ice_init_dcb() can return a non-zero value
> for either an actual error, or due to the FW lldp engine being stopped.
> 
> We are currently treating all non-zero values only as an indication that the FW
> LLDP engine is stopped.
> 
> Check for an actual error in the DCB init flow.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


