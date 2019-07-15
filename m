From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Mon, 15 Jul 2019 11:06:04 +0200
Subject: [Intel-wired-lan] [PATCH] e1000e: Make speed detection on
 hotplugging cable more reliable
In-Reply-To: <F9859C57-4F6D-4685-B4B6-D1D7DCB50D27@canonical.com>
References: <20190715084355.9962-1-kai.heng.feng@canonical.com>
 <017771d5-f168-493a-46a1-88e513941ba1@molgen.mpg.de>
 <F9859C57-4F6D-4685-B4B6-D1D7DCB50D27@canonical.com>
Message-ID: <37a1e2af-64c6-4515-5dcc-6051e1192636@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Kai Heng,


(with or without hyphen?)

On 7/15/19 11:00 AM, Kai Heng Feng wrote:
> at 4:52 PM, Paul Menzel <pmenzel@molgen.mpg.de> wrote:

>> On 7/15/19 10:43 AM, Kai-Heng Feng wrote:
>>> After hotplugging an 1Gbps ethernet cable with 1Gbps link partner, the
>>> MII_BMSR may reports 10Mbps, renders the network rather slow.
>>
>> s/may reports/may report/
>> s/renders/rendering/
> 
> Apparently English isn?t my mother tongue ;)

No problem. Mine neither.

>>> The issue has much lower fail rate after commit 59653e6497d1 ("e1000e:
>>> Make watchdog use delayed work"), which esssentially introduces some
>>
>> essentially
> 
> Ok.
> 
>>> delay before running the watchdog task.
>>>
>>> But there's still a chance that the hotplugging event and the queued
>>> watchdog task gets run at the same time, then the original issue can be
>>> observed once again.
>>>
>>> So let's use mod_delayed_work() to add a deterministic 1 second delay
>>> before running watchdog task, after an interrupt.
>>
>> I am not clear about the effects for the user. Could you elaborate
>> please? Does the link now come up up to one second later?
> 
> Yes, the link will be up on a fixed one second later.
> 
> The delay varies between 0 to 2 seconds without this patch.

Is there no other fix? Regarding booting a system fast (less than six
seconds), a fixed one second delay is quite a regression on systems where
it worked before.

>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>
>> Any bug URL?
> 
> If maintainers think it?s necessary then I?ll file one.

Not necessary, if there is none. I thought you had one in Launchpad or so.


Kind regards,

Paul

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5174 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190715/a052d88b/attachment-0001.p7s>
