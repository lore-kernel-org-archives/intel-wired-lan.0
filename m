From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon, 18 Jun 2018 10:18:17 -0700
Subject: [Intel-wired-lan] [jkirsher/net-queue PATCH] ixgbe: Be more
 careful when modifying MAC filters
In-Reply-To: <20180618160028.80602.76507.stgit@ahduyck-green-test.jf.intel.com>
References: <20180618160028.80602.76507.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <e3600d43-0887-507c-e234-0712b241d5cf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/18/2018 9:02 AM, Alexander Duyck wrote:
> This change makes it so that we are much more explicit about the ordering
> of updates to the receive address register (RAR) table. Prior to this patch
> I believe we may have been updating the table while entries were still
> active, or possibly allowing for reordering of things since we weren't
> explicitly flushing writes to either the lower or upper portion of the
> register prior to accessing the other half.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> 
> I am submitting this as a fix, but I am not certain this actually fixes
> anything or if it is more of just a clean-up. I know there have been some
> issues with MAC address updates reported recently so I decided to review
> the code and found the bits here that I thought needed to be updated.
> Especially the case where we were clearing the lower 32b of the address
> with AV still set in the upper 32b of the register.

Do you have any particular issue reports you can point to that suggest 
this has been related?

It would be interesting to look into the history of this code, which I 
think has been refactored a couple of times, to see if the earlier code 
had one chunk to add an address with the RAH written last, and to remove 
an address with the RAH written first.

Regardless, this change looks like a good idea.

Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>

sln

> 
>   drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |   12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> index 3f5c350..0bd1294 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> @@ -1871,7 +1871,12 @@ s32 ixgbe_set_rar_generic(struct ixgbe_hw *hw, u32 index, u8 *addr, u32 vmdq,
>   	if (enable_addr != 0)
>   		rar_high |= IXGBE_RAH_AV;
>   
> +	/* Record lower 32 bits of MAC address and then make
> +	 * sure that write is flushed to hardware before writing
> +	 * the upper 16 bits and setting the valid bit.
> +	 */
>   	IXGBE_WRITE_REG(hw, IXGBE_RAL(index), rar_low);
> +	IXGBE_WRITE_FLUSH(hw);
>   	IXGBE_WRITE_REG(hw, IXGBE_RAH(index), rar_high);
>   
>   	return 0;
> @@ -1903,8 +1908,13 @@ s32 ixgbe_clear_rar_generic(struct ixgbe_hw *hw, u32 index)
>   	rar_high = IXGBE_READ_REG(hw, IXGBE_RAH(index));
>   	rar_high &= ~(0x0000FFFF | IXGBE_RAH_AV);
>   
> -	IXGBE_WRITE_REG(hw, IXGBE_RAL(index), 0);
> +	/* Clear the address valid bit and upper 16 bits of the address
> +	 * before clearing the lower bits. This way we aren't updating
> +	 * a live filter.
> +	 */
>   	IXGBE_WRITE_REG(hw, IXGBE_RAH(index), rar_high);
> +	IXGBE_WRITE_FLUSH(hw);
> +	IXGBE_WRITE_REG(hw, IXGBE_RAL(index), 0);
>   
>   	/* clear VMDq pool/queue selection for this RAR */
>   	hw->mac.ops.clear_vmdq(hw, index, IXGBE_CLEAR_VMDQ_ALL);
> 
