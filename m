From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 14 Mar 2018 10:25:29 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v4 2/8] igb: Fix queue
 selection on MAC filters on i210 and i211
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B8C8032BA@ORSMSX101.amr.corp.intel.com>
References: <20180308003713.29195-1-vinicius.gomes@intel.com>
 <20180308003713.29195-3-vinicius.gomes@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B8C8032BA@ORSMSX101.amr.corp.intel.com>
Message-ID: <87woyewovq.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

"Brown, Aaron F" <aaron.f.brown@intel.com> writes:

>> --- a/drivers/net/ethernet/intel/igb/igb_main.c
>> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
>> @@ -8747,12 +8747,19 @@ static void igb_rar_set_index(struct igb_adapter
>> *adapter, u32 index)
>>  		if (is_valid_ether_addr(addr))
>>  			rar_high |= E1000_RAH_AV;
>> 
>> -		if (hw->mac.type == e1000_82575)
>> +		switch (hw->mac.type) {
>> +		case e1000_82575:
>> +		case e1000_i210:
>> +		case e1000_i211:
>> +			rar_high |= E1000_RAH_QSEL_ENABLE;
>>  			rar_high |= E1000_RAH_POOL_1 *
>> -				    adapter->mac_table[index].queue;
>> -		else
>> +				      adapter->mac_table[index].queue;
>> +			break;
>> +		default:
>>  			rar_high |= E1000_RAH_POOL_1 <<
>> -				    adapter->mac_table[index].queue;
>> +				adapter->mac_table[index].queue;
>
> Small nit.  Shouldn't this line be indented more to be a few spaces
> past the "|=" operator as above?

I don't know why my editor seemed to disagree, I will fix.


Thank you,
--
Vinicius
