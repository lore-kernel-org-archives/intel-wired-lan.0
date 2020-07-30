From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 30 Jul 2020 18:10:58 +0000
Subject: [Intel-wired-lan] [PATCH] igb: use eth_zero_addr() to clear mac
 address
In-Reply-To: <1595233754-13765-1-git-send-email-linmiaohe@huawei.com>
References: <1595233754-13765-1-git-send-email-linmiaohe@huawei.com>
Message-ID: <DM6PR11MB28901BD34266235B3CB65D9ABC710@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: linmiaohe <linmiaohe@huawei.com>
> Sent: Monday, July 20, 2020 1:29 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; davem at davemloft.net;
> kuba at kernel.org
> Cc: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; linmiaohe at huawei.com
> Subject: [PATCH] igb: use eth_zero_addr() to clear mac address
> 
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> Use eth_zero_addr() to clear mac address insetad of memset().
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
