From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Fri, 11 Feb 2022 07:26:34 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 2/2] iavf: Fix incorrect
 use of assigning iavf_status to int
In-Reply-To: <20220127141640.28398-1-mateusz.palczewski@intel.com>
References: <20220127141640.28398-1-mateusz.palczewski@intel.com>
Message-ID: <DM8PR11MB562137EC8DE1F1A6030689CFAB309@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mateusz Palczewski
> Sent: Thursday, January 27, 2022 3:17 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Palczewski, Mateusz <mateusz.palczewski@intel.com>; Brett Creeley
> <brett.creeley@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v3 2/2] iavf: Fix incorrect use of
> assigning iavf_status to int
> 
> Currently there are functions in iavf_virtchnl.c for polling specific virtchnl
> receive events. These are all assigning iavf_status values to int values. Fix this
> and explicitly assign int values if iavf_status is not IAVF_SUCCESS.
> 
> Also, refactor a small amount of duplicated code that can be reused by all of
> the previously mentioned functions.
> 
> Finally, fix some spacing errors for variable assignment and get rid of all the
> goto statements in the refactored functions for clarity.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>  v2: Submit this with additional patch introducing iavf_status_to_errno
> function
>  v3: Change iavf_poll_virtchnl_msg to int
> ---
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 160 ++++++++----------
>  1 file changed, 68 insertions(+), 92 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index 178cc51..9363b10 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
