From: Sreenivas, Bharathi <bharathi.sreenivas@intel.com>
Date: Thu, 19 May 2022 10:06:58 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix calculating the
 number of queue pairs
In-Reply-To: <20220429124023.979010-1-jedrzej.jagielski@intel.com>
References: <20220429124023.979010-1-jedrzej.jagielski@intel.com>
Message-ID: <MN2PR11MB3614CE8C76DCB2912508DF818ED09@MN2PR11MB3614.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jedzej Jagielski
> Sent: Friday, April 29, 2022 6:10 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Jagielski, Jedrzej <jedrzej.jagielski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix calculating the number of
> queue pairs
> 
> From: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> 
> If ADq is enabled for a VF, then actual number of queue pair is a number of
> currently available traffic classes for this VF.
> 
> Without this change the configuration of the rx/tx queues fails with error.
> 
> Fixes: d29e0d233e0d ("i40e: missing input validation on VF message handling
> by the PF")
> Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Tested-by: Bharathi Sreenivas<bharathi.sreenivas@intel.com>
