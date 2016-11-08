From: Ray Bellis <ray@isc.org>
Date: Tue, 8 Nov 2016 17:30:10 +0000
Subject: [Intel-wired-lan] i40e performance regression after 1.3.9 ?
In-Reply-To: <9BBC4E0CF881AA4299206E2E1412B626502D1C88@ORSMSX102.amr.corp.intel.com>
References: <9f9f62ec-fbce-534a-d2bd-e918a03a3899@isc.org>
 <CAKgT0Uc9W_tvMEoKzLzBG-pK7Sjznr3B+xgjne0tUuTX17d+Hg@mail.gmail.com>
 <fe40bb83-d28c-8fc4-148a-37ff7ad5c7aa@isc.org>
 <CAKgT0UfB-ofJw6gA2f-FJvBcn-4Qd52DrQuth828xWkp8+WSDg@mail.gmail.com>
 <aea231d5-64bb-97e7-57f6-cf845629d9ef@isc.org>
 <9BBC4E0CF881AA4299206E2E1412B626502D1704@ORSMSX102.amr.corp.intel.com>
 <9948372e-4093-4ce3-ee3e-aa06d2a7a939@isc.org>
 <9BBC4E0CF881AA4299206E2E1412B626502D1C88@ORSMSX102.amr.corp.intel.com>
Message-ID: <db744625-2985-1aec-8ae4-8667e457f379@isc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 08/11/2016 17:18, Wyborny, Carolyn wrote:

> Its strange that there would be such a difference between them. Are
> they the same hw with the same resources, same slot, BIOS versions.,
> etc., ad infinitem?  The driver settings are the same, apparently,
> but something else must be configured different by default.

As far as I can tell they are, although the dnsperf software I'm using
to generate the test traffic (and from which those rates are reported)
is perhaps just more sensitive to whatever's causing this issue.

The simplest test I have is that I can load the 1.3.9 driver on the
client and performance is rock steady, but when I put in any later
driver I either get a massive drop (with adaptive on) or higher but very
unstable values (with adaptive off).

[the systems are Dell R430s which were all built identically on the same
order]

> If you haven't been here already, here is a link to performance
> tuning generally for Intel Ethernet.
> http://www.intel.com/content/www/us/en/support/network-and-i-o/ethernet-products/000005811.html

I'm not sure I've referred to that specific guide, but I have for
example turned off IRQ balancing, and put each RX/TX queue IRQ onto a
separate CPU core, and have hyperthreading disabled.

> We have another interrupt moderation feature in the X710 HW called
> Interrupt Rate Limiting.  It should be described in the README, but
> can also be found packaged with our out of tree driver at
> SourceForge.  I'd be interested to know if disabling the adaptive ITR
> and trying the Rate Limiting has any effect on what you're seeing.
> I'd suggest trying this on the server system to avoid whatever is
> going on with the Client system.

OK, I'll give that a try (tomorrow now, it's the end of my day here in
the UK).

thanks,

Ray

