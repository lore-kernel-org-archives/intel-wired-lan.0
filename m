From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 4 Sep 2018 10:29:55 +0800
Subject: [Intel-wired-lan] [PATCH net-next] i40e: remove inline directive
In-Reply-To: <b7bfa13d-d33d-87f1-6f0a-95d040610847@cogentembedded.com>
References: <20180903123621.8696-1-yuehaibing@huawei.com>
 <b7bfa13d-d33d-87f1-6f0a-95d040610847@cogentembedded.com>
Message-ID: <814ba312-37a9-40c0-710b-cafac9d7278c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2018/9/4 0:05, Sergei Shtylyov wrote:
> On 09/03/2018 03:36 PM, YueHaibing wrote:
> 
>> Fixes follow gcc warning:
>>
>> drivers/net/ethernet/intel/i40e/i40e_ethtool.c: In function '__i40e_add_stat_strings':
>> drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h:193:20: error: function '__i40e_add_stat_strings' can never be inlined because it uses variable argument lists
>>
>> Fixes: 8fd75c58a09a ("i40e: move ethtool stats boiler plate code to i40e_ethtool_stats.h")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
>> index bba1cb0..0290ade 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h
>> @@ -190,7 +190,7 @@ i40e_add_queue_stats(u64 **data, struct i40e_ring *ring)
>>   * Format and copy the strings described by stats into the buffer pointed at
>>   * by p.
>>   **/
>> -static inline void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
>> +static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
>>  				    const unsigned int size, ...)
>>  {
>>  	unsigned int i;
> 
>    You now need to move this function to a .c file and leave here only its prototype.

Thanks, will send v2.

> 
> MBR, Sergei
> 
> .
> 

