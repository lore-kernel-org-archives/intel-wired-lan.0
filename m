From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 2 Mar 2022 19:43:31 +0000
Subject: [Intel-wired-lan] [net-next PATCH 23/25] ice: cleanup long
 longs in ice_sriov.c
In-Reply-To: <20220223002712.2771809-24-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
 <20220223002712.2771809-24-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB562987E2AFD5722EED8397E6AB039@SJ0PR11MB5629.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jacob Keller
> Sent: Wednesday, February 23, 2022 1:27 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [net-next PATCH 23/25] ice: cleanup long longs in
> ice_sriov.c
> 
> Before we move the virtchnl message handling from ice_sriov.c into
> ice_virtchnl.c, cleanup some long line warnings to avoid checkpatch.pl
> complaints.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 39 +++++++++++++++-------
>  1 file changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index f74474f8af99..4f3d25ed68c9 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -2325,16 +2325,21 @@ static int

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
