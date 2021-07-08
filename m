From: Oliver O'Halloran <oohall@gmail.com>
Date: Thu, 8 Jul 2021 12:04:02 +1000
Subject: [Intel-wired-lan] [PATCH 1/2] igc: don't rd/wr iomem when PCI
 is removed
In-Reply-To: <20210707221042.GA939059@bjorn-Precision-5520>
References: <20210707215337.lwbgvb6lxs3gmsbb@pali>
 <20210707221042.GA939059@bjorn-Precision-5520>
Message-ID: <CAOSf1CGVpogQGAatuY_N0db6OL2BFegGtj6VTLA9KFz0TqYBQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Jul 8, 2021 at 8:40 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> If we add the check as proposed in this patch, I think people will
> read it and think this is the correct way to avoid MMIO errors.  It
> does happen to avoid some MMIO errors, but it cannot avoid them all,
> so it's not a complete solution and it gives a false sense of
> security.

I think it's helpful to classify MMIO errors as either benign or
poisonous with the poison MMIOs causing some kind of crash. Most of
the discussions about pci_dev_is_disconnected(), including this one,
seem to stem from people trying to use it to avoid the poison case. I
agree that using pci_dev_is_disconnected() that way is hacky and
doesn't really fix the problem, but considering poison MMIOs usually
stem from broken hardware or firmware  maybe we should allow it
anyway. We can't do anything better and it's an improvement compared
to crashing.

> A complete solution requires a test *after* the MMIO read.  If you
> have the test after the read, you don't really need one before.  Sure,
> testing before means you can avoid one MMIO read failure in some
> cases.  But avoiding that failure costs quite a lot in code clutter.

It's not that much clutter if the checks are buried in the MMIO
helpers which most drivers define. Speaking of which:

> u32 igc_rd32(struct igc_hw *hw, u32 reg)
> {
>   struct igc_adapter *igc = container_of(hw, struct igc_adapter, hw);
>   u8 __iomem *hw_addr = READ_ONCE(hw->hw_addr);
>   u32 value = 0;
>
>   value = readl(&hw_addr[reg]);
>
>   /* reads should not return all F's */
>   if (!(~value) && (!reg || !(~readl(hw_addr)))) {
>     struct net_device *netdev = igc->netdev;
>
>     hw->hw_addr = NULL;
>     netif_device_detach(netdev);
>     netdev_err(netdev, "PCIe link lost, device now detached\n");
>     WARN(pci_device_is_present(igc->pdev),
>          "igc: Failed to read reg 0x%x!\n", reg);
>   }
>
>   return value;
> }

I think I found where that page fault is coming from.

I wonder if we should provide drivers some way of invoking the error
recovery mechanisms manually or even just flagging itself as broken.
Right now even if the driver bothers with synchronous error detection
the driver can't really do anything other than parking itself and
hoping AER/EEH recovery kicks in.

Oliver
