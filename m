From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 17 Nov 2017 08:58:40 -0800
Subject: [Intel-wired-lan] [RFC PATCH jkirsher/next-queue 1/9] ixgbe:
 remove undefined and conflicting bits
In-Reply-To: <1510862087-1924-2-git-send-email-shannon.nelson@oracle.com>
References: <1510862087-1924-1-git-send-email-shannon.nelson@oracle.com>
 <1510862087-1924-2-git-send-email-shannon.nelson@oracle.com>
Message-ID: <CAKgT0UdJ38aE48TNm2UGbzV+QWXxFor8TwgvYWMnxqSWXzpfZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Nov 16, 2017 at 11:54 AM, Shannon Nelson
<shannon.nelson@oracle.com> wrote:
> The PE and OSE error bits from the Advanced Receive Writeback
> descriptor are undefined in the published Niantic family datasheets
> and conflict with the defined SECERR bits, which we will need in
> a coming patch.
>
> The CE and LE error bits are also marked as reserved in the
> datasheet, but I'll let someone else remove them.
>
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> index ffa0ee5..0a77941 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> @@ -2375,8 +2375,6 @@ enum {
>  #define IXGBE_RXDADV_ERR_HBO    0x00800000 /*Header Buffer Overflow */
>  #define IXGBE_RXDADV_ERR_CE     0x01000000 /* CRC Error */
>  #define IXGBE_RXDADV_ERR_LE     0x02000000 /* Length Error */
> -#define IXGBE_RXDADV_ERR_PE     0x08000000 /* Packet Error */
> -#define IXGBE_RXDADV_ERR_OSE    0x10000000 /* Oversize Error */
>  #define IXGBE_RXDADV_ERR_USE    0x20000000 /* Undersize Error */
>  #define IXGBE_RXDADV_ERR_TCPE   0x40000000 /* TCP/UDP Checksum Error */
>  #define IXGBE_RXDADV_ERR_IPE    0x80000000 /* IP Checksum Error */
> @@ -2482,8 +2480,6 @@ enum {
>  #define IXGBE_RXDADV_ERR_FRAME_ERR_MASK ( \
>                                       IXGBE_RXDADV_ERR_CE | \
>                                       IXGBE_RXDADV_ERR_LE | \
> -                                     IXGBE_RXDADV_ERR_PE | \
> -                                     IXGBE_RXDADV_ERR_OSE | \
>                                       IXGBE_RXDADV_ERR_USE)
>
>  /* Multicast bit mask */

So I have to NAK this. Those bits do apply to 82598, and were
redefined for 82599 and later.

I'm assuming int he later patches I will see the reason why you needed
to drop them, but for now you might look at splitting the mask up and
leaving this as-is for 82598 and then dropping those two bits for
82599 if we need to.

- Alex
