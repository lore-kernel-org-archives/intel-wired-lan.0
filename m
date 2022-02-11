From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Fri, 11 Feb 2022 07:27:12 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 1/2] iavf: stop leaking
 iavf_status as "errno" values
In-Reply-To: <20220127141629.28189-1-mateusz.palczewski@intel.com>
References: <20220127141629.28189-1-mateusz.palczewski@intel.com>
Message-ID: <DM8PR11MB56215CF622505ACE28CB7809AB309@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mateusz Palczewski
> Sent: Thursday, January 27, 2022 3:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Palczewski, Mateusz <mateusz.palczewski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v3 1/2] iavf: stop leaking
> iavf_status as "errno" values
> 
> Several functions in the iAVF core files take status values of the enum
> iavf_status and convert them into integer values. This leads to confusion as
> functions return both Linux errno values and status codes intermixed.
> Reporting status codes as if they were "errno" values can lead to confusion
> when reviewing error logs. Additionally, it can lead to unexpected behavior if
> a return value is not interpreted properly.
> 
> Fix this by introducing iavf_status_to_errno, a switch that explicitly converts
> from the status codes into an appropriate error value. Also introduce a
> virtchnl_status_to_errno function for the one case where we were returning
> both virtchnl status codes and iavf_status codes in the same function.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>  v2: Submit this with additional patch introducing iavf_status_to_errno
> function
>  v3: Change iavf_poll_virtchnl_msg to int
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h        |   5 +-
>  drivers/net/ethernet/intel/iavf/iavf_main.c   | 172 +++++++++++++++---
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  18 +-
>  3 files changed, 156 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> b/drivers/net/ethernet/intel/iavf/iavf.h
> index 6f93759..8287f9f 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
