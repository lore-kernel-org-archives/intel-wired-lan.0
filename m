From: Rafael J. Wysocki <rafael@kernel.org>
Date: Wed, 9 Aug 2017 23:59:15 +0200
Subject: [Intel-wired-lan] [regression] wake on lan no longer works in
 4.13-rc3. was Re: Linux 4.13: Reported regressions as of Sunday, 2017-08-06
In-Reply-To: <20170809215634.GA16992@amd>
References: <a6b015b1-a4da-c56b-89e4-629c873af4d0@leemhuis.info>
 <15027171.LoAvHuklGv@aspire.rjw.lan> <20170809064231.GA19118@amd>
 <25469991.213uJSqkO8@aspire.rjw.lan>
 <alpine.NEB.2.21.1.1708091415010.1455@chris.i8u.org>
 <20170809215634.GA16992@amd>
Message-ID: <CAJZ5v0jykByXcFmYjOb_hmye2D1BBkK31vA7WFp4W+OAr52fuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Aug 9, 2017 at 11:56 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> >[You seem to have a stale linux-pm address in your address book,
>> >I replaced it with the current one in the CC list.]
>
> Thanks, fixed.
>
>> >>ACPI S3, right. Machine still wakes up properly when I hit a key on
>> >>USB keyboard.
>> >
>> >OK, so my guess would be a driver issue.  What driver is this, igb?
>> >
>> >>Does wake on LAN work on you, on any hardware?
>> >
>> >Yes it does, I checked two machines earlier today, both work.
>> >
>> >Can you enable dynamic debug in device_pm.c and send a dmesg output
>> >with that covering a suspend-resume cycle?
>>
>> 82579 is e1000e
>
> Thanks for all the help.
>
> I now realized what was going on: I had badly inserted ethernet
> cable; machine just connected to wifi, and everything worked... except
> wake on LAN.
>
> Sorry for the noise,

No worries. ;-)
