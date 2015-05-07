From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 07 May 2015 09:57:39 -0700
Subject: [Intel-wired-lan] [PATCH 0/3] igb: add i210/i211 external phy
 support
In-Reply-To: <CAJ+vNU2YM9hd52hKwzj8GxmkhLNny+6Tic3X9HyHFrvEeXsgSw@mail.gmail.com>
References: <1430417955-28252-1-git-send-email-tharvey@gateworks.com>
 <1430791229.2669.205.camel@jtkirshe-mobl>
 <CAJ+vNU2YM9hd52hKwzj8GxmkhLNny+6Tic3X9HyHFrvEeXsgSw@mail.gmail.com>
Message-ID: <1431017859.32618.29.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2015-05-07 at 09:40 -0700, Tim Harvey wrote:
> On Mon, May 4, 2015 at 7:00 PM, Jeff Kirsher
> <jeffrey.t.kirsher@intel.com> wrote:
> > On Thu, 2015-04-30 at 11:19 -0700, Tim Harvey wrote:
> >> The i210/i211 can use an external phy and there is support built
> into
> >> igb
> >> for several. However if you instead want to use the Linux phydev
> >> driver API
> >> the igb driver needs to register an MDIO bus with Linux.
> >>
> >> This patch series fixes mdio read/write capability for i210/i211
> and
> >> registers an MDIO bus if the EEPROM is configured with an external
> >> phy.
> >>
> >> This has only been tested on an i210 with an external phy as that
> is
> >> all I
> >> have access to. Testing is needed.
> >>
> >> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> >
> > Tried to apply your patch series and it does not apply cleanly to my
> > next-queue tree (dev-queue branch).  Please update your series to my
> > latest tree and re-submit.
> >
> >> Tim Harvey (3):
> >>   net: igb: add i210/i211 support for phy read/write
> >>   net: igb: add phy read/write functions that accept phy addr
> >>   net: igb: register mii_bus for SerDes w/ external phy
> >>
> >>  drivers/net/ethernet/intel/igb/e1000_82575.c |  20 +++-
> >>  drivers/net/ethernet/intel/igb/e1000_hw.h    |   7 ++
> >>  drivers/net/ethernet/intel/igb/e1000_phy.c   | 137
> >> +++++++++++++++++-----
> >>  drivers/net/ethernet/intel/igb/e1000_phy.h   |   6 +-
> >>  drivers/net/ethernet/intel/igb/igb_main.c    | 163
> >> ++++++++++++++++++++++++++-
> >>  5 files changed, 297 insertions(+), 36 deletions(-)
> >
> >
> 
> Jeff,
> 
> The first patch was to add i210/i211 support for phy read/write (when
> using i210/i211 with an external phy) which I should split out from
> the other two which are to add phylib support to igb. This first patch
> however is colliding with 'igb: add PHY support for Broadcom 5461S'
> [1] which I believe you just nak'd. I guess patch submissions
> automatically get applied to next-queue/dev-queue? What should I
> rebase against?

I applied it so that Aaron could do regression testing on it, while we
were reviewing the changes.  I popped off that last series from
Jonathan, so you should be able to rebase your patches on my dev-queue
branch now.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150507/6d9f8f7f/attachment.asc>
