From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Sat, 17 Jul 2021 16:18:50 +0200
Subject: [Intel-wired-lan] [PATCH v1] igc: Increase timeout value for
 Speed 100/1000/2500
In-Reply-To: <BYAPR11MB2871FB77D7B3A63861724091B8109@BYAPR11MB2871.namprd11.prod.outlook.com>
References: <20210709234516.24753-1-muhammad.husaini.zulkifli@intel.com>
 <f3b716f7-7009-d291-2d12-cc0c1196b501@molgen.mpg.de>
 <BYAPR11MB2871FB77D7B3A63861724091B8109@BYAPR11MB2871.namprd11.prod.outlook.com>
Message-ID: <678b7ca1-2414-efea-0d74-76eee6f3f732@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Muhammad,


Thank you for your response.

Am 17.07.21 um 16:16 schrieb Zulkifli, Muhammad Husaini:

>> -----Original Message-----
>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>> Sent: Wednesday, July 14, 2021 2:24 PM
>> To: Zulkifli, Muhammad Husaini <muhammad.husaini.zulkifli@intel.com>
>> Cc: intel-wired-lan at osuosl.org
>> Subject: Re: [Intel-wired-lan] [PATCH v1] igc: Increase timeout value for Speed 100/1000/2500

>> Am 10.07.21 um 01:45 schrieb Muhammad Husaini Zulkifli:
>>> As the cycle time is set to maximum of 1s, the TX Hang timeout need to
>>> be increase to avoid possible TX Hangs caused by using long Qbv cycles.
>>
>> s/increase/increased/
>>
>> Do you have a way how to reproduce the issue?
>>
>>> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
>>> ---
>>>    drivers/net/ethernet/intel/igc/igc_main.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
>>> b/drivers/net/ethernet/intel/igc/igc_main.c
>>> index c8abd7fb70e5..99fb5641297d 100644
>>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>>> @@ -5322,7 +5322,9 @@ static void igc_watchdog_task(struct work_struct
>> *work)
>>>    				adapter->tx_timeout_factor = 14;
>>>    				break;
>>>    			case SPEED_100:
>>> -				/* maybe add some timeout factor ? */
>>> +			case SPEED_1000:
>>> +			case SPEED_2500:
>>> +				adapter->tx_timeout_factor = 7;
>>
>> Please mention in the commit message, how the timeout factor of 7 was
>> determined. Why not any other number.
> 
> There is no dedicated number specific in data sheet for this timeout factor.
> This time out factor was determined during the debugging  to solve the "tx hang" issues that
> we were seeing in some cases especially during Scheduled packet Transmission(etf).

Thank you for the clarification. Please mention that in the commit 
message of v2.

>>>    				break;
>>>    			}


Kind regards,

Paul
