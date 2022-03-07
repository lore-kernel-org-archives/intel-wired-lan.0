From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Mon, 7 Mar 2022 16:19:47 +0000
Subject: [Intel-wired-lan] [PATCH net v2 2/3] ixgbe: add improvement for
 MDD response functionality
In-Reply-To: <20220301114010.2676-2-slawomirx.mrozowicz@intel.com>
References: <20220301114010.2676-1-slawomirx.mrozowicz@intel.com>
 <20220301114010.2676-2-slawomirx.mrozowicz@intel.com>
Message-ID: <DM8PR11MB5621956F4325303BF72F87A9AB089@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Slawomir Mrozowicz
> Sent: Tuesday, March 1, 2022 12:40 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Mrozowicz, SlawomirX <slawomirx.mrozowicz@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v2 2/3] ixgbe: add improvement for
> MDD response functionality
> 
> The 82599 PF driver disable VF driver after a special MDD event occurs.
> Adds the option for administrators to control whether VFs are automatically
> disabled after several MDD events.
> The automatically disabling is now the default mode for 82599 PF driver, as it
> is more reliable.
> 
> This addresses CVE-2021-33061.
> 
> Signed-off-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  4 +++
>  .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 21 ++++++++++++++
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 28 ++++++++++++++++++-
>  3 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> index c9bf18086d9c..921a4d977d65 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> @@ -184,6 +184,7 @@ struct vf_data_storage {

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
