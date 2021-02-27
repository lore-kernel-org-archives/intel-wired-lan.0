From: Billy Croan <BCroan@unrealservers.net>
Date: Sat, 27 Feb 2021 16:18:49 -0600
Subject: [Intel-wired-lan] How to "arm" WoL with OS running?
In-Reply-To: <20210226094853.0000470c@intel.com>
References: <CABJL2KoxdiBV6BBOJKfU4pAxANy3F-65c3+mtM2BhS5Lu89vfw@mail.gmail.com>
 <20210226094853.0000470c@intel.com>
Message-ID: <CABJL2KqRkGffkF_Q7WKQesOO2G6E3B4-hc_RsiK+jXnbhfq4Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thank you Jesse. I agree with the security considerations 100%.
Unfortunately this hardware does not support ipmi and we have an awful lot
of it that would can go to waste if we discarded it for that reason.
Logging into reboot of course with your preferable but our use case for
reboot on lan is if the system is locked up or unresponsive or SSH is
broken in other words similar use case for ipmi.

I'll check out the e1000e developer manuals on Intel.com.

On Fri, Feb 26, 2021, 11:48 Jesse Brandeburg <jesse.brandeburg@intel.com>
wrote:

> Billy Croan wrote:
>
> > I was reading https://en.wikipedia.org/wiki/Wake-on-LAN and came across
> > this phrase: "not armed for WOL"
> >
> > I have some OpenCompute hardware which uses the WoL signal from the intel
> > network chip to cause a reset/reboot.
> >
> > this works when the system is in bios or in memtest86, but not when an OS
> > is loaded.  I suspect that the e1000e driver "disarms" WoL on load, and
> 're
> > arms' it when unloaded or when the OS shuts down or changes to a lower
> ACPI
> > state.
>
> That's right, that's the supported use case for WoL.
>
> > Is there a technical reason any WoL can not be armed at the same time as
> OS
> > is using the nic?
>
> The short answer is we don't support it.
>
> There are a couple of reasons that you might not want to do this.
> 1) anyone can reboot your server remotely without authentication
> 2) IPMI can/should probably be used to control/manage the server
> instead, if available.  If the server is already available remotely
> then you can just reboot it after logging in. :-)
>
> > I get that it serves no useful purpose of the os is already running, but
> > does it pose a problem?
>
> Functionally the hardware can assert the Wake signal (PME+) any time,
> and it won't cause a problem (on a normal system). However, we don't
> support this. The developer manuals for the e1000e hardware should
> mostly be available from intel.com if you want to learn more about the
> hardware, but I'm sorry I can't help you much further since this is out
> of scope for our software support.
>
> Good luck and thanks for the question,
> Jesse
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210227/15778838/attachment.html>
