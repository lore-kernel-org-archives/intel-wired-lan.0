From: Krzysztof =?unknown-8bit?q?Wilczy=C5=84ski?= <kw@linux.com>
Date: Tue, 6 Jul 2021 01:02:12 +0200
Subject: [Intel-wired-lan] [PATCH 1/2] igc: don't rd/wr iomem when PCI
 is removed
In-Reply-To: <20210704142808.f43jbcufk37hundo@pali>
References: <20210702045120.22855-1-aaron.ma@canonical.com>
 <20210704142808.f43jbcufk37hundo@pali>
Message-ID: <20210705230212.GC142312@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Pali,

[...]
> Aaron: can you check if pci_dev_is_disconnected() is really something
> which should be used and it helps you?

While having a closer look, I've noticed that quite a few of the network
drivers handle this somewhat, as I see that a lot of them have some sort
of I/O error handles set where a check for "pci_channel_io_perm_failure"
seem to be having place.  This is also true for this driver looking at
the igc_io_error_detected().

Is this not working for the igc driver?  Or is this for something
completely different?

Having said all that, I am not an expert in network drivers, so pardon
me if I am asking about something completely different, and I apologise
if that is the case.

> Bjorn, Krzysztof: what do you think about lifting helper function
> pci_dev_is_disconnected() to be available to all drivers and not only in
> PCI subsystem?

No objections from me, if we believe it's useful and that it might
encourage people to use a common API.  Currently, I can see at least
five potential users of this helper.

	Krzysztof
