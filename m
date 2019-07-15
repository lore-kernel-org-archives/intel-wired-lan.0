From: Kai Heng Feng <kai.heng.feng@canonical.com>
Date: Mon, 15 Jul 2019 17:00:58 +0800
Subject: [Intel-wired-lan] [PATCH] e1000e: Make speed detection on
 hotplugging cable more reliable
In-Reply-To: <017771d5-f168-493a-46a1-88e513941ba1@molgen.mpg.de>
References: <20190715084355.9962-1-kai.heng.feng@canonical.com>
 <017771d5-f168-493a-46a1-88e513941ba1@molgen.mpg.de>
Message-ID: <F9859C57-4F6D-4685-B4B6-D1D7DCB50D27@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

at 4:52 PM, Paul Menzel <pmenzel@molgen.mpg.de> wrote:

> Dear Kai-Heng,
>
>
> Thank you for the patch.
>
> On 7/15/19 10:43 AM, Kai-Heng Feng wrote:
>> After hotplugging an 1Gbps ethernet cable with 1Gbps link partner, the
>> MII_BMSR may reports 10Mbps, renders the network rather slow.
>
> s/may reports/may report/
> s/renders/rendering/

Apparently English isn?t my mother tongue ;)

>
>> The issue has much lower fail rate after commit 59653e6497d1 ("e1000e:
>> Make watchdog use delayed work"), which esssentially introduces some
>
> essentially

Ok.

>
>> delay before running the watchdog task.
>>
>> But there's still a chance that the hotplugging event and the queued
>> watchdog task gets run at the same time, then the original issue can be
>> observed once again.
>>
>> So let's use mod_delayed_work() to add a deterministic 1 second delay
>> before running watchdog task, after an interrupt.
>
> I am not clear about the effects for the user. Could you elaborate
> please? Does the link now come up up to one second later?

Yes, the link will be up on a fixed one second later.

The delay varies between 0 to 2 seconds without this patch.

>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> Any bug URL?

If maintainers think it?s necessary then I?ll file one.

Kai-Heng

>
>> ---
>>  drivers/net/ethernet/intel/e1000e/netdev.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>
>
> Kind regards,
>
> Paul


