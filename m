From: Wang, Dongsheng <dongsheng.wang@hxt-semitech.com>
Date: Fri, 7 Sep 2018 17:14:22 +0000
Subject: [Intel-wired-lan] [PATCH v3 2/2] net: ethernet: i40evf: fix
 underlying build error
References: <1536319175-3660-1-git-send-email-dongsheng.wang@hxt-semitech.com>
 <1536319175-3660-3-git-send-email-dongsheng.wang@hxt-semitech.com>
 <59fd149c-bacc-c39c-b0d8-a4fb9366f26a@cogentembedded.com>
Message-ID: <548f5b78369047b584b30b04ffed1794@HXTBJIDCEMVIW02.hxtcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 9/7/2018 11:33 PM, Sergei Shtylyov wrote:
> On 09/07/2018 02:19 PM, Wang Dongsheng wrote:
>
>> Can't have non-inline function in a header file.
>> There is a risk of "Multiple definition" from cross-including.
>>
>> Tested on: x86_64, make ARCH=i386
>>
>> Modules section .text:
>> i40e: 00019380 <__i40e_add_stat_strings>:
>> i40evf: 00006b00 <__i40e_add_stat_strings>:
>>
>> Buildin section .text:
>> i40e: c351ca60 <__i40e_add_stat_strings>:
>> i40evf: c354f2c0 <__i40e_add_stat_strings>:
>>
>> Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
>> ---
>> V3: add static 
>> ---
>>  .../intel/i40evf/i40e_ethtool_stats.h         | 23 +-----------------
>>  .../ethernet/intel/i40evf/i40evf_ethtool.c    | 24 +++++++++++++++++++
>>  2 files changed, 25 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/i40evf/i40e_ethtool_stats.h b/drivers/net/ethernet/intel/i40evf/i40e_ethtool_stats.h
>> index 60b595dd8c39..62ab67a77753 100644
>> --- a/drivers/net/ethernet/intel/i40evf/i40e_ethtool_stats.h
>> +++ b/drivers/net/ethernet/intel/i40evf/i40e_ethtool_stats.h
>> @@ -181,29 +181,8 @@ i40evf_add_queue_stats(u64 **data, struct i40e_ring *ring)
>>  	*data += size;
>>  }
>>  
>> -/**
>> - * __i40e_add_stat_strings - copy stat strings into ethtool buffer
>> - * @p: ethtool supplied buffer
>> - * @stats: stat definitions array
>> - * @size: size of the stats array
>> - *
>> - * Format and copy the strings described by stats into the buffer pointed at
>> - * by p.
>> - **/
>>  static void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
>    There's no point to keeping *static* function in the header file (unless it's
> also *inline*).

Yes? we need it for now. Because there is a copy file at i40e dir, and
a "Multiple definition" will show up when we buildin i40e&i40evf and
remove this *static* .

Cause the header file is only used  in ethtool.c so we can keep this
static, and another option is not touch this header.

As I replied to Jacob's email earlier, we can do without touch i40evf at
all. Because this header is only for one and not included in another.


Cheers,

Dongsheng

>> -				    const unsigned int size, ...)
>> -{
>> -	unsigned int i;
>> -
>> -	for (i = 0; i < size; i++) {
>> -		va_list args;
>> -
>> -		va_start(args, size);
>> -		vsnprintf(*p, ETH_GSTRING_LEN, stats[i].stat_string, args);
>> -		*p += ETH_GSTRING_LEN;
>> -		va_end(args);
>> -	}
>> -}
>> +				    const unsigned int size, ...);
>>  
>>  /**
>>   * 40e_add_stat_strings - copy stat strings into ethtool buffer
> [...]
>
> MBR, Sergei
>

