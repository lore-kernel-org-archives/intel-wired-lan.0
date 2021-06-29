From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Tue, 29 Jun 2021 21:07:22 +0000
Subject: [Intel-wired-lan] [PATCH 4/5] ixgbevf: Mailbox improvements
In-Reply-To: <20210629104941.2460721-5-radoslawx.tyl@intel.com>
References: <20210629104941.2460721-1-radoslawx.tyl@intel.com>
 <20210629104941.2460721-5-radoslawx.tyl@intel.com>
Message-ID: <fd5d240b88b5315cb7652bba867a07aeaee89976.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2021-06-29 at 12:49 +0200, Radoslaw Tyl wrote:

<snip>

> +/**
> + * ixgbevf_poll_mbx - Wait for message and read it from the mailbox
> + * @hw: pointer to the HW structure
> + * @msg: The message buffer
> + * @size: Length of buffer
> + * @mbx_id: id of mailbox to read

There's an excess parameter here

warning: Excess function parameter 'mbx_id' description in
'ixgbevf_poll_mbx'

> + *
> + * returns 0 if it successfully read message from buffer
> + **/
> +s32 ixgbevf_poll_mbx(struct ixgbe_hw *hw, u32 *msg, u16 size)
> +{
> +	struct ixgbe_mbx_info *mbx = &hw->mbx;
> +	s32 ret_val = IXGBE_ERR_CONFIG;
> +
> +	if (!mbx->ops.read || !mbx->ops.check_for_msg || !mbx->timeout)
> +		return ret_val;
> +
> +	/* limit read to size of mailbox */
> +	if (size > mbx->size)
> +		size = mbx->size;
> +
> +	ret_val = ixgbevf_poll_for_msg(hw);
> +	/* if ack received read message, otherwise we timed out */
> +	if (!ret_val)
> +		ret_val = mbx->ops.read(hw, msg, size);
> +
> +	return ret_val;
> +}
> +
> +/**
> + * ixgbevf_write_mbx - Write a message to the mailbox and wait for
> ACK
> + * @hw: pointer to the HW structure
> + * @msg: The message buffer
> + * @size: Length of buffer
> + * @mbx_id: id of mailbox to write

and here

warning: Excess function parameter 'mbx_id' description in
'ixgbevf_write_mbx'

> + *
> + * returns 0 if it successfully copied message into the buffer and
> + * received an ACK to that message within specified period
> + **/
> +s32 ixgbevf_write_mbx(struct ixgbe_hw *hw, u32 *msg, u16 size)

