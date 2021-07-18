From: Oliver O'Halloran <oohall@gmail.com>
Date: Mon, 19 Jul 2021 02:31:10 +1000
Subject: [Intel-wired-lan] [PATCH 1/2] igc: don't rd/wr iomem when PCI
 is removed
In-Reply-To: <20210708154550.GA1019947@bjorn-Precision-5520>
References: <CAOSf1CGVpogQGAatuY_N0db6OL2BFegGtj6VTLA9KFz0TqYBQg@mail.gmail.com>
 <20210708154550.GA1019947@bjorn-Precision-5520>
Message-ID: <CAOSf1CHtHLyEHC58jwemZS6j=jAU2OrrYitkUYmdisJtuFu4dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jul 9, 2021 at 1:45 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> *snip*
>
> Apologies for rehashing what's probably obvious to everybody but me.
> I'm trying to get a better handle on benign vs poisonous errors.
>
> MMIO means CPU reads or writes to the device.  In PCI, writes are
> posted and don't receive a response, so a driver will never see
> writel() return an error (although an error may be reported
> asynchronously via AER or similar).
>
> So I think we're mostly talking about CPU reads here.  We expect a PCI
> response containing the data.  Sometimes there's no response or an
> error response.  The behavior of the host bridge in these error cases
> is not defined by PCI, so what the CPU sees is not consistent across
> platforms.  In some cases, the bridge handles this as a catastrophic
> error that forces a system restart.
>
> But in most cases, at least on x86, the bridge logs an error and
> fabricates ~0 data so the CPU read can complete.  Then it's up to
> software to recognize that an error occurred and decide what to do
> about it.  Is this a benign or a poisonous error?
>
> I'd say this is a benign error. It certainly can't be ignored, but as
> long as the driver recognizes the error, it should be able to deal
> with it without crashing the whole system and forcing a restart.

I was thinking more in terms of what the driver author sees rather
than what's happening on the CPU side. The crash seen in the OP
appears to be because the code is "doing an MMIO." However, the
reasons for the crash have nothing to do with the actual mechanics of
the operation (which should be benign). The point I was making is that
the pattern of:

if (is_disconnected())
    return failure;
return do_mmio_read(addr);

does have some utility as a last-ditch attempt to prevent crashes in
the face of obnoxious bridges or bad hardware. Granted, that should be
a platform concern rather than something that should ever appear in
driver code, but considering drivers open-code readl()/writel() calls
there's not really any place to put that sort of workaround.

That all said, the case in the OP is due to an entirely avoidable
driver bug and that sort of hack is absolutely the wrong thing to do.

Oliver
