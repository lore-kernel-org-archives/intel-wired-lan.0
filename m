From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Jul 2019 18:16:42 +0000
Subject: [Intel-wired-lan] [PATCH S24 04/12] ice: Treat DCBx state
 NOT_STARTED as valid
In-Reply-To: <20190723092759.3614-4-anthony.l.nguyen@intel.com>
References: <20190723092759.3614-1-anthony.l.nguyen@intel.com>
 <20190723092759.3614-4-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40CDA4@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Tuesday, July 23, 2019 2:28 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S24 04/12] ice: Treat DCBx state
> NOT_STARTED as valid
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> When a port is not cabled, but DCBx is enabled in the firmware, the status of
> DCBx will be NOT_STARTED.  This is a valid state for FW enabled and should
> not be treated as a is_fw_lldp true automatically.
> 
> Add the code to treat NOT_STARTED as another valid state.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


