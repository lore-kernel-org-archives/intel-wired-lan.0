From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Fri, 15 Dec 2017 12:22:30 -0800
Subject: [Intel-wired-lan] [PATCH v2 next-queue 08/10] ixgbe: process
 the Tx ipsec offload
In-Reply-To: <201712160304.vXamGJOb%fengguang.wu@intel.com>
References: <1513121823-27944-9-git-send-email-shannon.nelson@oracle.com>
 <201712160304.vXamGJOb%fengguang.wu@intel.com>
Message-ID: <5dacf242-7d8d-cb55-7532-63d7ea4e3b51@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/15/2017 12:10 PM, kbuild test robot wrote:
[...]
> 
>     drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_xmit_frame_ring':
>>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8563:11: error: 'struct sk_buff' has no member named 'sp'; did you mean 'sk'?
>       if (skb->sp && !ixgbe_ipsec_tx(tx_ring, first, &ipsec_tx))
>                ^~
>                sk
> 
> vim +8563 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> 
>    8562	
>> 8563		if (skb->sp && !ixgbe_ipsec_tx(tx_ring, first, &ipsec_tx))
>    8564			goto out_drop;

Thanks, Mr. Roboto.  Obviously an #ifdef is in order around this little 
block.

sln

