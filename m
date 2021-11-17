From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 17 Nov 2021 10:27:41 +0000
Subject: [Intel-wired-lan] [PATCH net-next 14/15] iavf: return errno
 code instead of status code
In-Reply-To: <20210604165335.33329-14-anthony.l.nguyen@intel.com>
References: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
 <20210604165335.33329-14-anthony.l.nguyen@intel.com>
Message-ID: <DM8PR11MB5621EE379CD58A6542F88A55AB9A9@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: pi?tek, 4 czerwca 2021 18:54
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next 14/15] iavf: return errno code
> instead of status code
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The iavf_parse_cls_flower function returns an integer error code, and not an
> iavf_status enumeration.
> 
> Fix the function to use the standard errno value EINVAL as its return instead
> of using IAVF_ERR_CONFIG.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 892aa22b39da..7730de0ef236 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
