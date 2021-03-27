From: Switzer, David <david.switzer@intel.com>
Date: Sat, 27 Mar 2021 01:53:00 +0000
Subject: [Intel-wired-lan] [PATCH net] i40e: Fix display statistics for
 veb_tc
In-Reply-To: <20210302074627.14349-1-eryk.roch.rybak@intel.com>
References: <20210302074627.14349-1-eryk.roch.rybak@intel.com>
Message-ID: <MW3PR11MB4748A70F68C24591CE153A68EB609@MW3PR11MB4748.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Rybak, Eryk Roch
>Sent: Monday, March 1, 2021 11:46 PM
To: intel-wired-lan@lists.osuosl.org
>Cc: Rybak, Eryk Roch <eryk.roch.rybak@intel.com>; Loktionov, Aleksandr
><aleksandr.loktionov@intel.com>
>Subject: [Intel-wired-lan] [PATCH net] i40e: Fix display statistics for veb_tc
>
>If veb-stats was enabled, the ethtool stats triggered a warning due to invalid
>size: 'unexpected stat size for veb.tc_%u_tx_packets'.
>This was due to an incorrect structure definition for the statistics.
>Structures and functions have been improved in line with requirements for
>the presentation of statistics, in particular for the functions:
>'i40e_add_ethtool_stats' and 'i40e_add_stat_strings'.
>
>Fixes: 1510ae0be2a4 ("i40e: convert VEB TC stats to use an i40e_stats array")
>Signed-off-by: Eryk Rybak <eryk.roch.rybak@intel.com>
>Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>---
> .../net/ethernet/intel/i40e/i40e_ethtool.c    | 52 ++++++++++++++++---
> 1 file changed, 46 insertions(+), 6 deletions(-)
>
Tested-by: Dave Switzer <david.switzer@intel.com>
