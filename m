From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Tue, 8 Feb 2022 14:19:37 +0000
Subject: [Intel-wired-lan] [PATCH net v2] iavf: Fix adopting new
 combined setting
In-Reply-To: <20220202124454.28902-1-michal.maloszewski@intel.com>
References: <20220202124454.28902-1-michal.maloszewski@intel.com>
Message-ID: <DM8PR11MB5621B359F4E99852BB9AD22FAB2D9@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Michal Maloszewski
> Sent: Wednesday, February 2, 2022 1:45 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Maloszewski, Michal <michal.maloszewski@intel.com>; Williams, Mitch A
> <mitch.a.williams@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v2] iavf: Fix adopting new combined
> setting
> 
> In some cases overloaded flag IAVF_FLAG_REINIT_ITR_NEEDED which should
> indicate that interrupts need to be completety reinitialized during reset leads
> to RTNL deadlocks using ethtool -C while a reset is in progress.
> To fix, it was added a new flag IAVF_FLAG_REINIT_MSIX_NEEDED used to
> trigger MSI-X reinit.
> New combined setting is fixed adopt after VF reset.
> This has been implemented by call reinit interrupt scheme during VF reset.
> Without this fix new combined setting has never been adopted.
> 
> Fixes: 209f2f9c7181 ("iavf: Add support for
> VIRTCHNL_VF_OFFLOAD_VLAN_V2 negotiation")
> Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Signed-off-by: Michal Maloszewski <michal.maloszewski@intel.com>
> ---
> v2: Changed the fixes tag and made commit message more detailed
> ---
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h      |  1 +
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 13 +++++++++----
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> b/drivers/net/ethernet/intel/iavf/iavf.h
> index bb8f9740e776..f1849f3a2ace 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
