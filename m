From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Sun, 26 Jan 2020 09:50:39 +0200
Subject: [Intel-wired-lan] [PATCH v3] e1000e: Add support for Alder Lake
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B971CC502@ORSMSX103.amr.corp.intel.com>
References: <20200119115713.12710-1-sasha.neftin@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B971CC502@ORSMSX103.amr.corp.intel.com>
Message-ID: <835b1769-42e3-f8f2-fc5f-ed811328e3e2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 1/25/2020 04:50, Brown, Aaron F wrote:
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>> Sasha Neftin
>> Sent: Sunday, January 19, 2020 3:57 AM
>> To: intel-wired-lan at lists.osuosl.org
>> Subject: [Intel-wired-lan] [PATCH v3] e1000e: Add support for Alder Lake
>>
>> Add devices ID's for the next LOM generations that will be
>> available on the next Intel Client platform (Alder Lake)
>> This patch provides the initial support for these devices
>>
>> v1->v2:
>> Address community comments
>> v2->v3:
>> Fix minor typo
>>
>> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
>> ---
>>   drivers/net/ethernet/intel/e1000e/ethtool.c | 2 ++
>>   drivers/net/ethernet/intel/e1000e/hw.h      | 5 +++++
>>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 7 +++++++
>>   drivers/net/ethernet/intel/e1000e/netdev.c  | 6 ++++++
>>   drivers/net/ethernet/intel/e1000e/ptp.c     | 1 +
>>   5 files changed, 21 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c
>> b/drivers/net/ethernet/intel/e1000e/ethtool.c
>> index adce7e319b9e..9e7881db7859 100644
>> --- a/drivers/net/ethernet/intel/e1000e/ethtool.c
>> +++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
>> @@ -897,6 +897,7 @@ static int e1000_reg_test(struct e1000_adapter
>> *adapter, u64 *data)
>>   	case e1000_pch_cnp:
>>   		/* fall through */
>>   	case e1000_pch_tgp:
>> +	case e1000_pch_adp:
>>   		mask |= BIT(18);
>>   		break;
>>   	default:
>> @@ -1561,6 +1562,7 @@ static void e1000_loopback_cleanup(struct
>> e1000_adapter *adapter)
>>   	case e1000_pch_spt:
>>   	case e1000_pch_cnp:
>>   	case e1000_pch_tgp:
>> +	case e1000_pch_adp:
>>   		fext_nvm11 = er32(FEXTNVM11);
>>   		fext_nvm11 &= ~E1000_FEXTNVM11_DISABLE_MULR_FIX;
>>   		ew32(FEXTNVM11, fext_nvm11);
>> diff --git a/drivers/net/ethernet/intel/e1000e/hw.h
>> b/drivers/net/ethernet/intel/e1000e/hw.h
>> index f556163481cb..a1dbf8df1c70 100644
>> --- a/drivers/net/ethernet/intel/e1000e/hw.h
>> +++ b/drivers/net/ethernet/intel/e1000e/hw.h
>> @@ -97,6 +97,10 @@ struct e1000_hw;
>>   #define E1000_DEV_ID_PCH_TGP_I219_LM14		0x15F9
>>   #define E1000_DEV_ID_PCH_TGP_I219_V14		0x15FA
>>   #define E1000_DEV_ID_PCH_TGP_I219_LM15		0x15F4
>> +#define E1000_DEV_ID_PCH_ADP_1219_LM16		0x1A1E
>> +#define E1000_DEV_ID_PCH_ADP_1219_V16		0x1A1F
>> +#define E1000_DEV_ID_PCH_ADP_1219_LM17		0x1A1C
>> +#define E1000_DEV_ID_PCH_ADP_1219_V17		0x1A1D
> 
> Something seems to be missing.  After building and booting to the kernel with this patch included I do not see the a 1a1e, 1a1f, 1a1c or 1a1d device from modinfo:
> u1519:[1]/usr/src/kernels/next-queue> modinfo igc|grep -i 1a1
> u1519:[1]/usr/src/kernels/next-queue>
> 
you might run run modinfo e1000e | grep -i 0x1a1*
