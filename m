From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Sun, 17 Feb 2019 12:59:42 +0200
Subject: [Intel-wired-lan] [PATCH net-next] igc: Make function
 igc_write_rss_indir_tbl() static
In-Reply-To: <6ef2f327-8dc6-4c86-f42d-4aa7508d19f5@intel.com>
References: <20190216020442.14206-1-weiyongjun1@huawei.com>
 <6ef2f327-8dc6-4c86-f42d-4aa7508d19f5@intel.com>
Message-ID: <a07f9ed6-b4b8-7ad2-552e-7f1288e547b2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2/17/2019 12:06, Neftin, Sasha wrote:
> On 2/16/2019 04:04, Wei Yongjun wrote:
>> Fixes the following sparse warning:
>>
>> drivers/net/ethernet/intel/igc/igc_ethtool.c:646:6: warning:
>> ? symbol 'igc_write_rss_indir_tbl' was not declared. Should it be static?
>>
>> Fixes: 8c5ad0dae93c ("igc: Add ethtool support")
>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>> ---
>> ? drivers/net/ethernet/intel/igc/igc_ethtool.c | 2 +-
>> ? 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c 
>> b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> index eff37a6c0afa..544239422577 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> @@ -643,7 +643,7 @@ static int igc_set_coalesce(struct net_device 
>> *netdev,
>> ????? return 0;
>> ? }
>> -void igc_write_rss_indir_tbl(struct igc_adapter *adapter)
>> +static void igc_write_rss_indir_tbl(struct igc_adapter *adapter)
>> ? {
>> ????? struct igc_hw *hw = &adapter->hw;
>> ????? u32 reg = IGC_RETA(0);
>>
>>
>> NACK
> 'igc_write_rss_indir_tbl' method declared in igc.h file. This method 
> used in both igc_ethtool.c and igc_main.c and can't be a 'static'
> __
please, refer to commit 429abdf0cd3c... (Add multiple receive queues 
control supporting)


_____________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

