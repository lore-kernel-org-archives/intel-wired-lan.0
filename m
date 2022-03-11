From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 11 Mar 2022 06:34:53 +0000
Subject: [Intel-wired-lan] [PATCH -next] ice: fix return value check in
 ice_gnss.c
In-Reply-To: <20220305090430.3078757-1-yangyingliang@huawei.com>
References: <20220305090430.3078757-1-yangyingliang@huawei.com>
Message-ID: <BYAPR11MB3367F780F7761EC6EBD87B2EFC0C9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Yang Yingliang <yangyingliang@huawei.com>
> Sent: Saturday, March 5, 2022 2:35 PM
> To: linux-kernel at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; kuba at kernel.org; davem at davemloft.net;
> Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kolacinski, Karol
> <karol.kolacinski@intel.com>
> Subject: [PATCH -next] ice: fix return value check in ice_gnss.c
> 
> kthread_create_worker() and tty_alloc_driver() return ERR_PTR() and never
> return NULL. The NULL test in the return value check should be replaced with
> IS_ERR().
> 
> Fixes: 43113ff73453 ("ice: add TTY for GNSS module for E810T device")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_gnss.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)
