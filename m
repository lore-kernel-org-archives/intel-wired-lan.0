From: Hisashi T Fujinaka <htodd@twofifty.com>
Date: Wed, 9 Aug 2017 14:15:50 -0700 (PDT)
Subject: [Intel-wired-lan] [regression] wake on lan no longer works in
 4.13-rc3. was Re: Linux 4.13: Reported regressions as of Sunday, 2017-08-06
In-Reply-To: <25469991.213uJSqkO8@aspire.rjw.lan>
References: <a6b015b1-a4da-c56b-89e4-629c873af4d0@leemhuis.info>
 <15027171.LoAvHuklGv@aspire.rjw.lan> <20170809064231.GA19118@amd>
 <25469991.213uJSqkO8@aspire.rjw.lan>
Message-ID: <alpine.NEB.2.21.1.1708091415010.1455@chris.i8u.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 9 Aug 2017, Rafael J. Wysocki wrote:

> [You seem to have a stale linux-pm address in your address book,
> I replaced it with the current one in the CC list.]
>
> On Wednesday, August 9, 2017 8:42:31 AM CEST Pavel Machek wrote:
>> On Wed 2017-08-09 02:45:54, Rafael J. Wysocki wrote:
>>> On Tuesday, August 8, 2017 11:00:53 AM CEST Pavel Machek wrote:
>>>> Hi!
>>>>
>>>> Perhaps you should get regressions at kernel.org alias, or something like that?
>>>>
>>>>> As always: Are you aware of any other regressions? Then please let me
>>>>> know. For details see http://bit.ly/lnxregtrackid And please tell me if
>>>>> there is anything in the report that shouldn't be there.
>>>>
>>>> I am using wake-on-lan quite a bit, and it stopped working. I'll move
>>>> to -rc4 and test there; but if anyone already has some ideas, let me
>>>> know.
>>>>
>>>> Hardware is thinkpad X220
>>>>
>>>> 00:19.0 Ethernet controller: Intel Corporation 82579LM Gigabit Network
>>>> Connection (rev 04)
>>>
>>> I guess this is ACPI S3 suspend?
>>
>> ACPI S3, right. Machine still wakes up properly when I hit a key on
>> USB keyboard.
>
> OK, so my guess would be a driver issue.  What driver is this, igb?
>
>> Does wake on LAN work on you, on any hardware?
>
> Yes it does, I checked two machines earlier today, both work.
>
> Can you enable dynamic debug in device_pm.c and send a dmesg output
> with that covering a suspend-resume cycle?

82579 is e1000e

-- 
Hisashi T Fujinaka - htodd at twofifty.com
