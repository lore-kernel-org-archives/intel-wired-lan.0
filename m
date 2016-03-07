From: John Fastabend <john.fastabend@gmail.com>
Date: Mon, 07 Mar 2016 11:29:27 -0800
Subject: [Intel-wired-lan] [PATCH v2 net-next 1/3] net: ixgbe: fix error
 handling in tc cls_u32 offload routines.
In-Reply-To: <1457372509-3135-1-git-send-email-sridhar.samudrala@intel.com>
References: <1457372509-3135-1-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <56DDD697.4020700@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 16-03-07 09:41 AM, Sridhar Samudrala wrote:
> Check for handle ids when adding/deleting hash nodes OR adding/deleting
> filter entries and limit them to max number of links or header nodes
> supported(IXGBE_MAX_LINK_HANDLE).
> 
> Start from bit 0 when setting hash table bit-map.(adapter->tables)
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> 
> ---
> 

Looks good.

Acked-by: John Fastabend <john.r.fastabend@intel.com>

