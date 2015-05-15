From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Fri, 15 May 2015 00:54:50 +0000
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe: add array of MAC type
 dependent values
In-Reply-To: <55553F13.2010605@redhat.com>
References: <20150514221630.16569.73269.stgit@dcs-desk.jf.intel.com>
 <55553F13.2010605@redhat.com>
Message-ID: <A9182E1B-C952-444F-9F31-073EC66CDC7A@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On May 14, 2015, at 5:34 PM, Alexander Duyck <alexander.h.duyck@redhat.com> wrote:
> 
> On 05/14/2015 03:16 PM, Don Skidmore wrote:

<snip>

> I added a few comments inline below.  Other than the fact that you should make the tables all const the only other thing I see is the naming is a big ugly.  I explained more in the comments below.
> 
> - Alex

>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
>> index 06d8f3c..f61ab24 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
>> @@ -57,6 +57,11 @@ static s32 ixgbe_detect_eeprom_page_size_generic(struct ixgbe_hw *hw,
>>  						 u16 offset);
>>  static s32 ixgbe_disable_pcie_master(struct ixgbe_hw *hw);
>> 
>> +/* Base table for registers values that change by MAC */
>> +u32 ixgbe_mvals_base[IXGBE_MVALS_IDX_LIMIT] = {
>> +	IXGBE_MVALS_INIT()
>> +};
>> +
> 
> This should be const u32, also I would say you might as well add a prefix for it.  Since you are lumping them together you might just label it something like 82598, 82599, or maybe even 8259X.

Yes, 8259X would be better than "base". I am terrible at naming...

>> @@ -4866,7 +4867,7 @@ static void ixgbe_setup_gpie(struct ixgbe_adapter *adapter)
>> 
>>  	/* Enable fan failure interrupt */
>>  	if (adapter->flags & IXGBE_FLAG_FAN_FAIL_CAPABLE)
>> -		gpie |= IXGBE_SDP1_GPIEN;
>> +		gpie |= IXGBE_SDP1_GPIEN_BY_MAC(hw);
>> 
>>  	if (hw->mac.type == ixgbe_mac_82599EB) {
>>  		gpie |= IXGBE_SDP1_GPIEN;
> 
> I'm not really a fan of the _BY_MAC being added on.  I would say to just make the default register require an argument.  So instead it comes out IXGBE_SPD1_GPIEN(hw).  By doing that you guarantee that you have caught any places where the old define was being used.

It would preclude optimizing any paths where we know which one we want, but these generally are not hot paths, so I guess we should consider it. The problem is that it triggers a whole lot of other modifications. As you can see even in the above fragment, there is an access clearly for 82599 that avoids the lookup by using the symbol directly. In some of the device-specific files, there would be many such references to change to adopt your suggestion.

>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
>> index dd6ba59..4eb90af 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
>> @@ -91,14 +91,24 @@
>>  #define IXGBE_DEV_ID_X550_VF		0x1565
>>  #define IXGBE_DEV_ID_X550EM_X_VF	0x15A8
>> 
>> +#define IXGBE_CAT(r, m)	IXGBE_##r##m
>> +
>> +#define IXGBE_BY_MAC(_hw, r)	((_hw)->mvals[IXGBE_CAT(r, _IDX)])
>> +
> 
> It seems like if you defined IXGBE_CAT(r, m) as IXGBE_##r_##m you could save yourself a bit of trouble by dropping all of the underscores you are having to pass when you call IXGBE_CAT or IXGBE_MVALS_INIT.

Well, since the current implementation has the symbol with no model suffix as the "base" value, the underscore could not be included so that those values would be generated into the "base" array - note the null parameter passed to the IXGBE_MVALS_INIT macro. Of course if we rename everything as you suggest, we could supply the underscore in the macro.

>>  /* General Registers */
>>  #define IXGBE_CTRL      0x00000
>>  #define IXGBE_STATUS    0x00008
>>  #define IXGBE_CTRL_EXT  0x00018
>>  #define IXGBE_ESDP      0x00020
>>  #define IXGBE_EODSDP    0x00028
>> -#define IXGBE_I2CCTL_BY_MAC(_hw)((((_hw)->mac.type >= ixgbe_mac_X550) ? \
>> -					0x15F5C : 0x00028))
>> +
>> +#define IXGBE_I2CCTL	0x00028
>> +#define IXGBE_I2CCTL_X540	IXGBE_I2CCTL
>> +#define IXGBE_I2CCTL_X550	0x15F5C
>> +#define IXGBE_I2CCTL_X550EM_x	IXGBE_I2CCTL_X550
>> +#define IXGBE_I2CCTL_X550EM_a	IXGBE_I2CCTL_X550
>> +#define IXGBE_I2CCTL_BY_MAC(_hw)	IXGBE_BY_MAC((_hw), I2CCTL)
>> +
> 
> For the sake of readability I would say to lose the _BY_MAC name and just use the register name.  Then you can replace the register name based version with something like 82599 since that is probably where the original register started at.

Yeah, 8259X would work, since the "base" values here are used for both 82598 and 82599. Don and I will have to discuss this tomorrow.

--
Mark Rustad, Networking Division, Intel Corporation

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150515/1fa5eb7b/attachment.asc>
