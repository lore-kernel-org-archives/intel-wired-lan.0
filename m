From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 2 Dec 2015 13:32:29 -0800
Subject: [Intel-wired-lan] ixgbevf: fix atomicity off
 IXGBEVF_FLAG_QUEUE_RESET_REQUESTED flag
In-Reply-To: <1449087939-5081-1-git-send-email-jogreene@redhat.com>
References: <1449087939-5081-1-git-send-email-jogreene@redhat.com>
Message-ID: <565F636D.8070107@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/02/2015 12:25 PM, John Greene wrote:
> When doing a 'reboot' of a VM, the "ip link set ethX down" of an interface
> using the ixgbevf.ko driver may hang indefinitely blocking the complete
> boot down of the OS.    The "ip" command is executed from an rc6.d script.
> The driver in performing the ioctl() was stuck in ixgbevf_down() looping
> at this line forever:
>
> while (adapter->flags & IXGBE_FLAG_IN_WATCHDOG_TASK)
>                  msleep(1);
>
> While this issue has been fixed already by other upstream patches, it's noted
> that IXGBEVF_FLAG_QUEUE_RESET_REQUESTED flag should likewise be changed.
>
> Signed-off-by: Scott Otto <otts62@yahoo.com>
> Signed-off-by: John Greene <jogreene@redhat.com>
> ---
>   drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index 592ff23..826b04f 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> @@ -1983,7 +1983,7 @@ static int ixgbevf_configure_dcb(struct ixgbevf_adapter *adapter)
>   		hw->mbx.timeout = 0;
>   
>   		/* wait for watchdog to come around and bail us out */
> -		adapter->flags |= IXGBEVF_FLAG_QUEUE_RESET_REQUESTED;
> +		set_bit(IXGBEVF_FLAG_QUEUE_RESET_REQUESTED, &adapter->flags);
>   	}
>   
>   	return 0;
> @@ -3230,10 +3230,10 @@ static void ixgbevf_queue_reset_subtask(struct ixgbevf_adapter *adapter)
>   {
>   	struct net_device *dev = adapter->netdev;
>   
> -	if (!(adapter->flags & IXGBEVF_FLAG_QUEUE_RESET_REQUESTED))
> +	if (!(test_bit(IXGBEVF_FLAG_QUEUE_RESET_REQUESTED, &adapter->flags)))
>   		return;
>   
> -	adapter->flags &= ~IXGBEVF_FLAG_QUEUE_RESET_REQUESTED;
> +	clear_bit(IXGBEVF_FLAG_QUEUE_RESET_REQUESTED, &adapter->flags);
>   
>   	/* if interface is down do nothing */
>   	if (test_bit(__IXGBEVF_DOWN, &adapter->state) ||

Actually looking through this I realized this should also be throwing 
type errors since state is a u32 and last I knew the test/set/clear_bit 
calls expect to be pointing at unsigned longs.

My advice is if you want to go forward with this patch you might look at 
just removing adapter->flags entirely and look at moving RESET_REQUESTED 
and QUEUE_RESET_REQUESTED over into adapter->state as a couple more bits.

- Alex
