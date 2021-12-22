From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Wed, 22 Dec 2021 11:00:08 +0000
Subject: [Intel-wired-lan] [PATCH -next] i40e: remove variables set but
 not used
In-Reply-To: <20211213031107.52438-1-yang.lee@linux.alibaba.com>
References: <20211213031107.52438-1-yang.lee@linux.alibaba.com>
Message-ID: <BYAPR11MB336744DCED9E187D5051F81CFC7D9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Yang
> Li
> Sent: Monday, December 13, 2021 8:41 AM
> To: davem at davemloft.net
> Cc: Yang Li <yang.lee@linux.alibaba.com>; netdev at vger.kernel.org;
> llvm at lists.linux.dev; ndesaulniers at google.com; linux-kernel at vger.kernel.org;
> nathan at kernel.org; Abaci Robot <abaci@linux.alibaba.com>;
> kuba at kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH -next] i40e: remove variables set but not used
> 
> The code that uses variables pe_cntx_size and pe_filt_size has been removed,
> so they should be removed as well.
> 
> Eliminate the following clang warnings:
> drivers/net/ethernet/intel/i40e/i40e_common.c:4139:20:
> warning: variable 'pe_filt_size' set but not used.
> drivers/net/ethernet/intel/i40e/i40e_common.c:4139:6:
> warning: variable 'pe_cntx_size' set but not used.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: 467d729abb72 ("i40e/i40evf: Fix code to accommodate i40e_register.h
> changes")
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 5 -----
>  1 file changed, 5 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
