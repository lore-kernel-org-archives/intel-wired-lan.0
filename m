From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Tue, 12 Oct 2021 19:42:30 +0200
Subject: [Intel-wired-lan] [EXT] Re: Intel I350 regression 5.10 -> 5.14
 ("The NVM Checksum Is Not Valid") [8086:1521]
In-Reply-To: <2801801.e9J7NaK4W3@kailua>
References: <1823864.tdWV9SEqCh@kailua> <2944777.ktpJ11cQ8Q@pinacolada>
 <c75203e9-0ef4-20bd-87a5-ad0846863886@intel.com> <2801801.e9J7NaK4W3@kailua>
Message-ID: <6faf4b92-78d5-47a4-63df-cc2bab7769d0@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

[Cc: +ACPI maintainers]

Am 12.10.21 um 18:34 schrieb Andreas K. Huettel:
>>> The messages easily identifiable are:
>>>
>>> huettel at pinacolada ~/tmp $ cat kernel-messages-5.10.59.txt |grep igb
>>> Oct  5 15:11:18 dilfridge kernel: [    2.090675] igb: Intel(R) Gigabit Ethernet Network Driver
>>> Oct  5 15:11:18 dilfridge kernel: [    2.090676] igb: Copyright (c) 2007-2014 Intel Corporation.
>>> Oct  5 15:11:18 dilfridge kernel: [    2.090728] igb 0000:01:00.0: enabling device (0000 -> 0002)
>>
>> This line is missing below, it indicates that the kernel couldn't or
>> didn't power up the PCIe for some reason. We're looking for something
>> like ACPI or PCI patches (possibly PCI-Power management) to be the
>> culprit here.
> 
> So I did a git bisect from linux-v5.10 (good) to linux-v5.14.11 (bad).
> 
> The result was:
> 
> dilfridge /usr/src/linux-git # git bisect bad
> 6381195ad7d06ef979528c7452f3ff93659f86b1 is the first bad commit
> commit 6381195ad7d06ef979528c7452f3ff93659f86b1
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Date:   Mon May 24 17:26:16 2021 +0200
> 
>      ACPI: power: Rework turning off unused power resources
> [...]
> 
> I tried naive reverting of this commit on top of 5.14.11. That applies nearly cleanly,
> and after a reboot the additional ethernet interfaces show up with their MAC in the
> boot messages.
> 
> (Not knowing how safe that experiment was, I did not go further than single mode and
> immediately rebooted into 5.10 afterwards.)
