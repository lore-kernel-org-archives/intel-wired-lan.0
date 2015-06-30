From: Maninder Singh <maninder1.s@samsung.com>
Date: Tue, 30 Jun 2015 08:01:56 +0000 (GMT)
Subject: [Intel-wired-lan] [PATCH 1/1] igb: Use ARRAY_SIZE instead fo
	sizeof(a)/sizeof(a[0])
Message-ID: <1652907052.50321435651311854.JavaMail.weblogic@ep2mlwas04a>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Joe,

>> Use ARRAY_SIZE instead fo sizeof(a)/sizeof(a[0])
>
>I think all of these #defines should be removed instead
>as they are all used only once.

If we replcase only ARRAY_SIZE then cood will look alike
to drivers/net/ethernet/intel/e1000e/phy.c

And if we have to remove these #defines , then we can also remove it from 
drivers/net/ethernet/intel/e1000e/phy.c 

Because same operations and same usage is there in both files.
what say?

>> diff --git a/drivers/net/ethernet/intel/igb/e1000_phy.c b/drivers/net/ethernet/intel/igb/e1000_phy.c
>[]
>> @@ -37,8 +37,7 @@ static s32  igb_set_master_slave_mode(struct e1000_hw *hw);
>>  static const u16 e1000_m88_cable_length_table[] = {
>>  	0, 50, 80, 110, 140, 140, E1000_CABLE_LENGTH_UNDEFINED };
>>  #define M88E1000_CABLE_LENGTH_TABLE_SIZE \
>> -	(sizeof(e1000_m88_cable_length_table) / \
>> -	sizeof(e1000_m88_cable_length_table[0]))
>> +	ARRAY_SIZE(e1000_m88_cable_length_table)
>>  
