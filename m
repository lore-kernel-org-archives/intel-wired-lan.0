From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 27 Oct 2021 09:43:53 +0000
Subject: [Intel-wired-lan] [PATCH net v4] iavf: Fix displaying queue
 statistics shown by ethtool
In-Reply-To: <20210917085252.96965-1-jedrzej.jagielski@intel.com>
References: <20210917085252.96965-1-jedrzej.jagielski@intel.com>
Message-ID: <DM8PR11MB562193FB11AF13AF3E085E72AB859@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jedrzej Jagielski
> Sent: pi?tek, 17 wrze?nia 2021 10:53
> To: intel-wired-lan at lists.osuosl.org
> Cc: Palczewski, Mateusz <mateusz.palczewski@intel.com>; Patynowski,
> PrzemyslawX <przemyslawx.patynowski@intel.com>; Witold Fijalkowski
> <witoldx.fijalkowski@intel.com>; Jagielski, Jedrzej
> <jedrzej.jagielski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v4] iavf: Fix displaying queue statistics
> shown by ethtool
> 
> Driver provided too many lines as an output to ethtool -S command.
> Return actual length of string set of ethtool stats. Instead of predefined
> maximal value use the actual value on netdev, iterate over active queues.
> Without this patch, ethtool -S report would produce additional erroneous
> lines.
> 
> Without this change in statistics after showing them by ethtool -S will be
> displayed queues that are not configured.
> 
> Fixes: 6dba41cd02fc ("i40evf: update ethtool stats code and use helper
> functions")
> Signed-off-by: Witold Fijalkowski <witoldx.fijalkowski@intel.com>
> Signed-off-by: Przemyslaw Patynowski
> <przemyslawx.patynowski@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> V2: Fix commit message
> V3: Squash patch 5d12f51b9820 ("iavf: Fix ethtool -S output")
> V4: Remove one blank line
> 
>  .../net/ethernet/intel/iavf/iavf_ethtool.c    | 30 ++++++++++++-------
>  1 file changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> index 7cbe59beeebb..014db92d33be 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> @@ -331,9 +331,16 @@ static int iavf_get_link_ksettings(struct net_device
> *netdev,
>   **/

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
