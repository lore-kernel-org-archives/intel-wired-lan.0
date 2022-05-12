From: Linkui Xiao <xiaolinkui@gmail.com>
Date: Thu, 12 May 2022 21:31:58 +0800
Subject: [Intel-wired-lan] [PATCH] igb: Convert a series of if
 statements to switch case
In-Reply-To: <3a5a6467b24a46ce8e05fb8a422baa51@AcuMS.aculab.com>
References: <20220511092004.30173-1-xiaolinkui@kylinos.cn>
 <3a5a6467b24a46ce8e05fb8a422baa51@AcuMS.aculab.com>
Message-ID: <8e7ccd70-78df-64f8-678f-968ad38eae50@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear David,

Thanks for your reply

Logically the two versions are equivalent, hw->mac.type is defined as 
follows:

enum e1000_mac_type {
 ??????? e1000_undefined = 0,
 ??????? e1000_82575,
 ??????? e1000_82576,
 ??????? e1000_82580,
 ??????? e1000_i350,
 ??????? e1000_i354,
 ??????? e1000_i210,
 ??????? e1000_i211,
 ??????? e1000_num_macs? /* List is 1-based, so subtract 1 for true 
count. */
};
Therefore, hw->mac.type < e1000_82576 has only two cases: 
e1000_undefined or e1000_82575.

On 5/12/22 21:14, David Laight wrote:
>> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>>
>> Convert a series of if statements that handle different events to a switch
>> case statement to simplify the code.
>>
>> V2: fix patch description and email format.
>>
>> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
>> ---
>>   drivers/net/ethernet/intel/igb/igb_main.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
>> index 34b33b21e0dc..4ce0718eeff6 100644
>> --- a/drivers/net/ethernet/intel/igb/igb_main.c
>> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
>> @@ -4588,13 +4588,17 @@ static inline void igb_set_vf_vlan_strip(struct igb_adapter *adapter,
>>        struct e1000_hw *hw = &adapter->hw;
>>        u32 val, reg;
>>
>> -     if (hw->mac.type < e1000_82576)
>> +     switch (hw->mac.type) {
>> +     case e1000_undefined:
>> +     case e1000_82575:
>>                return;
>> -
>> -     if (hw->mac.type == e1000_i350)
>> +     case e1000_i350:
>>                reg = E1000_DVMOLR(vfn);
>> -     else
>> +             break;
>> +     default:
>>                reg = E1000_VMOLR(vfn);
>> +             break;
>> +     }
>>
>>        val = rd32(reg);
>>        if (enable)
>> --
>> 2.17.1
> Are you sure that generates reasonable code?
> The compiler could generate something completely different
> for the two versions.
>
> It isn't even obvious they are equivalent.
>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
