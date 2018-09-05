From: Wang, Dongsheng <dongsheng.wang@hxt-semitech.com>
Date: Wed, 5 Sep 2018 01:32:36 +0000
Subject: [Intel-wired-lan] [PATCH] net: ethernet: i40e: fix build error
References: <1536054527-34184-1-git-send-email-dongsheng.wang@hxt-semitech.com>
 <84982f95-940e-d278-f6a2-13a9f76823c9@cogentembedded.com>
Message-ID: <543739fcaa474cb2bcc5604e27527358@HXTBJIDCEMVIW02.hxtcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2018/9/4 18:54, Sergei Shtylyov wrote:
> On 9/4/2018 12:48 PM, Wang Dongsheng wrote:
>
>> Remove "inline" from __i40e_add_stat_strings.
>>
>> In file included from
>> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:9:0:
>> drivers/net/ethernet/intel/i40e/i40e_ethtool.c: In function
>> ?__i40e_add_stat_strings?:
>> drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h:193:20: error:
>> function ?__i40e_add_stat_strings? can never be inlined because it uses
>> variable argument lists
>>   static inline void __i40e_add_stat_strings(u8 **p, const struct
>> 					    i40e_stats stats[],
>>
>> Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
>> ---
>>   drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
>> index bba1cb0..0290ade 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
>> @@ -190,7 +190,7 @@ struct i40e_stats {
>>    * Format and copy the strings described by stats into the buffer pointed at
>>    * by p.
>>    **/
>> -static inline void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
>> +static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
>     You can't have non-inline function in a header file. Please move it, 
> leaving only prototype here.
:(. Oops, a stupid mistake...fix an error and bring in another
error...Thanks.

Cheers,
-Dongsheng
>>   				    const unsigned int size, ...)
>>   {
>>   	unsigned int i;
> MBR, Sergei
>

