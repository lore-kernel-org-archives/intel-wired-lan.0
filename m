From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 1 Dec 2018 03:01:31 +0000
Subject: [Intel-wired-lan] [PATCH net-next] e100: Fix passing zero to
 'PTR_ERR' warning in e100_load_ucode_wait
In-Reply-To: <20181119124819.15860-1-yuehaibing@huawei.com>
References: <20181119124819.15860-1-yuehaibing@huawei.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B965CB705@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of YueHaibing
> Sent: Monday, November 19, 2018 4:48 AM
> To: davem at davemloft.net; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; YueHaibing <yuehaibing@huawei.com>; intel-
> wired-lan at lists.osuosl.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next] e100: Fix passing zero to
> 'PTR_ERR' warning in e100_load_ucode_wait
> 
> Fix a static code checker warning:
> drivers/net/ethernet/intel/e100.c:1349
>  e100_load_ucode_wait() warn: passing zero to 'PTR_ERR'
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/intel/e100.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
