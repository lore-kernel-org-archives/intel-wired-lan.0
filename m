From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Thu, 14 Apr 2022 06:46:50 +0000
Subject: [Intel-wired-lan] [PATCH v2] ice: Fix memory leak in
 ice_get_orom_civd_data()
In-Reply-To: <20220402021715.4740-1-niejianglei2021@163.com>
References: <20220402021715.4740-1-niejianglei2021@163.com>
Message-ID: <BYAPR11MB336754B300ED5C8103BA84FEFCEF9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jianglei Nie
> Sent: Saturday, April 2, 2022 7:47 AM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; davem at davemloft.net; kuba at kernel.org
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org; Jianglei Nie <niejianglei2021@163.com>
> Subject: [Intel-wired-lan] [PATCH v2] ice: Fix memory leak in
> ice_get_orom_civd_data()
> 
> A memory chunk was allocated for orom_data in ice_get_orom_civd_data()
> by vzmalloc(). But when ice_read_flash_module() fails, the allocated
> memory is not freed, which will lead to a memory leak.
> 
> We can fix it by freeing the orom_data when ce_read_flash_module() fails.
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_nvm.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)
