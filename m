From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 2 Jan 2018 23:50:28 +0000
Subject: [Intel-wired-lan] [patch net] i40e: flower: Fix return value
 for unsupported offload
In-Reply-To: <20171222114516.1816-1-jiri@resnulli.us>
References: <20171222114516.1816-1-jiri@resnulli.us>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D4C95@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jiri Pirko
> Sent: Friday, December 22, 2017 3:45 AM
> To: netdev at vger.kernel.org
> Cc: mlxsw at mellanox.com; jhs at mojatatu.com; intel-wired-
> lan at lists.osuosl.org; xiyou.wangcong at gmail.com; davem at davemloft.net
> Subject: [Intel-wired-lan] [patch net] i40e: flower: Fix return value for
> unsupported offload
> 
> From: Jiri Pirko <jiri@mellanox.com>
> 
> When filter configuration is not supported, drivers should return -
> EOPNOTSUPP so the core can react correctly.
> 
> Fixes: 2f4b411a3d67 ("i40e: Enable cloud filters via tc-flower")
> Signed-off-by: Jiri Pirko <jiri@mellanox.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


