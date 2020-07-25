From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Sat, 25 Jul 2020 00:02:51 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: use eth_zero_addr() to clear
 mac address
In-Reply-To: <1595233661-13699-1-git-send-email-linmiaohe@huawei.com>
References: <1595233661-13699-1-git-send-email-linmiaohe@huawei.com>
Message-ID: <BN6PR1101MB2145A1849CC7D75BA3430D078C740@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> linmiaohe
> Sent: Monday, July 20, 2020 1:28 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; davem at davemloft.net;
> kuba at kernel.org
> Cc: linmiaohe at huawei.com; netdev at vger.kernel.org; intel-wired-
> lan at lists.osuosl.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: use eth_zero_addr() to clear mac
> address
> 
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> Use eth_zero_addr() to clear mac address insetad of memset().
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


