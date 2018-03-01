From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 1 Mar 2018 21:11:21 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add receive length error
 counter.
In-Reply-To: <1519819149-10012-1-git-send-email-xiangxia.m.yue@gmail.com>
References: <1519819149-10012-1-git-send-email-xiangxia.m.yue@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94AFB1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tonghao Zhang
> Sent: Wednesday, February 28, 2018 3:59 AM
> To: intel-wired-lan at osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Add receive length error counter.
> 
> ixgbe enabled rlec counter and the rx_error used it.
> We can export the counter directly via ethtool -S ethX.
> 
> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


