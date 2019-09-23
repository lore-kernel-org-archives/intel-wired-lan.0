From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 23 Sep 2019 18:10:00 +0000
Subject: [Intel-wired-lan] [next PATCH S10 02/10] i40e: Add ability to
 display VF stats along with PF core stats
In-Reply-To: <20190920091724.51767-2-alice.michael@intel.com>
References: <20190920091724.51767-1-alice.michael@intel.com>
 <20190920091724.51767-2-alice.michael@intel.com>
Message-ID: <37e1de11081e4228a94b3bdb83dfc610@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, September 20, 2019 2:17 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Grubba, Arkadiusz <arkadiusz.grubba@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S10 02/10] i40e: Add ability to display
> VF stats along with PF core stats
> 
> From: Arkadiusz Grubba <arkadiusz.grubba@intel.com>
> 
> This change introduces the ability to display extended (enhanced) statistics
> for PF interfaces (in accordance to the new build flags also introduced here).
> 
> The patch introduces new arrays and preprocessor symbols defined for
> these extra stats (in i40e_ethtool.c file) and enhances/extends ethtool ops
> functions intended for dealing with PF stats (i.e.: i40e_get_stats_count(),
> i40e_get_ethtool_stats(), i40e_get_stat_strings() ).
> 
> There have also been introduced the new build flag named
> "I40E_PF_EXTRA_STATS_OFF" to exclude from the driver code all code
> snippets associated with these extra stats.
> 
> Signed-off-by: Arkadiusz Grubba <arkadiusz.grubba@intel.com>
> ---
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    | 149 ++++++++++++++++++
>  1 file changed, 149 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


