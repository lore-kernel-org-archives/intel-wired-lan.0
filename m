From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 3 May 2022 08:26:25 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] e1000e: Enable the GPT clock
 before sending message to the CSME
In-Reply-To: <e0c98a14-db37-25bf-0993-efa3893cd4d3@intel.com>
References: <20220502131556.349753-1-sasha.neftin@intel.com>
 <1dc52831-b539-1add-c966-53e415ad7f04@molgen.mpg.de>
 <e0c98a14-db37-25bf-0993-efa3893cd4d3@intel.com>
Message-ID: <8bf04198-7bad-d5b9-598a-2011b42ac107@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Sasha,


Am 03.05.22 um 05:14 schrieb Neftin, Sasha:
> On 5/2/2022 18:51, Paul Menzel wrote:

>> Am 02.05.22 um 15:15 schrieb Sasha Neftin:
>>
>> You could remove the articles *the* from the summary to make it shorter.

As you acked all the other comments, I just want to make sure, you saw 
this one.

>>> Enable the dynamic GPT clock. The clock is always ticking is the 
>>> guarantee
>>> CSME receive the H2ME message and exit from the DMoff state.
>>> This clock cleared upon HW initialization (D3 -> D0 transition).
>>
>> Please do not break the line, just because a sentence ends.
>>
>> *is* cleared?
> ok.
>>
>> Please start the commit message by describing the problem, and also 
>> give instructions how to reproduce it.
> please, refer to the link below (bugzilla)

I saw that but no, as always commit messages need to contain the 
motivation and also need to be some kind of self-contained. Reviewers 
can *not* be expected to read through several comments in a bug report, 
and people looking at a commit are not always online, and Web service 
are not always online. So, a summary of the issue should be provided.

>>> Fixes: 3e55d231716e ("e1000e: Add handshake with the CSME to support s0ix")

The bug report also does not mention anything about a regression. Did it 
never work?

>>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=214821
>>> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
>>> ---
>>> ? drivers/net/ethernet/intel/e1000e/netdev.c | 4 ++++
>>> ? 1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c 
>>> b/drivers/net/ethernet/intel/e1000e/netdev.c
>>> index fa06f68c8c80..e29a718469ee 100644
>>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>>> @@ -6494,6 +6494,10 @@ static void e1000e_s0ix_exit_flow(struct 
>>> e1000_adapter *adapter)
>>> ????? if (er32(FWSM) & E1000_ICH_FWSM_FW_VALID &&
>>> ????????? hw->mac.type >= e1000_pch_adp) {
>>> +??????? /* Keep the gpt_clk_enable_d clock for CSME*/
>>
>> Missing space before the closing */.
> Thanks - will fix in v2
>>
>> Why is `gpt_clk_enable_d` spelled that way?
> I took it from HW design. I will spell it as 'GPT clock' (more clearly).
>>
>>> +??????? mac_data = er32(FEXTNVM);
>>> +??????? mac_data |= BIT(3);
>>> +??????? ew32(FEXTNVM, mac_data);
>>> ????????? /* Request ME unconfigure the device from S0ix */
>>> ????????? mac_data = er32(H2ME);
>>> ????????? mac_data &= ~E1000_H2ME_START_DPG;


Kind regards,

Paul
