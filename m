From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 15 Oct 2015 21:01:13 -0700
Subject: [Intel-wired-lan] [next-queue v4 13/17] fm10k: Update adaptive
 ITR algorithm
In-Reply-To: <1444949681-14464-13-git-send-email-jacob.e.keller@intel.com>
References: <1444949681-14464-1-git-send-email-jacob.e.keller@intel.com>
 <1444949681-14464-13-git-send-email-jacob.e.keller@intel.com>
Message-ID: <56207689.9070603@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/15/2015 03:54 PM, Jacob Keller wrote:
> The existing adaptive ITR algorithm is overly restrictive. It throttles
> incorrectly for various traffic rates, and does not produce good
> performance. The algorithm now allows for more interrupts per second,
> and does some calculation to help improve for smaller packet loads. In
> addition, take into account the new itr_scale from the hardware which
> indicates how much to scale due to PCIe link speed.
>
> Reported-by: Matthew Vick <matthew.vick@intel.com>
> Reported-by: Alex Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>   drivers/net/ethernet/intel/fm10k/fm10k.h      |  1 +
>   drivers/net/ethernet/intel/fm10k/fm10k_main.c | 52 ++++++++++++++++++++-------
>   drivers/net/ethernet/intel/fm10k/fm10k_pci.c  |  6 ++--
>   3 files changed, 45 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
> index a2484cb88d86..bdbb804a594f 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k.h
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
> @@ -164,6 +164,7 @@ struct fm10k_ring_container {
>   	unsigned int total_packets;	/* total packets processed this int */
>   	u16 work_limit;			/* total work allowed per interrupt */
>   	u16 itr;			/* interrupt throttle rate value */
> +	u8 itr_scale;			/* ITR adjustment scaler based on PCI speed */
>   	u8 count;			/* total number of rings in vector */
>   };
>
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> index 8207ee189600..8fd9a48433a0 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> @@ -1367,7 +1367,7 @@ static bool fm10k_clean_tx_irq(struct fm10k_q_vector *q_vector,
>    **/
>   static void fm10k_update_itr(struct fm10k_ring_container *ring_container)
>   {
> -	unsigned int avg_wire_size, packets;
> +	unsigned int avg_wire_size, packets, itr_round;
>
>   	/* Only update ITR if we are using adaptive setting */
>   	if (!ITR_IS_ADAPTIVE(ring_container->itr))
> @@ -1379,18 +1379,44 @@ static void fm10k_update_itr(struct fm10k_ring_container *ring_container)
>
>   	avg_wire_size = ring_container->total_bytes / packets;
>
> -	/* Add 24 bytes to size to account for CRC, preamble, and gap */
> -	avg_wire_size += 24;
> +	/* The following is a crude approximation of:
> +	 *  wmem_default / (size + overhead) = desired_pkts_per_int
> +	 *  rate / bits_per_byte / (size + ethernet overhead) = pkt_rate
> +	 *  (desired_pkt_rate / pkt_rate) * usecs_per_sec = ITR value
> +	 *
> +	 * Assuming wmem_default is 212992 and overhead is 640 bytes per
> +	 * packet, (256 skb, 64 headroom, 320 shared info), we can reduce the
> +	 * formula down to
> +	 *
> +	 *  (34 * (size + 24)) / (size + 640) = ITR
> +	 *
> +	 * We first do some math on the packet size and then finally bitshift
> +	 * by 8 after rounding up. We also have to account for PCIe link speed
> +	 * difference as ITR scales based on this.
> +	 */
> +	if (avg_wire_size <= 360) {
> +		/* Start at 333K ints/sec and gradually drop to 77K ints/sec */

I was just rechecking the math on this and realized there was a rounding 
error.  This actually generates 250K interrupts per second at the peak, 
not 333K.  I basically had rounded down to 3 instead of up to 4 when I 
calculated the value for 60 byte packets.

It's just the comment that needs to be changed.  The algorithm itself 
should still be good.  I wouldn't have said anything but based on 
Bruce's comment it looks like a v5 will probably be on the way so I 
figured I would mention it.

- Alex
