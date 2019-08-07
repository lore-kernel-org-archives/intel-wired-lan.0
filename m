From: Lifshits, Vitaly <vitaly.lifshits@intel.com>
Date: Wed, 7 Aug 2019 10:47:06 +0300
Subject: [Intel-wired-lan] [PATCH v4] e1000e: PCIm function state support
In-Reply-To: <8829b684-518d-2233-d618-4f1367c2dbbd@molgen.mpg.de>
References: <20190804074026.25198-1-vitaly.lifshits@intel.com>
 <8829b684-518d-2233-d618-4f1367c2dbbd@molgen.mpg.de>
Message-ID: <bc5fbdcb-6afe-dac0-b498-c5e26d539d6d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Paul,

Thank you again for your comments.
I sent a new version for my patch (V5).

On 8/4/2019 16:44, Paul Menzel wrote:
> Dear Vitaly,
>
>
> Thank you for the updated version.
>
> On 04.08.19 09:40, Vitaly Lifshits wrote:
>> Due to commit: 5d8682588605 ("[misc] mei: me: allow runtime
>> pm for platform with D0i3")
>> when disconnecting the cable and reconnecting it the NIC
>> enters DMoff state. This caused wrong link indication
>> and duplex mismatch.
>
> *and* should fit on the line above.
>
>> Checking PCIm function state and performing PHY reset after
>> exiting DMoff state in watchdog task, solves this issue.
>>
>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1689436
>> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
>> ---
>>
>> V2: Fix typos in commit message
>> V3: Fix minor typo
>> V4: Address community comments
>> ---
>> ? drivers/net/ethernet/intel/e1000e/defines.h |? 4 ++++
>> ? drivers/net/ethernet/intel/e1000e/netdev.c? | 20 +++++++++++++++++++-
>> ? 2 files changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000e/defines.h 
>> b/drivers/net/ethernet/intel/e1000e/defines.h
>> index fd550dee4982..4cff73cbd032 100644
>> --- a/drivers/net/ethernet/intel/e1000e/defines.h
>> +++ b/drivers/net/ethernet/intel/e1000e/defines.h
>> @@ -222,6 +222,10 @@
>> ? #define E1000_STATUS_PHYRA????? 0x00000400????? /* PHY Reset 
>> Asserted */
>> ? #define E1000_STATUS_GIO_MASTER_ENABLE??? 0x00080000??? /* Master 
>> Req status */
>> ? +/* PCIm function state */
>> +#define E1000_STATUS_PCIM_STATE??? 0x40000000
>> +#define PCIM_DMOFF_EXIT_TIMEOUT 100
>
> Align the values?
>
>> +
>> ? #define HALF_DUPLEX 1
>> ? #define FULL_DUPLEX 2
>> ? diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c 
>> b/drivers/net/ethernet/intel/e1000e/netdev.c
>> index b5fed6177ad6..2d29c0d0be1b 100644
>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>> @@ -5162,7 +5162,7 @@ static void e1000_watchdog_task(struct 
>> work_struct *work)
>> ????? struct e1000_phy_info *phy = &adapter->hw.phy;
>> ????? struct e1000_ring *tx_ring = adapter->tx_ring;
>> ????? struct e1000_hw *hw = &adapter->hw;
>> -??? u32 link, tctl;
>> +??? u32 link, tctl, pcim_state, tries = 0;
>> ? ????? if (test_bit(__E1000_DOWN, &adapter->state))
>> ????????? return;
>> @@ -5187,6 +5187,24 @@ static void e1000_watchdog_task(struct 
>> work_struct *work)
>> ????????????? /* Cancel scheduled suspend requests. */
>> ????????????? pm_runtime_resume(netdev->dev.parent);
>> ? +??????????? /* Checking if MAC is in DMoff state*/
>
> s/Checking/Check/
>
>> +??????????? pcim_state = er32(STATUS);
>> +??????????? while (pcim_state & E1000_STATUS_PCIM_STATE) {
>> +??????????????? if (tries++ == PCIM_DMOFF_EXIT_TIMEOUT) {
>> +??????????????????? e_dbg("Error in exiting dmoff\n");
>> +??????????????????? e_err("PCIm DMoff timeout expired\n");
>> +??????????????????? break;
>> +??????????????? }
>> +??????????????? usleep_range(10000, 20000);
>> +??????????????? pcim_state = er32(STATUS);
>> +
>> +??????????????? /* If MAC entered DMoff state, PHY reset is
>> +???????????????? * needed after exiting it
>> +???????????????? */
>> +??????????????? if (!(pcim_state & E1000_STATUS_PCIM_STATE))
>> +??????????????????? e1000_phy_hw_reset(&adapter->hw);
>
> I still believe, the if statement should be moved *outside* the loop.

The if statement has to stay in the loop since the PHY reset is needed 
only if the MAC entered DMoff state.

>
>> +??????????? }
>> +
>> ????????????? /* update snapshot of PHY registers on LSC */
>> ????????????? e1000_phy_read_status(adapter);
>> ????????????? mac->ops.get_link_up_info(&adapter->hw,
>
>
> Kind regards,
>
> Paul

Thanks,

Vitaly

