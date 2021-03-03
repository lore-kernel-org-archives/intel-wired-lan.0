From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Wed, 3 Mar 2021 11:26:52 +0200
Subject: [Intel-wired-lan] [PATCH net v1 2/2] igc: Fix Supported Pause
 Frame Link Setting
In-Reply-To: <ec5adf63-63d7-7e8e-f260-3eaf29ac82c3@linux.intel.com>
References: <20210219163648.14581-1-muhammad.husaini.zulkifli@intel.com>
 <20210219163648.14581-3-muhammad.husaini.zulkifli@intel.com>
 <ec5adf63-63d7-7e8e-f260-3eaf29ac82c3@linux.intel.com>
Message-ID: <81dc14b2-7aaf-9166-ab07-94e0b1e35224@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/3/2021 10:09, Dvora Fuxbrumer wrote:
> On 19/02/2021 18:36, Muhammad Husaini Zulkifli wrote:
>> The Supported Pause Frame always display "No" eventhough the Advertised
>> pause frame showing the correct setting based on the pause parameters via
>> ethtool. Set bit in link_ksettings to "Supported" for Pause Frame.
>>
>> Before output:
>> Supported pause frame use: No
>>
>> Expected output:
>> Supported pause frame use: Symmetric
>>
>> Fixes: 8c5ad0dae93c ("igc: Add ethtool support")
>> Signed-off-by: Muhammad Husaini Zulkifli 
>> <muhammad.husaini.zulkifli@intel.com>
>> Reviewed-by: Malli C <mallikarjuna.chilakala@intel.com>
>> ---
>> ? drivers/net/ethernet/intel/igc/igc_ethtool.c | 3 +++
>> ? 1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c 
>> b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> index 67a4aed45fc2..8722294ab90c 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> @@ -1711,6 +1711,9 @@ static int igc_ethtool_get_link_ksettings(struct 
>> net_device *netdev,
>> ?????????????????????????????? Autoneg);
>> ????? }
>> +??? /* Set pause flow control settings */
>> +??? ethtool_link_ksettings_add_link_mode(cmd, supported, Pause);
>> +
>> ????? switch (hw->fc.requested_mode) {
>> ????? case igc_fc_full:
>> ????????? ethtool_link_ksettings_add_link_mode(cmd, advertising, Pause);
>>
> Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
Acked-by: Sasha Neftin <sasha.neftin@intel.com>
