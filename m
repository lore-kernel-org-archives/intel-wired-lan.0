From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Thu, 14 Apr 2022 06:41:52 +0000
Subject: [Intel-wired-lan] [PATCH] ice: Fix memory leak in
 ice_get_orom_civd_data()
In-Reply-To: <20220401080051.16846-1-niejianglei2021@163.com>
References: <20220401080051.16846-1-niejianglei2021@163.com>
Message-ID: <BYAPR11MB3367D0896E6DD74BE81196FCFCEF9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jianglei Nie
> Sent: Friday, April 1, 2022 1:31 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; davem at davemloft.net; kuba at kernel.org
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org; Jianglei Nie <niejianglei2021@163.com>
> Subject: [Intel-wired-lan] [PATCH] ice: Fix memory leak in
> ice_get_orom_civd_data()
> 
> Line 637 allocates a memory chunk for orom_data by vzmalloc(). But when
> ice_read_flash_module() fails, the allocated memory is not freed, which will
> lead to a memory leak.
> 
> We can fix it by freeing the orom_data when ce_read_flash_module() fails.
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_nvm.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)
