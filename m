From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 17 May 2018 22:12:47 +0000
Subject: [Intel-wired-lan] [next PATCH S92 4/9] i40e: split
 i40e_get_strings() into smaller functions
In-Reply-To: <20180517080840.30192-4-alice.michael@intel.com>
References: <20180517080840.30192-1-alice.michael@intel.com>
 <20180517080840.30192-4-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1B771860@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, May 17, 2018 1:09 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S92 4/9] i40e: split i40e_get_strings()
> into smaller functions
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Split the statistic strings and private flags strings into their own separate
> functions to aid code readability.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 183 ++++++++++++++------
> -----
>  1 file changed, 100 insertions(+), 83 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


