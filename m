From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Wed, 10 Jun 2020 10:18:50 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Refactor the
 igc_power_up_link()
In-Reply-To: <a7d7a8c2-2ad1-2ac4-dc7c-e8237a34739c@molgen.mpg.de>
References: <20200610061227.3315-1-sasha.neftin@intel.com>
 <a7d7a8c2-2ad1-2ac4-dc7c-e8237a34739c@molgen.mpg.de>
Message-ID: <975fc37e-80c6-957f-a6c0-8edba4f80a5c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/10/2020 09:22, Paul Menzel wrote:
> Dear Sasha,
> 
> 
> Thank you for the patch.
> 
> Am 10.06.20 um 08:12 schrieb Sasha Neftin:
>> PHY of the i225 device support only copper mode.
>> There is no point to check media type in the
>> igc_power_up_link() method.
> 
> One nit regarding the commit message summary. *Refactor* very generic. 
> Could you use something like:
> 
>  > igc: Remove unneeded check for copper media type
Paul, thanks for reviewing this patch. I will send v2.
> 
>> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
>> ---
>> ? drivers/net/ethernet/intel/igc/igc_main.c | 3 +--
>> ? 1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c 
>> b/drivers/net/ethernet/intel/igc/igc_main.c
>> index af5e1686f7f2..83c94fa58c40 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -115,8 +115,7 @@ static void igc_power_up_link(struct igc_adapter 
>> *adapter)
>> ? {
>> ????? igc_reset_phy(&adapter->hw);
>> -??? if (adapter->hw.phy.media_type == igc_media_type_copper)
>> -??????? igc_power_up_phy_copper(&adapter->hw);
>> +??? igc_power_up_phy_copper(&adapter->hw);
>> ????? igc_setup_link(&adapter->hw);
>> ? }
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul

