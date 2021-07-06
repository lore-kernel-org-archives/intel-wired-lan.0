From: Pali =?unknown-8bit?q?Roh=C3=A1r?= <pali@kernel.org>
Date: Tue, 6 Jul 2021 16:23:15 +0200
Subject: [Intel-wired-lan] [PATCH 1/2] igc: don't rd/wr iomem when PCI
 is removed
In-Reply-To: <20210705230212.GC142312@rocinante>
References: <20210702045120.22855-1-aaron.ma@canonical.com>
 <20210704142808.f43jbcufk37hundo@pali>
 <20210705230212.GC142312@rocinante>
Message-ID: <20210706142315.ve22wypovdezqnva@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tuesday 06 July 2021 01:02:12 Krzysztof Wilczy?ski wrote:
> Hi Pali,
> 
> [...]
> > Aaron: can you check if pci_dev_is_disconnected() is really something
> > which should be used and it helps you?
> 
> While having a closer look, I've noticed that quite a few of the network
> drivers handle this somewhat, as I see that a lot of them have some sort
> of I/O error handles set where a check for "pci_channel_io_perm_failure"
> seem to be having place.  This is also true for this driver looking at
> the igc_io_error_detected().
> 
> Is this not working for the igc driver?  Or is this for something
> completely different?

I guess that this callback is called when Bridge receive some kind of
fatal error. Non-AER-aware bridges probably do not have to inform system
that error happened and kernel would not call this callback. So I guess
it depends on to which "machine" you need this network adapter.

So in my opinion this callback is there for PCI subsystem to inform
driver that error happened and let driver to do any hw specific recovery
if it is possible.

But I think problem described here can be slightly different. It is
needed to check if device is still alive or was disconnected.

> Having said all that, I am not an expert in network drivers, so pardon
> me if I am asking about something completely different, and I apologise
> if that is the case.
> 
> > Bjorn, Krzysztof: what do you think about lifting helper function
> > pci_dev_is_disconnected() to be available to all drivers and not only in
> > PCI subsystem?
> 
> No objections from me, if we believe it's useful and that it might
> encourage people to use a common API.  Currently, I can see at least
> five potential users of this helper.
> 
> 	Krzysztof
