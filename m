From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 9 Nov 2017 14:14:47 -0800
Subject: [Intel-wired-lan] [PATCH 2/3] e1000e: Alert the user that
 C-states will be disabled by enabling jumbo frames
In-Reply-To: <d1b4d8f2-d4cd-ad88-45d7-46d410179716@intel.com>
References: <20171107221332.28283-1-mattst88@gmail.com>
 <20171107221332.28283-2-mattst88@gmail.com>
 <d1b4d8f2-d4cd-ad88-45d7-46d410179716@intel.com>
Message-ID: <054c5316-c3b6-fe43-bdf5-a9fdb6ddb0f5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 11/9/2017 1:36 AM, Neftin, Sasha wrote:
> On 11/8/2017 00:13, Matt Turner wrote:
>> From: Matt Turner <matt.turner@intel.com>
>>
>> I personally spent a long time trying to decypher why my CPU would not
>> reach deeper C-states. Let's just tell the next user what's going on.
>>
>> Signed-off-by: Matt Turner <matt.turner@intel.com>
>> ---
>> ? drivers/net/ethernet/intel/e1000e/netdev.c | 3 +++
>> ? 1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c 
>> b/drivers/net/ethernet/intel/e1000e/netdev.c
>> index 286d0277284e..4dcff481c4b4 100644
>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>> @@ -3288,6 +3288,9 @@ static void e1000_configure_rx(struct 
>> e1000_adapter *adapter)
>> ????????????? ew32(RXDCTL(0), rxdctl | 0x3 | BIT(8));
>> ????????? }
>> +??????? dev_info(&adapter->pdev->dev,
>> +???????????? "Some CPU C-states have been disabled in order to "
>> +???????????? "enable jumbo frames\n");
>> ????????? pm_qos_update_request(&adapter->pm_qos_req, lat);
>> ????? } else {
>> ????????? pm_qos_update_request(&adapter->pm_qos_req,
> 
> Ack. Let's accept this comments.

But let's make that a single string, not split between lines.
sln


> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
