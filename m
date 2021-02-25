From: Billy Croan <BCroan@unrealservers.net>
Date: Wed, 24 Feb 2021 22:57:37 -0600
Subject: [Intel-wired-lan] How to "arm" WoL with OS running?
Message-ID: <CABJL2KoxdiBV6BBOJKfU4pAxANy3F-65c3+mtM2BhS5Lu89vfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I was reading https://en.wikipedia.org/wiki/Wake-on-LAN and came across
this phrase: "not armed for WOL"

I have some OpenCompute hardware which uses the WoL signal from the intel
network chip to cause a reset/reboot.

this works when the system is in bios or in memtest86, but not when an OS
is loaded.  I suspect that the e1000e driver "disarms" WoL on load, and 're
arms' it when unloaded or when the OS shuts down or changes to a lower ACPI
state.

Is there a technical reason any WoL can not be armed at the same time as OS
is using the nic?

I get that it serves no useful purpose of the os is already running, but
does it pose a problem?
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210224/c9b17a8d/attachment.html>
