From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Thu, 14 Apr 2022 09:15:52 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unused phy_type
 enum
In-Reply-To: <716d73f5-3e2d-0ed9-d9b9-356406988010@intel.com>
References: <20220413053317.3297670-1-sasha.neftin@intel.com>
 <716d73f5-3e2d-0ed9-d9b9-356406988010@intel.com>
Message-ID: <3bd66d57-25bb-909c-4106-c4c46be45ac8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 4/13/2022 21:13, Tony Nguyen wrote:
> 
> On 4/12/2022 10:33 PM, Sasha Neftin wrote:
> 
> <snip>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_phy.c 
>> b/drivers/net/ethernet/intel/igc/igc_phy.c
>> index 6961f65d36b9..4f06e6bb68b1 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_phy.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_phy.c
>> @@ -150,13 +150,9 @@ s32 igc_check_downshift(struct igc_hw *hw)
>> ????? struct igc_phy_info *phy = &hw->phy;
>> ????? s32 ret_val;
>> -??? switch (phy->type) {
>> -??? case igc_phy_i225:
>> -??? default:
>> -??????? /* speed downshift not supported */
>> -??????? phy->speed_downgraded = false;
>> -??????? ret_val = 0;
>> -??? }
>> +??? /* speed downshift not supported */
>> +??? phy->speed_downgraded = false;
>> +??? ret_val = 0;
>> ????? return ret_val;
> 
> ret_val isn't needed since it's always returning 0 and could possibly be 
> made a void function.
Thank you, Tony, right. I believe it is a minor logical change - it 
should be a different patch. I remember we have a few similar cases in 
igc. I plan (TODO) to fix them.
> 
> Thanks,
> 
> Tony
> 

