From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 20 Mar 2019 15:52:11 +0800
Subject: [Intel-wired-lan] [PATCH net-next] igc: Make
 igc_write_rss_indir_tbl static
In-Reply-To: <92371ea1-e9d7-e0b1-1c7a-a374f3c68681@intel.com>
References: <20190319145507.22388-1-yuehaibing@huawei.com>
 <92371ea1-e9d7-e0b1-1c7a-a374f3c68681@intel.com>
Message-ID: <84a273b4-a971-7835-1d79-4cad3fb4733a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 2019/3/20 15:07, Neftin, Sasha wrote:
> On 3/19/2019 16:55, Yue Haibing wrote:
>> From: YueHaibing <yuehaibing@huawei.com>
>>
>> Fix sparse warning:
>>
>> drivers/net/ethernet/intel/igc/igc_ethtool.c:646:6:
>>   warning: symbol 'igc_write_rss_indir_tbl' was not declared. Should it be static?
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> index eff37a6..5442394 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> @@ -643,7 +643,7 @@ static int igc_set_coalesce(struct net_device *netdev,
>>       return 0;
>>   }
>>   -void igc_write_rss_indir_tbl(struct igc_adapter *adapter)
>> +static void igc_write_rss_indir_tbl(struct igc_adapter *adapter)
>>   {
>>       struct igc_hw *hw = &adapter->hw;
>>       u32 reg = IGC_RETA(0);
>>
> The 'igc_write_rss_indir_tbl' method is declared in igc.h and used in igc_main.c
> Please, refer to latest Jeff next-queue, there is latest patches used these methods.

Well, I did not refer to Jeff's tree. So this patch can be dropped.

Thanks!

> 
> .
> 

