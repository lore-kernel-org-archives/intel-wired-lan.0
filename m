From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 2 Aug 2018 18:30:37 +0000
Subject: [Intel-wired-lan] [next PATCH S93 04/11] i40e: convert VEB TC
 stats to use an i40e_stats array
In-Reply-To: <20180731104148.11896-4-alice.michael@intel.com>
References: <20180731104148.11896-1-alice.michael@intel.com>
 <20180731104148.11896-4-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2DB33E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, July 31, 2018 3:42 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S93 04/11] i40e: convert VEB TC stats
> to use an i40e_stats array
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The VEB TC stats are currently implemented with separate parsing, instead of
> using the i40e_stats array and associated helper functions.
> This is likely because the stats rely on embedding the TC number into the stat
> name.
> 
> Update i40e_add_stat_strings to take variadic arguments, and use these to
> vsnprintf the i40e_stats string as a string containing format specifiers.
> 
> Create a stats array for the VEB TC related stats, i40e_gstrings_veb_tc_stats,
> and use this along with the helper functions to remove the specialized boiler
> plate code.
> 
> Always call i40e_add_ethtool_stats for both this array and the general VEB
> stats array. This ensures that we zero out any memory in case it was not
> zero-allocated for us.
> 
> This ultimately results in less boiler plate code for the i40e_get_stat_strings
> and i40e_get_ethtool_stats.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 83 +++++++++++++---------
> ----
>  1 file changed, 43 insertions(+), 40 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
