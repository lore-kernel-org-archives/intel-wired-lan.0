From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Mon, 7 Mar 2022 16:19:23 +0000
Subject: [Intel-wired-lan] [PATCH net v2 3/3] ixgbevf: add disable link
 state
In-Reply-To: <20220301114010.2676-3-slawomirx.mrozowicz@intel.com>
References: <20220301114010.2676-1-slawomirx.mrozowicz@intel.com>
 <20220301114010.2676-3-slawomirx.mrozowicz@intel.com>
Message-ID: <DM8PR11MB56213CAA0567C77DFC88D3A3AB089@DM8PR11MB5621.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net v2 3/3] ixgbevf: add disable link state
> 
> Add possibility to disable link state if it is administratively disabled in PF.
> 
> It is part of the general functionality that allows the PF driver to control the
> state of the virtual link VF devices.
> 
> Signed-off-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h  |  2 +
> .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 11 ++++-
>  drivers/net/ethernet/intel/ixgbevf/mbx.h      |  2 +
>  drivers/net/ethernet/intel/ixgbevf/vf.c       | 42 +++++++++++++++++++
>  drivers/net/ethernet/intel/ixgbevf/vf.h       |  1 +
>  5 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> index e257390a4f6a..149c733fcc2b 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf.h
> @@ -387,6 +387,8 @@ struct ixgbevf_adapter {

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
