From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Thu, 16 Aug 2018 09:35:03 +0300
Subject: [Intel-wired-lan] [PATCH v5 05/11] igc: Add support for Tx/Rx
 rings
In-Reply-To: <e34da823689c32156285b98375445b45d353f068.camel@intel.com>
References: <1534345347-5578-1-git-send-email-sasha.neftin@intel.com>
 <e34da823689c32156285b98375445b45d353f068.camel@intel.com>
Message-ID: <044bf5d6-fcb2-3ebe-b860-0f7bce80f901@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/15/2018 19:20, Jeff Kirsher wrote:
> On Wed, 2018-08-15 at 18:02 +0300, Sasha Neftin wrote:
>> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h
>> b/drivers/net/ethernet/intel/igc/igc_defines.h
>> index 1ce997a..f9d1842 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
>> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
>> @@ -28,13 +28,13 @@
>>   #define IGC_RAH_POOL_1         0x00040000
>>   
>>   /* Error Codes */
>> -#define IGC_SUCCESS                            0
>> -#define IGC_ERR_NVM                            1
>> -#define IGC_ERR_PHY                            2
>> -#define IGC_ERR_CONFIG                         3
>> -#define IGC_ERR_PARAM                          4
>> -#define IGC_ERR_MAC_INIT                       5
>> -#define IGC_ERR_RESET                          9
>> +#define IGC_SUCCESS                    0
>> +#define IGC_ERR_NVM                    1
>> +#define IGC_ERR_PHY                    2
>> +#define IGC_ERR_CONFIG                 3
>> +#define IGC_ERR_PARAM                  4
>> +#define IGC_ERR_MAC_INIT               5
>> +#define IGC_ERR_RESET                  9
> 
> This change in indentation should be in patch 2, when the code was
> first introduced.
> 
Fix will be applied in next version.
