From: Linkui Xiao <xiaolinkui@gmail.com>
Date: Wed, 11 May 2022 17:13:07 +0800
Subject: [Intel-wired-lan] [PATCH] igb: Convert a series of if
 statements to switch case
In-Reply-To: <6b16f60d-0f76-f876-0881-de09ecbbbc89@molgen.mpg.de>
References: <20220510025755.19047-1-xiaolinkui@kylinos.cn>
 <6b16f60d-0f76-f876-0881-de09ecbbbc89@molgen.mpg.de>
Message-ID: <d42df7fa-0eb1-bf89-6e8f-f4fc5ff138b2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Paul:

Thank you for your reply and suggestions, I will send the V2 version soon.

On 5/11/22 14:32, Paul Menzel wrote:
> Dear Linkui,
>
>
> Thank you for your patch.
>
> Am 10.05.22 um 04:57 schrieb xiaolinkui:
>> From: Linkui Xiao<xiaolinkui@kylinos.cn>
>
> Please add a space before the <.
>
>> Convert a series of if statements that handle different events to
>> a switch case statement to simplify the code.
>
> (Nit: Please use 75 characters per line.)
>
>> Signed-off-by: Linkui Xiao<xiaolinkui@kylinos.cn>
>> ---
>> ? drivers/net/ethernet/intel/igb/igb_main.c | 12 ++++++++----
>> ? 1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c 
>> b/drivers/net/ethernet/intel/igb/igb_main.c
>> index 34b33b21e0dc..4ce0718eeff6 100644
>> --- a/drivers/net/ethernet/intel/igb/igb_main.c
>> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
>> @@ -4588,13 +4588,17 @@ static inline void 
>> igb_set_vf_vlan_strip(struct igb_adapter *adapter,
>> ????? struct e1000_hw *hw = &adapter->hw;
>> ????? u32 val, reg;
>> ? -??? if (hw->mac.type < e1000_82576)
>> +??? switch (hw->mac.type) {
>> +??? case e1000_undefined:
>> +??? case e1000_82575:
>> ????????? return;
>> -
>> -??? if (hw->mac.type == e1000_i350)
>> +??? case e1000_i350:
>> ????????? reg = E1000_DVMOLR(vfn);
>> -??? else
>> +??????? break;
>> +??? default:
>> ????????? reg = E1000_VMOLR(vfn);
>> +??????? break;
>> +??? }
>> ? ????? val = rd32(reg);
>> ????? if (enable)
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
>
> Kind regards,
>
> Paul
