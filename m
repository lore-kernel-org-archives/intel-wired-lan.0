From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 2 Aug 2018 18:31:24 +0000
Subject: [Intel-wired-lan] [next PATCH S93 05/11] i40e: convert priority
 flow control stats to use helpers
In-Reply-To: <20180731104148.11896-5-alice.michael@intel.com>
References: <20180731104148.11896-1-alice.michael@intel.com>
 <20180731104148.11896-5-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2DB34F@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S93 05/11] i40e: convert priority flow
> control stats to use helpers
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The priority flow control statistics are laid out in the stats structure using
> arrays. This made it unwieldy to use as part of an i40e_stats array.
> 
> Add a new structure type, i40e_pfc_stats, and a helper function
> i40e_get_pfc_stats which can return the stats for a given priority value as an
> i40e_pfc_stats structure.
> 
> Use this to create an i40e_stats array, which we'll use to format and copy the
> strings and stats into the supplied buffers.
> 
> This reduces even more boiler plate code in i40e_get_ethtool_stats and
> i40e_get_stat_strings.
> 
> An alternative would be to modify the structure definition for the pfc stats,
> but this is more invasive to the rest of the code base.
> 
> Note that a macro was used to setup the copy of stats from the
> pf->stats, as this reduces the chance of typos in the code names. It
> will produce a checkpatch.pl warning due to re-use of a macro argument.
> In this case, it should be safe, as the macro will fail to compile in cases where
> the argument is not a simple structure member name, and thus arguments
> with side effects should not be an issue.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 87 +++++++++++++++-----
> ------
>  1 file changed, 51 insertions(+), 36 deletions(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


