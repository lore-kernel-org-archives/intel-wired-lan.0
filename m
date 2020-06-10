From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 10 Jun 2020 22:27:43 +0000
Subject: [Intel-wired-lan] [PATCH 3/4] iavf: Fix reporting 2.5 Gb and
 5Gb speeds
In-Reply-To: <20200605170946.23494-3-anthony.l.nguyen@intel.com>
References: <20200605170946.23494-1-anthony.l.nguyen@intel.com>
 <20200605170946.23494-3-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB214512E8FBA3535DE7FA17B28C830@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, June 5, 2020 10:10 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 3/4] iavf: Fix reporting 2.5 Gb and 5Gb
> speeds
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Commit 4ae4916b5643 ("i40e: fix 'Unknown bps' in dmesg for 2.5Gb/5Gb
> speeds") added the ability for the PF to report 2.5 and 5Gb speeds, however,
> the iavf driver does not recognize those speeds as the values were not
> added there. Add the proper enums and values so that iavf can properly deal
> with those speeds.
> 
> Fixes: 4ae4916b5643 ("i40e: fix 'Unknown bps' in dmesg for 2.5Gb/5Gb
> speeds")
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Witold Fijalkowski <witoldx.fijalkowski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_ethtool.c |  6 ++++++
>  drivers/net/ethernet/intel/iavf/iavf_main.c    | 18 ++++++++++++------
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c    |  6 ++++++
>  3 files changed, 24 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


