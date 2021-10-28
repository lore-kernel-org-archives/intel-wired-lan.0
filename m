From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Thu, 28 Oct 2021 06:41:15 +0000
Subject: [Intel-wired-lan] [PATCH net v3] iavf: Fix refreshing iavf
 adapter stats on ethtool request
In-Reply-To: <20210915090100.25340-1-jedrzej.jagielski@intel.com>
References: <20210915090100.25340-1-jedrzej.jagielski@intel.com>
Message-ID: <DM8PR11MB562197638B086A9F61623145AB869@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jedrzej Jagielski
> Sent: ?roda, 15 wrze?nia 2021 11:01
> To: intel-wired-lan at lists.osuosl.org
> Cc: Jagielski, Jedrzej <jedrzej.jagielski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v3] iavf: Fix refreshing iavf adapter
> stats on ethtool request
> 
> Currently iavf adapter statistics are refreshed only in a watchdog task,
> triggered approximately every two seconds, which causes some ethtool
> requests to return outdated values.
> 
> Add explicit statistics refresh when requested by ethtool -S.
> 
> Fixes: b476b0030e61 ("iavf: Move commands processing to the separate
> function")
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> V2: Squash 44a4808a78f6 ("iavf: Fix ethtool stats request scheduling")
> V3: Change value returning by iavf_process_aq_command()
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h         |  2 ++
>  drivers/net/ethernet/intel/iavf/iavf_ethtool.c |  3 +++
>  drivers/net/ethernet/intel/iavf/iavf_main.c    | 18 ++++++++++++++++++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> b/drivers/net/ethernet/intel/iavf/iavf.h
> index 21c95775509a..afe6b0d24a9a 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
