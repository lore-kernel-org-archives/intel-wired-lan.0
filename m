From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 9 Sep 2019 21:01:39 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: use
 skb_get_queue_mapping in tx path
In-Reply-To: <1566471406-102583-1-git-send-email-xiangxia.m.yue@gmail.com>
References: <1566471406-102583-1-git-send-email-xiangxia.m.yue@gmail.com>
Message-ID: <61d3cd52c23746fa9d18495feef21e87@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of xiangxia.m.yue at gmail.com
> Sent: Thursday, August 22, 2019 3:57 AM
> To: intel-wired-lan at osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: use
> skb_get_queue_mapping in tx path
> 
> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> 
> Use the common api, and don't access queue_mapping directly.
> 
> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


