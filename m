From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 10 Dec 2021 16:41:32 -0800
Subject: [Intel-wired-lan] [PATCH] igc: Avoid possible deadlock during
 suspend/resume
In-Reply-To: <d4c9bb101aa79c5acaaa6dd7b42159fb0c91a341.camel@gmx.de>
References: <87r1awtdx3.fsf@intel.com>
 <20211201185731.236130-1-vinicius.gomes@intel.com>
 <5a4b31d43d9bf32e518188f3ef84c433df3a18b1.camel@gmx.de>
 <87o85yljpu.fsf@intel.com>
 <063995d8-acf3-9f33-5667-f284233c94b4@leemhuis.info>
 <8e59b7d6b5d4674d5843bb45dde89e9881d0c741.camel@gmx.de>
 <5c5b606a-4694-be1b-0d4b-80aad1999bd9@leemhuis.info>
 <d4c9bb101aa79c5acaaa6dd7b42159fb0c91a341.camel@gmx.de>
Message-ID: <87h7bgrn0j.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Stefan,

Stefan Dietrich <roots@gmx.de> writes:

> Agreed and thanks for the pointers; please see the log files and
> .config attached as requested.
>

Thanks for the logs.

Very interesting that the initialization of the device is fine, so it's
something that happens later.

Can you test the attached patch?

If the patch works, I would also be interested if you notice any loss of
functionality with your NIC. (I wouldn't think so, as far as I know,
i225-V models have PTM support but don't have any PTP support).

>
> Cheers,
> Stefan
>
>
> On Fri, 2021-12-10 at 15:01 +0100, Thorsten Leemhuis wrote:
>> On 10.12.21 14:45, Stefan Dietrich wrote:
>> > thanks for keeping an eye on the issue. I've sent the files in
>> > private
>> > because I did not want to spam the mailing lists with them. Please
>> > let
>> > me know if this is the correct procedure.
>>

Cheers,
-- 
Vinicius

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-igc-Do-not-enable-crosstimestamping-for-i225-V-model.patch
Type: text/x-patch
Size: 1164 bytes
Desc: test patch for deadlock in igc
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20211210/e0ce035c/attachment.bin>
