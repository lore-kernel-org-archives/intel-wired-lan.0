From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 15 Dec 2020 13:26:27 +0100
Subject: [Intel-wired-lan] [PATCH v4 0/4] Improve s0ix flows for systems
 i219LM
In-Reply-To: <MN2PR19MB26376EA92CE14DC3ADD328BEFAC70@MN2PR19MB2637.namprd19.prod.outlook.com>
References: <20201214153450.874339-1-mario.limonciello@dell.com>
 <80862f70-18a4-4f96-1b96-e2fad7cc2b35@redhat.com>
 <MN2PR19MB26376EA92CE14DC3ADD328BEFAC70@MN2PR19MB2637.namprd19.prod.outlook.com>
Message-ID: <1f68c6a4-3dcf-47fa-d3c2-679d1f7c4823@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

On 12/14/20 8:36 PM, Limonciello, Mario wrote:
>> Hi All,
>>
>> Sasha (and the other intel-wired-lan folks), thank you for investigating this
>> further and for coming up with a better solution.
>>
>> Mario, thank you for implementing the new scheme.
>>
> 
> Sure.
> 
>> I've tested this patch set on a Lenovo X1C8 with vPRO and AMT enabled in the
>> BIOS
>> (the previous issues were soon on a X1C7).
>>
>> I have good and bad news:
>>
>> The good news is that after reverting the
>> "e1000e: disable s0ix entry and exit flows for ME systems"
>> I can reproduce the original issue on the X1C8 (I no longer have
>> a X1C7 to test on).
>>
>> The bad news is that increasing the timeout to 1 second does
>> not fix the issue. Suspend/resume is still broken after one
>> suspend/resume cycle, as described in the original bug-report:
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1865570
>>
>> More good news though, bumping the timeout to 250 poll iterations
>> (approx 2.5 seconds) as done in Aaron Ma's original patch for
>> this fixes this on the X1C8 just as it did on the X1C7
>> (it takes 2 seconds for ULP_CONFIG_DONE to clear).
>>
>> I've ran some extra tests and the poll loop succeeds on its
>> first iteration when an ethernet-cable is connected. It seems
>> that Lenovo's variant of the ME firmware waits up to 2 seconds
>> for a link, causing the long wait for ULP_CONFIG_DONE to clear.
>>
>> I think that for now the best fix would be to increase the timeout
>> to 2.5 seconds as done in  Aaron Ma's original patch. Combined
>> with a broken-firmware warning when we waited longer then 1 second,
>> to make it clear that there is a firmware issue here and that
>> the long wait / slow resume is not the fault of the driver.
>>
> 
> OK.  I've submitted v5 with this suggestion.
> 
>> ###
>>
>> I've added Mark Pearson from Lenovo to the Cc so that Lenovo
>> can investigate this issue further.
>>
>> Mark, this thread is about an issue with enabling S0ix support for
>> e1000e (i219lm) controllers. This was enabled in the kernel a
>> while ago, but then got disabled again on vPro / AMT enabled
>> systems because on some systems (Lenovo X1C7 and now also X1C8)
>> this lead to suspend/resume issues.
>>
>> When AMT is active then there is a handover handshake for the
>> OS to get access to the ethernet controller from the ME. The
>> Intel folks have checked and the Windows driver is using a timeout
>> of 1 second for this handshake, yet on Lenovo systems this is
>> taking 2 seconds. This likely has something to do with the
>> ME firmware on these Lenovo models, can you get the firmware
>> team at Lenovo to investigate this further ?
>>
> 
> Please be very careful with nomenclature.  AMT active, or AMT capable?
> The goal for this series is to support AMT capable systems with an i219LM
> where AMT has not been provisioned by the end user or organization.
> OEMs do not ship systems with AMD provisioned.

Ah, sorry about that. What I meant with "active" is set to "Enabled"
in the BIOS.

Also FWIW I just tried disabling AMT in the BIOS (using the "Disabled"
option, not the "Permanently Disabled" option) on the Lenovo X1 Carbon
8th gen, but that does not make a difference.

It still takes 2 seconds for ULP_CONFIG_DONE to clear even with AMT
set to "Disabled" in the BIOS :|

Regards,

Hans


