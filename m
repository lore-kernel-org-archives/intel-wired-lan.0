From: Wyborny, Carolyn <carolyn.wyborny@intel.com>
Date: Tue, 8 Nov 2016 17:18:55 +0000
Subject: [Intel-wired-lan] i40e performance regression after 1.3.9 ?
In-Reply-To: <9948372e-4093-4ce3-ee3e-aa06d2a7a939@isc.org>
References: <9f9f62ec-fbce-534a-d2bd-e918a03a3899@isc.org>
 <CAKgT0Uc9W_tvMEoKzLzBG-pK7Sjznr3B+xgjne0tUuTX17d+Hg@mail.gmail.com>
 <fe40bb83-d28c-8fc4-148a-37ff7ad5c7aa@isc.org>
 <CAKgT0UfB-ofJw6gA2f-FJvBcn-4Qd52DrQuth828xWkp8+WSDg@mail.gmail.com>
 <aea231d5-64bb-97e7-57f6-cf845629d9ef@isc.org>
 <9BBC4E0CF881AA4299206E2E1412B626502D1704@ORSMSX102.amr.corp.intel.com>
 <9948372e-4093-4ce3-ee3e-aa06d2a7a939@isc.org>
Message-ID: <9BBC4E0CF881AA4299206E2E1412B626502D1C88@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Ray Bellis [mailto:ray at isc.org]
> Sent: Tuesday, November 08, 2016 8:31 AM
> To: Wyborny, Carolyn <carolyn.wyborny@intel.com>; Alexander Duyck
> <alexander.duyck@gmail.com>
> Cc: intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] i40e performance regression after 1.3.9 ?
> 
[..]
> If I upgrade to anything beyond 1.3.9 in the client system I seem to be
> unable to maintain the original packet rates regardless of adapter settings.
> 
[..]
> For unknown reasons it's producing higher figures than my run from this
> morning (UK time) but the variability is still very high.  This time
> it's averaging 1.2 Mpps (still down from 1.35) but earlier it was more
> like 930 kpps.
> 
> [one possible difference is that the client machine was rebooted in
> between.  FWIW, both machines are using the default Haswell intel_pstate
> frequency governer in powersave mode.  I can change that to
> 'performance' with a specified range if necessary]
> 
> If there's a specific sequence of tests you'd like me to make, please
> let me know.

Its strange that there would be such a difference between them. Are they the same hw with the same resources, same slot, BIOS versions., etc., ad infinitem?  The driver settings are the same, apparently, but something else must be configured different by default.    

If you haven't been here already, here is a link to performance tuning generally for Intel Ethernet.  http://www.intel.com/content/www/us/en/support/network-and-i-o/ethernet-products/000005811.html

We have another interrupt moderation feature in the X710 HW called Interrupt Rate Limiting.  It should be described in the README, but can also be found packaged with our out of tree driver at SourceForge.  I'd be interested to know if disabling the adaptive ITR and trying the Rate Limiting has any effect on what you're seeing.  I'd suggest trying this on the server system to avoid whatever is going on with the Client system.

Thanks,

Carolyn


