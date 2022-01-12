From: Bjorn Helgaas <helgaas@kernel.org>
Date: Wed, 12 Jan 2022 08:50:53 -0600
Subject: [Intel-wired-lan] [PATCH v2] PCI: Fix Intel i210 by avoiding
 overlapping of BARs
In-Reply-To: <9526698be0ced0f7a7ed00bd76538d16@walle.cc>
Message-ID: <20220112145053.GA254177@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Dec 23, 2021 at 07:12:02PM +0100, Michael Walle wrote:
> Am 2021-12-23 17:37, schrieb Bjorn Helgaas:
> 
> > I intended to change the quirk from FINAL to EARLY, but obviously
> > forgot.  Here's the updated version:
> > 
> > commit bb5639b73a2d ("PCI: Work around Intel I210 ROM BAR overlap
> > defect")
> > Author: Bjorn Helgaas <bhelgaas@google.com>
> > Date:   Tue Dec 21 10:45:07 2021 -0600
> > 
> >     PCI: Work around Intel I210 ROM BAR overlap defect
> > 
> >     Per PCIe r5, sec 7.5.1.2.4, a device must not claim accesses to its
> >     Expansion ROM unless both the Memory Space Enable and the Expansion
> > ROM
> >     Enable bit are set.  But apparently some Intel I210 NICs don't work
> >     correctly if the ROM BAR overlaps another BAR, even if the Expansion
> > ROM is
> >     disabled.
> > 
> >     Michael reported that on a Kontron SMARC-sAL28 ARM64 system with
> > U-Boot
> >     v2021.01-rc3, the ROM BAR overlaps BAR 3, and networking doesn't
> > work at
> >     all:
> > 
> >       BAR 0: 0x40000000 (32-bit, non-prefetchable) [size=1M]
> >       BAR 3: 0x40200000 (32-bit, non-prefetchable) [size=16K]
> >       ROM:   0x40200000 (disabled) [size=1M]
> > 
> >       NETDEV WATCHDOG: enP2p1s0 (igb): transmit queue 0 timed out
> >       Hardware name: Kontron SMARC-sAL28 (Single PHY) on SMARC Eval
> > 2.0 carrier (DT)
> >       igb 0002:01:00.0 enP2p1s0: Reset adapter
> > 
> >     Previously, pci_std_update_resource() wrote the assigned ROM address
> > to the
> >     BAR only when the ROM was enabled.  This meant that the I210 ROM BAR
> > could
> >     be left with an address assigned by firmware, which might overlap
> > with
> >     other BARs.
> > 
> >     Quirk these I210 devices so pci_std_update_resource() always writes
> > the
> >     assigned address to the ROM BAR, whether or not the ROM is enabled.
> > 
> >     Link:
> > https://lore.kernel.org/r/20201230185317.30915-1-michael at walle.cc
> >     Link: https://bugzilla.kernel.org/show_bug.cgi?id=211105
> >     Reported-by: Michael Walle <michael@walle.cc>
> >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Tested-by: Michael Walle <michael@walle.cc>

Applied to pci/resource for v5.17, thanks!
