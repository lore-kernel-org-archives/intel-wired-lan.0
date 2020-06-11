From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 11 Jun 2020 15:41:23 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: silence an UBSAN false positive
In-Reply-To: <20200606200116.1398-1-cai@lca.pw>
References: <20200606200116.1398-1-cai@lca.pw>
Message-ID: <BN6PR1101MB21456AF399BB25055FC8A83F8C800@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Qian Cai
> Sent: Saturday, June 6, 2020 1:01 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; linux-kernel at vger.kernel.org; Qian Cai
> <cai@lca.pw>; intel-wired-lan at lists.osuosl.org; davem at davemloft.net
> Subject: [Intel-wired-lan] [PATCH] i40e: silence an UBSAN false positive
> 
> virtchnl_rss_lut.lut is used for the RSS lookup table, but in
> i40e_vc_config_rss_lut(), it is indexed by subscript results in a false positive.
> 
>  UBSAN: array-index-out-of-bounds in
> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2983:15
>  index 1 is out of range for type 'u8 [1]'
>  CPU: 34 PID: 871 Comm: kworker/34:2 Not tainted 5.7.0-next-20200605+ #5
> Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40
> 03/09/2018
>  Workqueue: i40e i40e_service_task [i40e]  Call Trace:
>   dump_stack+0xa7/0xea
>   ubsan_epilogue+0x9/0x45
>   __ubsan_handle_out_of_bounds+0x6f/0x80
>   i40e_vc_process_vf_msg+0x457c/0x4660 [i40e]
>   i40e_service_task+0x96c/0x1ab0 [i40e]
>   process_one_work+0x57d/0xbd0
>   worker_thread+0x63/0x5b0
>   kthread+0x20c/0x230
>   ret_from_fork+0x22/0x30
> 
> Fixes: d510497b8397 ("i40e: add input validation for virtchnl handlers")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


