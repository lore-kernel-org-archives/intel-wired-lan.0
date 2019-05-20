From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Mon, 20 May 2019 18:17:26 +0300
Subject: [Intel-wired-lan] [PATCH] e1000e: Increase pause and refresh
 time
In-Reply-To: <5507809f-b2f1-429a-64a7-e59d60c76a4a@intel.com>
References: <d185164e-d09f-39ab-74f0-0c483ab52e67@molgen.mpg.de>
 <5507809f-b2f1-429a-64a7-e59d60c76a4a@intel.com>
Message-ID: <91202837-19cf-21c8-eadf-a1e2e90849c4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 5/20/2019 09:08, Neftin, Sasha wrote:
> On 5/17/2019 18:01, Paul Menzel wrote:
>> From: Miguel Bernal Marin <miguel.bernal.marin@linux.intel.com>
>> Date: Mon, 27 Mar 2017 16:01:56 -0600
>>
>> Suggested-by: Tim Pepper <timothy.c.pepper@linux.intel.com>
>> Signed-off-by: Miguel Bernal Marin <miguel.bernal.marin@linux.intel.com>
>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>> ---
>> Miguel, it?d be great, if you could write a commit message stating the 
>> motivation for that change, that means, why is it preferable to 
>> increase these values, and set the pause time unconditionally.
>>
>> ??drivers/net/ethernet/intel/e1000e/netdev.c | 4 ++--
>> ??1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c 
>> b/drivers/net/ethernet/intel/e1000e/netdev.c
>> index ce4aaa9f2163..597d3ca19555 100644
>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>> @@ -4047,12 +4047,12 @@ void e1000e_reset(struct e1000_adapter *adapter)
>> ????? case e1000_pch_lpt:
>> ????? case e1000_pch_spt:
>> ????? case e1000_pch_cnp:
>> -??????? fc->refresh_time = 0x0400;
>> +??????? fc->refresh_time = 0xFFFF;
>> +??????? fc->pause_time = 0xFFFF;
>>
>> ????????? if (adapter->netdev->mtu <= ETH_DATA_LEN) {
>> ????????????? fc->high_water = 0x05C20;
>> ????????????? fc->low_water = 0x05048;
>> -??????????? fc->pause_time = 0x0650;
>> ????????????? break;
>> ????????? }
>>
> I am good with this patch.
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
Acked-by: Sasha Neftin <sasha.neftin@intel.com>
