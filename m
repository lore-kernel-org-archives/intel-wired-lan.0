From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Thu, 10 Nov 2016 17:37:04 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Reduce I2C retry count
	on	X550	devices
In-Reply-To: <21814759-D688-449F-B029-E3251806979F@intel.com>
References: <1478717406-2295-1-git-send-email-anthony.l.nguyen@intel.com>
 <21814759-D688-449F-B029-E3251806979F@intel.com>
Message-ID: <4AA780B2-5706-45BF-8190-B97E70EF9381@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I should have been more specific in my previous message. See below:

Mark D <mark.d.rustad@intel.com> wrote:

> Tony Nguyen <anthony.l.nguyen@intel.com> wrote:
>
>> A retry count of 10 is likely to run into problems on X550 devices that
>> have to detect and reset unresponsive CS4227 devices. So, reduce the I2C
>> retry count to 3 for X550 and above. This should avoid any possible
>> regressions in existing devices.
>
> There is no reason to check the MAC type. There are no devices prior to  
> X550 that can use I2C combined bus cycles - the CS4227 on Xeon D is the  
> only one. So just change the retry count if that is what is needed. There  
> is no need to make it conditional.
>
>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>> ---
>>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  
>> b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
>> index 4aa6793..10a102c 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c
>> @@ -121,6 +121,8 @@ s32 ixgbe_read_i2c_combined_generic_int(struct  
>> ixgbe_hw *hw, u8 addr,
>>  	u8 reg_high;
>>  	u8 csum;
>>
>> +	if (hw->mac.type >= ixgbe_mac_X550)
>> +		max_retry = 3;

This MAC check is not needed, because this function can only be used with  
MACs >= X550. So, the normal retry should just be changed.

>>  	reg_high = ((reg >> 7) & 0xFE) | 1;     /* Indicate read combined */
>>  	csum = ixgbe_ones_comp_byte_add(reg_high, reg & 0xFF);
>>  	csum = ~csum;
>> @@ -1756,6 +1758,8 @@ static s32 ixgbe_read_i2c_byte_generic_int(struct  
>> ixgbe_hw *hw, u8 byte_offset,
>>  	u32 swfw_mask = hw->phy.phy_semaphore_mask;
>>  	bool nack = true;
>>
>> +	if (hw->mac.type >= ixgbe_mac_X550)
>> +		max_retry = 3;

This MAC check is needed, because we don't want to change the behavior of  
older devices. This I2C path is used with many of the MACs, so this is as  
it should be.

>>  	if (ixgbe_is_sfp_probe(hw, byte_offset, dev_addr))
>>  		max_retry = IXGBE_SFP_DETECT_RETRIES;

--
Mark Rustad, Networking Division, Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161110/39f8c82d/attachment.asc>
