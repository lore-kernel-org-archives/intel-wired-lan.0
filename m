From: Thorsten Leemhuis <regressions@leemhuis.info>
Date: Thu, 23 Dec 2021 08:21:45 +0100
Subject: [Intel-wired-lan] [PATCH net v1] igc: Do not enable
 crosstimestamping for i225-V models
In-Reply-To: <28922ca0-8513-c804-7f1d-bcce30147b68@leemhuis.info>
References: <87wnk8qrt8.fsf@intel.com>
 <20211214003949.666642-1-vinicius.gomes@intel.com>
 <28922ca0-8513-c804-7f1d-bcce30147b68@leemhuis.info>
Message-ID: <4d1aad6b-8470-c834-6b4c-df6490cf7ab6@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi, this is your Linux kernel regression tracker speaking.

Sorry for pestering here as well, but the issue is similar to the
regression fix for the igb problem we already discussed earlier this week.

Long story short: below patch fixes another regression that made it into
5.15 that in fact leads to similar symptoms then those fixed by the
aforementioned igb issue. I saw another user reporting the problem
today, so I'd like to see this patch heading towards mainline soon as
well, unless there are good reasons to wait. The patch for a few days is
now in
https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git/log/?h=dev-queue
, but not yet in master or linux-next afaics.

Ciao, Thorsten (wearing his 'Linux kernel regression tracker' hat).

P.S.: As a Linux kernel regression tracker I'm getting a lot of reports
on my table. I can only look briefly into most of them. Unfortunately
therefore I sometimes will get things wrong or miss something important.
I hope that's not the case here; if you think it is, don't hesitate to
tell me about it in a public reply. That's in everyone's interest, as
what I wrote above might be misleading to everyone reading this; any
suggestion I gave thus might sent someone reading this down the wrong
rabbit hole, which none of us wants.

BTW, I have no personal interest in this issue, which is tracked using
regzbot, my Linux kernel regression tracking bot
(https://linux-regtracking.leemhuis.info/regzbot/). I'm only posting
this mail to get things rolling again and hence don't need to be CC on
all further activities wrt to this regression.

On 14.12.21 06:49, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker speaking.
> 
> Thx for working on this. Two small details:
> 
> On 14.12.21 01:39, Vinicius Costa Gomes wrote:
>> It was reported that when PCIe PTM is enabled, some lockups could
>> be observed with some integrated i225-V models.
>>
>> While the issue is investigated, we can disable crosstimestamp for
>> those models and see no loss of functionality, because those models
>> don't have any support for time synchronization.
>>
>> Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
> 
> That commit is in 5.15 (and Stefan is facing the problem there), hence
> to make backporting explicit it's afaics better to add this line :
> 
> Cc: stable at vger.kernel.org #5.15
> 
>> Link: https://lore.kernel.org/all/924175a188159f4e03bd69908a91e606b574139b.camel at gmx.de/
> 
> Nitpicking: not sure if it's really important for anything, but to get
> the proper format you afaik should do a s!/all/!/r/! to that line.
> 
> Ciao, Thorsten
> 
>> Reported-by: Stefan Dietrich <roots@gmx.de>
>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> ---
>>  drivers/net/ethernet/intel/igc/igc_ptp.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
>> index 30568e3544cd..4f9245aa79a1 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_ptp.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
>> @@ -768,7 +768,20 @@ int igc_ptp_get_ts_config(struct net_device *netdev, struct ifreq *ifr)
>>   */
>>  static bool igc_is_crosststamp_supported(struct igc_adapter *adapter)
>>  {
>> -	return IS_ENABLED(CONFIG_X86_TSC) ? pcie_ptm_enabled(adapter->pdev) : false;
>> +	if (!IS_ENABLED(CONFIG_X86_TSC))
>> +		return false;
>> +
>> +	/* FIXME: it was noticed that enabling support for PCIe PTM in
>> +	 * some i225-V models could cause lockups when bringing the
>> +	 * interface up/down. There should be no downsides to
>> +	 * disabling crosstimestamping support for i225-V, as it
>> +	 * doesn't have any PTP support. That way we gain some time
>> +	 * while root causing the issue.
>> +	 */
>> +	if (adapter->pdev->device == IGC_DEV_ID_I225_V)
>> +		return false;
>> +
>> +	return pcie_ptm_enabled(adapter->pdev);
>>  }
>>  
>>  static struct system_counterval_t igc_device_tstamp_to_system(u64 tstamp)
>>
