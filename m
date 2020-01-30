From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 30 Jan 2020 22:46:01 +0000
Subject: [Intel-wired-lan] [PATCH S39 05/15] ice: Add DCBNL ops required
 to configure ETS in CEE for SW DCB
In-Reply-To: <20200127085927.13999-5-anthony.l.nguyen@intel.com>
References: <20200127085927.13999-1-anthony.l.nguyen@intel.com>
 <20200127085927.13999-5-anthony.l.nguyen@intel.com>
Message-ID: <6fec9af186d347a6b1c320da12aa4979@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Monday, January 27, 2020 12:59 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S39 05/15] ice: Add DCBNL ops required to
> configure ETS in CEE for SW DCB
> 
> From: Avinash JD <avinash.dayanand@intel.com>
> 
> Couple of DCBNL ops are required for configuring ETS in SW DCB CEE mode. If
> these functions are not added, it'll break the CEE functionality.
> 
> Signed-off-by: Avinash JD <avinash.dayanand@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_nl.c | 43 +++++++++++++++++++++
>  1 file changed, 43 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


