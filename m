From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jan 2020 00:40:05 +0000
Subject: [Intel-wired-lan] [PATCH -next] i40e: remove unnecessary
 conversions to bool
In-Reply-To: <20200119132138.37781-1-chenzhou10@huawei.com>
References: <20200119132138.37781-1-chenzhou10@huawei.com>
Message-ID: <e1fd238f66684cc1a70fe498467177e2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Chen Zhou
> Sent: Sunday, January 19, 2020 5:22 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; davem at davemloft.net
> Cc: chenzhou10 at huawei.com; netdev at vger.kernel.org; intel-wired-
> lan at lists.osuosl.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH -next] i40e: remove unnecessary
> conversions to bool
> 
> The conversions to bool are not needed, remove these.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


