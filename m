From: P, Bindushree <bindushree.p@intel.com>
Date: Tue, 30 Nov 2021 09:37:53 +0000
Subject: [Intel-wired-lan] [PATCH net v3] i40e: Fix pre-set max number
 of queues for VF
In-Reply-To: <20210716093356.7800-1-mateusz.palczewski@intel.com>
References: <20210716093356.7800-1-mateusz.palczewski@intel.com>
Message-ID: <PH0PR11MB49986AE5121908F6093E3E098C679@PH0PR11MB4998.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Palczewski, Mateusz
> Sent: Friday, July 16, 2021 3:04 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Palczewski, Mateusz <mateusz.palczewski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v3] i40e: Fix pre-set max number of
> queues for VF
> 
> After setting pre-set combined to 16 queues and reserving 16 queues by tc
> qdisc, pre-set maximum combined queues returned to default value after VF
> reset being 4 and this generated errors during removing tc.
> Fixed by removing clear num_req_queues before reset VF.
> 
> Fixes: e284fc280473 (i40e: Add and delete cloud filter)
> Change-Id: Ib2db315e4b04eeb15e12301edf833014a929e914
> Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>  v2: Refactored commit message
>  v3: Fixed wrong e-mail address in commit message
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
Tested-by: P, Bindushree  <Bindushree.p@intel.com>
