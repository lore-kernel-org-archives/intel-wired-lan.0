From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 20 Jul 2017 19:26:56 +0000
Subject: [Intel-wired-lan] [next PATCH S76-V2 12/13] i40e: simplify
 member	variable accesses
In-Reply-To: <20170714131019.52530-12-alice.michael@intel.com>
References: <20170714131019.52530-1-alice.michael@intel.com>
 <20170714131019.52530-12-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB262C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, July 14, 2017 6:10 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S76-V2 12/13] i40e: simplify member
> variable accesses
> 
> From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> 
> This commit replaces usage of vsi->back in i40e_print_link_message() (which
> is actually a PF pointer) with temp variable.
> 
> Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


