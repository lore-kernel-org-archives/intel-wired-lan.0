From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Thu, 16 Aug 2018 10:44:12 +0300
Subject: [Intel-wired-lan] [PATCH v5 06/11] igc: Add transmit and
 receive fastpath and interrupt handlers
In-Reply-To: <ae8e4483436d33a01794d1520bab56b952088ee9.camel@intel.com>
References: <1534345350-5628-1-git-send-email-sasha.neftin@intel.com>
 <ae8e4483436d33a01794d1520bab56b952088ee9.camel@intel.com>
Message-ID: <4aa735e8-f29d-2a67-33dc-4e0cb0ce3528@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/15/2018 19:25, Jeff Kirsher wrote:
> On Wed, 2018-08-15 at 18:02 +0300, Sasha Neftin wrote:
>> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h
>> b/drivers/net/ethernet/intel/igc/igc_defines.h
>> index f9d1842..8f0ce02 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
>> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
>> @@ -78,7 +78,7 @@
>>   #define IGC_IMS_DOUTSYNC       IGC_ICR_DOUTSYNC /* NIC DMA out of
>> sync */
>>   #define IGC_IMS_DRSTA          IGC_ICR_DRSTA   /* Device Reset
>> Asserted */
>>   #define IGC_IMS_RXT0           IGC_ICR_RXT0    /* Rx timer intr */
>> -#define IGC_IMS_RXDMT0         IGC_ICR_RXDMT0  /* Rx desc min.
>> threshold */
>> +#define IGC_IMS_RXDMT0         IGC_ICR_RXDMT0  /* Rx desc min.
>> threshold */
> 
> This fix to replace a tab with spaces should be in patch 4, where this
> code was introduced.
> 
fix will applied in v6.
