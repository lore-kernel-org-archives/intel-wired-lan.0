From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Fri, 26 Nov 2021 14:11:00 +0000
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix reporting when
 setting descriptor count
In-Reply-To: <20211026125909.28459-1-michal.maloszewski@intel.com>
References: <20211026125909.28459-1-michal.maloszewski@intel.com>
Message-ID: <DM8PR11MB5621018A00574B5CA3C5DDBEAB639@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Michal Maloszewski
> Sent: wtorek, 26 pa?dziernika 2021 14:59
> To: intel-wired-lan at lists.osuosl.org
> Cc: Maloszewski, Michal <michal.maloszewski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix reporting when setting
> descriptor count
> 
> iavf_set_ringparams doesn't communicate to the user that
> 
> 1. The user requested descriptor count is out of range. Instead it
>    just quietly sets descriptors to the "clamped" value and calls it
>    done. This makes it look an invalid value was successfully set as
>    the descriptor count when this isn't actually true.
> 
> 2. The user provided descriptor count needs to be inflated for alignment
>    reasons.
> 
> This behavior is confusing. The ice driver has already addressed this by
> rejecting invalid values for descriptor count and messaging for alignment
> adjustments.
> Do the same thing here by adding the error and info messages.
> 
> Fixes: fbb7ddfef253 ("i40evf: core ethtool functionality")
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Signed-off-by: Michal Maloszewski <michal.maloszewski@intel.com>
> ---
>  .../net/ethernet/intel/iavf/iavf_ethtool.c    | 43 ++++++++++++++-----
>  1 file changed, 32 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> index 30b125d6f5..9522bce3d9 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
