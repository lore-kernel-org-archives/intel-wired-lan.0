From: John Fastabend <john.fastabend@gmail.com>
Date: Mon, 07 Mar 2016 11:30:25 -0800
Subject: [Intel-wired-lan] [PATCH v2 net-next 2/3] net: ixgbe: Fix
 cls_u32 offload support for fields with masks.
In-Reply-To: <1457372509-3135-2-git-send-email-sridhar.samudrala@intel.com>
References: <1457372509-3135-1-git-send-email-sridhar.samudrala@intel.com>
 <1457372509-3135-2-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <56DDD6D1.3030501@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 16-03-07 09:41 AM, Sridhar Samudrala wrote:
> Remove the incorrect check for mask in ixgbe_configure_clsu32 and
> drop the 'mask' field that is not required in struct ixgbe_mat_field
> 
> Verified with the following filters:
> 
>  #tc qdisc add dev p4p1 ingress
>  #tc filter add dev p4p1 parent ffff: protocol ip prio 99 \
> 	handle 800:0:1 u32 ht 800: \
> 	match ip dst 10.0.0.1/8 match ip src 10.0.0.2/8 action drop
>  #tc filter add dev p4p1 parent ffff: protocol ip prio 99 \
> 	handle 800:0:2 u32 ht 800: \
> 	match ip dst 11.0.0.1/16 match ip src 11.0.0.2/16 action drop
>  #tc filter add dev p4p1 parent ffff: protocol ip prio 99 \
> 	handle 800:0:3 u32 ht 800: \
> 	match ip dst 12.0.0.1/24 match ip src 12.0.0.2/24 action drop
>  #tc filter add dev p4p1 parent ffff: protocol ip prio 99 \
> 	handle 800:0:4 u32 ht 800: \
> 	match ip dst 13.0.0.1/32 match ip src 13.0.0.2/32 action drop
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---


Nice cleanup now we can support various masks as well on the other
fields.

Acked-by: John Fastabend <john.r.fastabend@intel.com>
