From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 29 Apr 2022 18:46:36 -0700
Subject: [Intel-wired-lan] [PATCH net-next v5 1/2] rtnetlink: add extack
 support in fdb del handlers
In-Reply-To: <26815b6deebef7f02e864ca41714533c7009e7b7.1651236082.git.eng.alaamohamedsoliman.am@gmail.com>
References: <cover.1651236081.git.eng.alaamohamedsoliman.am@gmail.com>
 <26815b6deebef7f02e864ca41714533c7009e7b7.1651236082.git.eng.alaamohamedsoliman.am@gmail.com>
Message-ID: <20220429184636.0b869ae7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 29 Apr 2022 14:49:06 +0200 Alaa Mohamed wrote:
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index fde839ef0613..3fccac358198 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5678,7 +5678,7 @@ ice_fdb_add(struct ndmsg *ndm, struct nlattr __always_unused *tb[],
>  static int
>  ice_fdb_del(struct ndmsg *ndm, __always_unused struct nlattr *tb[],
>  	    struct net_device *dev, const unsigned char *addr,
> -	    __always_unused u16 vid)
> +	    __always_unused u16 vid, struct netlink_ext_ack *extack)

You need to update the kdoc on this one.
