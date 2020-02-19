From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 19 Feb 2020 19:39:38 +0000
Subject: [Intel-wired-lan] [PATCH S39 v2 05/15] ice: Add DCBNL ops
 required to configure ETS in CEE for SW DCB
In-Reply-To: <20200213213129.34023-4-anthony.l.nguyen@intel.com>
References: <20200213213129.34023-1-anthony.l.nguyen@intel.com>
 <20200213213129.34023-4-anthony.l.nguyen@intel.com>
Message-ID: <978bb7d24707448aa694023a6977dd28@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 13, 2020 1:31 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S39 v2 05/15] ice: Add DCBNL ops required
> to configure ETS in CEE for SW DCB
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


