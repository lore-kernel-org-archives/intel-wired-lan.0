From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Sat, 11 Dec 2021 11:25:42 +0000
Subject: [Intel-wired-lan] [Patch 2/2] iavf: Prevent reset from being
 scheduled while adapter is being removed
In-Reply-To: <20211208102153.669338-3-jkc@redhat.com>
References: <20211208102153.669338-1-jkc@redhat.com>
 <20211208102153.669338-3-jkc@redhat.com>
Message-ID: <DM8PR11MB562113838E512BF4DEFC2F06AB729@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Ken Cox
> Sent: ?roda, 8 grudnia 2021 11:22
> To: intel-wired-lan at osuosl.org
> Cc: Ken Cox <jkc@redhat.com>
> Subject: [Intel-wired-lan] [Patch 2/2] iavf: Prevent reset from being
> scheduled while adapter is being removed
> 
> If a reset gets scheduled while the adapter is being removed it can cause a
> panic.
> 
> The work_struct for the reset_task is contained in the iavf_adapter
> structure.  iavf_remove() eventually frees the iavf_adapter structure so if
> there is active work scheduled it can cause a panic.
> 
> Signed-off-by: Ken Cox <jkc@redhat.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_ethtool.c  |  7 +++++--
>  drivers/net/ethernet/intel/iavf/iavf_main.c     | 15 ++++++++++-----
>  drivers/net/ethernet/intel/iavf/iavf_virtchnl.c |  4 +++-
>  3 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> index af43fbd8cb75e..3cf1679153604 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> @@ -519,7 +519,9 @@ static int iavf_set_priv_flags(struct net_device

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
