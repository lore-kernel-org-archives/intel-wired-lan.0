From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri, 26 Feb 2021 09:48:53 -0800
Subject: [Intel-wired-lan] How to "arm" WoL with OS running?
In-Reply-To: <CABJL2KoxdiBV6BBOJKfU4pAxANy3F-65c3+mtM2BhS5Lu89vfw@mail.gmail.com>
References: <CABJL2KoxdiBV6BBOJKfU4pAxANy3F-65c3+mtM2BhS5Lu89vfw@mail.gmail.com>
Message-ID: <20210226094853.0000470c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Billy Croan wrote:

> I was reading https://en.wikipedia.org/wiki/Wake-on-LAN and came across
> this phrase: "not armed for WOL"
> 
> I have some OpenCompute hardware which uses the WoL signal from the intel
> network chip to cause a reset/reboot.
> 
> this works when the system is in bios or in memtest86, but not when an OS
> is loaded.  I suspect that the e1000e driver "disarms" WoL on load, and 're
> arms' it when unloaded or when the OS shuts down or changes to a lower ACPI
> state.

That's right, that's the supported use case for WoL.

> Is there a technical reason any WoL can not be armed at the same time as OS
> is using the nic?

The short answer is we don't support it.

There are a couple of reasons that you might not want to do this. 
1) anyone can reboot your server remotely without authentication
2) IPMI can/should probably be used to control/manage the server
instead, if available.  If the server is already available remotely
then you can just reboot it after logging in. :-)

> I get that it serves no useful purpose of the os is already running, but
> does it pose a problem?

Functionally the hardware can assert the Wake signal (PME+) any time,
and it won't cause a problem (on a normal system). However, we don't
support this. The developer manuals for the e1000e hardware should
mostly be available from intel.com if you want to learn more about the
hardware, but I'm sorry I can't help you much further since this is out
of scope for our software support.

Good luck and thanks for the question,
Jesse
