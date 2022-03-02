From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 2 Mar 2022 19:44:16 +0000
Subject: [Intel-wired-lan] [net-next PATCH 22/25] ice: introduce
 ICE_VF_RESET_LOCK flag
In-Reply-To: <20220223002712.2771809-23-jacob.e.keller@intel.com>
References: <20220223002712.2771809-1-jacob.e.keller@intel.com>
 <20220223002712.2771809-23-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB562937813050C7C68D7E7C90AB039@SJ0PR11MB5629.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [net-next PATCH 22/25] ice: introduce
> ICE_VF_RESET_LOCK flag
> 
> The ice_reset_vf function performs actions which must be taken only while
> holding the VF configuration lock. Some flows already acquired the lock,
> while other flows must acquire it just for the reset function. Add the
> ICE_VF_RESET_LOCK flag to the function so that it can handle taking and
> releasing the lock instead at the appropriate scope.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c   |  4 +---
>  drivers/net/ethernet/intel/ice/ice_sriov.c  | 12 +++---------
> drivers/net/ethernet/intel/ice/ice_vf_lib.c | 18 ++++++++++++++----
> drivers/net/ethernet/intel/ice/ice_vf_lib.h |  1 +
>  4 files changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index 9d5fa9840004..4f35eb039d9f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
