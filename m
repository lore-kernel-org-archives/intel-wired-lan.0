From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Fri, 19 Jul 2019 13:29:44 +0200
Subject: [Intel-wired-lan] [PATCH v3] e1000e: PCIm function state support
In-Reply-To: <4e7e40a2-9a9e-5c4e-fb69-6d2806e0eefd@intel.com>
References: <20190625143911.37284-1-vitaly.lifshits@intel.com>
 <9e661c44-4547-58a1-fc90-64132eda2e80@molgen.mpg.de>
 <4e7e40a2-9a9e-5c4e-fb69-6d2806e0eefd@intel.com>
Message-ID: <d2240daa-ede0-46ef-6eb7-e5c9754344ae@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Vitaly,


I am adding the list back, so that the Linux kernel experts can
chime and correct my answers/suggestions.


On 7/16/19 1:28 PM, Lifshits, Vitaly wrote:
> On 6/28/2019 11:57, Paul Menzel wrote:

>> On 06/25/19 16:39, Vitaly Lifshits wrote:
>>> Due to commit: 5d8682588605 ("[misc] mei: me: allow runtime
>>> ??????????? pm for platform with D0i3")
>> Do not indent it but integrate it into the line.
>>
>>> When disconnecting the cable and reconnecting it the NIC
>> s/When/when/
>>
>>> enters DMoff state. This caused wrong link indication
>>> and duplex mismatch. This bug is described in:
>>> https://bugzilla.redhat.com/show_bug.cgi?id=1689436
>> Isn?t there a tag Link: or Bugzilla: to mention these URLs?
>> Maybe add it below? (See `git log --grep bugzilla` for how this
>> is used.)
>>
>>> Checking PCIm function state and performing PHY reset after a
>>> timeout in watchdog task solves this issue.
>> In what data sheet is the function state described?
> PCIm function state isn't mentioned in the I219 data sheet.

It should be updated then. ;-)

> However the DMoff state (which is a pcim state) is mentioned in it.
> In I218 data sheet this state is mentioned.

Thanks. I found the data sheet.

https://datasheet.octopart.com/WGI218LM-S-LK3B-Intel-datasheet-76215422.pdf

>>> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
>>> ---
>>>
>>> V2: Fixed typos in commit massage
>>> V3: Fixed minor typo
>>> ---
>>> ? drivers/net/ethernet/intel/e1000e/defines.h |? 3 +++
>>> ? drivers/net/ethernet/intel/e1000e/netdev.c? | 18 +++++++++++++++++-
>>> ? 2 files changed, 20 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/ethernet/intel/e1000e/defines.h
>>> index fd550dee4982..13877fe300f1 100644
>>> --- a/drivers/net/ethernet/intel/e1000e/defines.h
>>> +++ b/drivers/net/ethernet/intel/e1000e/defines.h
>>> @@ -222,6 +222,9 @@
>>> ? #define E1000_STATUS_PHYRA????? 0x00000400????? /* PHY Reset Asserted */
>>> ? #define E1000_STATUS_GIO_MASTER_ENABLE??? 0x00080000??? /* Master Req status */
>>> ? +/* PCIm function state */
>>> +#define E1000_STATUS_PCIM_STATE???????? 0x40000000
>> Shouldn?t the name be something E1000_STATUS_PCIM_STATE_DMOFF?
> This bit indicates the pcim state if it is set then the device is in
> DMoff state.

Indeed. Shouldn?t the macro name be changed to my suggestion to better
describe it?s meaning?

>>> +
>>> ? #define HALF_DUPLEX 1
>>> ? #define FULL_DUPLEX 2
>>> ? diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
>>> index b081a1ef6859..c6a10fd30e4e 100644
>>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>>> @@ -5173,8 +5173,9 @@ static void e1000_watchdog_task(struct work_struct *work)
>>> ????? struct e1000_mac_info *mac = &adapter->hw.mac;
>>> ????? struct e1000_phy_info *phy = &adapter->hw.phy;
>>> ????? struct e1000_ring *tx_ring = adapter->tx_ring;
>>> +??? u32 dmoff_exit_timeout = 100, tries = 0;
>> Shouldn?t a macro be used for the time-out value?
> Just to make sure I understand you correctly, did you mean that I
> should set a defined value like DMOFF_EXIT_TIMEOUT 100?

Yes, that is what I meant. But I am no C or Linux expert, so I do not
know, if macros are wanted seeing that they do not have a type.

If you go with a C variable, it should be `unsigned int` and `const`?
I heard enums are an alternative to macros.

>>> ????? struct e1000_hw *hw = &adapter->hw;
>>> -??? u32 link, tctl;
>>> +??? u32 link, tctl, pcim_state;
>>> ? ????? if (test_bit(__E1000_DOWN, &adapter->state))
>>> ????????? return;
>>> @@ -5199,6 +5200,21 @@ static void e1000_watchdog_task(struct work_struct *work)
>>> ????????????? /* Cancel scheduled suspend requests. */
>>> ????????????? pm_runtime_resume(netdev->dev.parent);
>>> ? +??????????? /* Checking if MAC is in DMoff state*/
>>> +??????????? pcim_state = er32(STATUS);
>>> +??????????? while (pcim_state & E1000_STATUS_PCIM_STATE) {
>>> +??????????????? if (tries++ == dmoff_exit_timeout) {
>>> +??????????????????? e_dbg("Error in exiting dmoff\n");
>> Shouldn?t this be a user visible error message? If so, please elaborate and
>> mention the time-out.
>>
>>> Couldn?t exit DMoff after %i s. Your card might not work correctly,
>>> TIMEOUTMACRONAME
>>> +??????????????????? break;
>>> +??????????????? }
>>> +??????????????? usleep_range(10000, 20000);
>>> +??????????????? pcim_state = er32(STATUS);
>>> +
>>> +??????????????? /* Checking if MAC exited DMoff state */
>>> +??????????????? if (!(pcim_state & E1000_STATUS_PCIM_STATE))
>> If the macro name is more specific, the comment could be removed. If not,
>> the comment should use imperative mood (as below): Check if ?.
>>
>> Also can the while loop and if condition be refactored, as the condition
>> check if the same?
> The thing is that I don't want to perform phy_hw_reset if the device wasn't in this state at all.
> Does removing the if from here and using another one after the loop is a good solution for this?
> (By using tries variable)

If the if statement condition `!(pcim_state & E1000_STATUS_PCIM_STATE)` is
true, then the while loop condition is false, right? So the if statement can
at least be moved *outside* the loop (the compiler probably does it already).

Couldn?t you write it like below?

1.  do-while-loop: Saves one `pcim_state` assignment, but has a mandatory
    delay of `usleep_range`.

        do {
                if (tries++ == dmoff_exit_timeout) {
                        e_dbg("Error in exiting dmoff\n");
                        break;
                }
    
                pcim_state = er32(STATUS);
                usleep_range(10000, 20000);
        } while (pcim_state & E1000_STATUS_PCIM_STATE)
    
        if (!(pcim_state & E1000_STATUS_PCIM_STATE))
                e1000_phy_hw_reset(&adapter->hw);

2.  while-loop: Has an additional pcim_state assignment before the loop.

        pcim_state = er32(STATUS);
        while (pcim_state & E1000_STATUS_PCIM_STATE) {
                if (tries++ == dmoff_exit_timeout) {
                        e_dbg("Error in exiting dmoff\n");
                        break;
                }
        
                pcim_state = er32(STATUS);
                usleep_range(10000, 20000);
        }
        
        if (!(pcim_state & E1000_STATUS_PCIM_STATE))
                e1000_phy_hw_reset(&adapter->hw);

(I used your macro name. Should you decide to update it, it needs to
be updated of course.)

>>> +??????????????????? e1000_phy_hw_reset(&adapter->hw);
>>> +??????????? }
>>> +
>>> ????????????? /* update snapshot of PHY registers on LSC */
>>> ????????????? e1000_phy_read_status(adapter);
>>> ????????????? mac->ops.get_link_up_info(&adapter->hw,


Kind regards,

Paul

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5174 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190719/b95368c7/attachment-0001.p7s>
