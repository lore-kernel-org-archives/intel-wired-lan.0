From: Sasha Neftin <sasha.neftin@intel.com>
Date: Thu, 15 Jul 2021 10:54:12 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] e1000e: Do not take care about
 recovery NVM checksum
In-Reply-To: <1f8b5f30-3f46-79eb-6b22-2b2e3da7a7bf@molgen.mpg.de>
References: <20210715070342.2948195-1-sasha.neftin@intel.com>
 <1f8b5f30-3f46-79eb-6b22-2b2e3da7a7bf@molgen.mpg.de>
Message-ID: <e83e4b2b-a648-cc2a-57c4-9ad56169f2f6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/15/2021 10:15, Paul Menzel wrote:
> Dear Sasha,
> 
> 
> Am 15.07.21 um 09:03 schrieb Sasha Neftin:
> 
> Please describe the problem first (lockup) (maybe by summarizing the bug 
> report).
> 
>> According to the HW De, integrated GbE sets to read-only after
> 
> Please use *developers*.
I meant: hardware design
> 
>> programming a unique MAC address. The driver should not take care of
> 
> Excuse my ignorance, who is programming the MAC address?OS vendors and PC vendors
> 
>> NVM checksum updating starting from Tiger Lake.
> 
> Who is updating the checksum? Please reference some datasheet name, 
> revision and section.
OS vendors and PC vendors
It is described in Intel RCR 1308265811 - I do not know if published 
externally. I've cc'd our front customer expert (Rex) - please, ask him 
if it published.
> 
>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=213667
>> Suggested-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
>> Suggested-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
>> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
>> ---
>> ? drivers/net/ethernet/intel/e1000e/ich8lan.c | 21 +++++++++++++--------
>> ? 1 file changed, 13 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c 
>> b/drivers/net/ethernet/intel/e1000e/ich8lan.c
>> index 9bae4932a11d..e273e14a3419 100644
>> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
>> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
>> @@ -4140,14 +4140,19 @@ static s32 
>> e1000_validate_nvm_checksum_ich8lan(struct e1000_hw *hw)
>> ????? if (ret_val)
>> ????????? return ret_val;
>> -??? if (!(data & valid_csum_mask)) {
>> -??????? data |= valid_csum_mask;
>> -??????? ret_val = e1000_write_nvm(hw, word, 1, &data);
>> -??????? if (ret_val)
>> -??????????? return ret_val;
>> -??????? ret_val = e1000e_update_nvm_checksum(hw);
>> -??????? if (ret_val)
>> -??????????? return ret_val;
>> +??? if (!(data & valid_csum_mask))
>> +??????? e_dbg("NVM Checksum Invalid\n");
> 
> I?d spell it: NVM checksum invalid
> 
> Shouldn?t this be at least a warning? It?d be good to elaborate for 
> users seeing this message. Something like: Your device might not work. 
> Please check your firmware or contact the developers.
to be consistent used same warning format as in nvm.c: ("NVM Checksum 
Invalid\n");
> 
>> +
>> +??? if (hw->mac.type < e1000_pch_cnp) {
>> +??????? if (!(data & valid_csum_mask)) {
> 
> As it?s the same check as above, I?d move this whole block into the if 
> condition above.
For old devices will performed checksum recovery.
NVM checksum validate will be processed for all.
> 
>> +??????????? data |= valid_csum_mask;
>> +??????????? ret_val = e1000_write_nvm(hw, word, 1, &data);
>> +??????????? if (ret_val)
>> +??????????????? return ret_val;
>> +??????????? ret_val = e1000e_update_nvm_checksum(hw);
>> +??????????? if (ret_val)
>> +??????????????? return ret_val;
>> +??????? }
>> ????? }
>> ????? return e1000e_validate_nvm_checksum_generic(hw);
> 
> Kind regards,
> 
> Paul
Paul,
Thanks for your comments.
sasha
