From: Ronciak, John <john.ronciak@intel.com>
Date: Fri, 8 May 2015 16:39:10 +0000
Subject: [Intel-wired-lan] [PATCH v1 net-next 1/2] igb: add PHY support
	for Broadcom 5461S
In-Reply-To: <CAPg-hwmB-=fd_OjMbtL_Am5e9znX36KOnMnHNdwTMnCmQBeHPw@mail.gmail.com>
References: <1429302240-654-1-git-send-email-jtoppins@cumulusnetworks.com>
 <1430999388.32618.21.camel@jtkirshe-mobl>
 <CAPg-hwmB-=fd_OjMbtL_Am5e9znX36KOnMnHNdwTMnCmQBeHPw@mail.gmail.com>
Message-ID: <D38E8E86660E514AB505863C19C9287C74192484@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> I think we would be willing to take on this task, but I would not like that to be a
> gating factor for upstream acceptance of the functionality added with this
> patch.  I see that Aaron has commented that no regressions were found with
> this patch, but based on current status in patchwork, it looks like Dave is
> waiting for something a bit more definitive before accepting it.  Can you ACK it
> first so we have support for this platform upstream and then we can go take a
> stab at phylib support for igb?
So Andy, are you wanting us to accept the patch and that you will then redo things to move to PHYlib in the near future?  What's the time line for that work?  What happens if you guys don't get around to doing it?  This can become very problematic for us as you can imagine.  This also really isn't the upstream way of doing something like this.  So I'm a bit hesitant to do it this way.  

Can you explain your urgency?

Cheers,
John

> -----Original Message-----
> From: Andy Gospodarek [mailto:gospo at cumulusnetworks.com]
> Sent: Thursday, May 7, 2015 6:41 AM
> To: Kirsher, Jeffrey T
> Cc: Jonathan Toppins; Wyborny, Carolyn; Ronciak, John; intel-wired-
> lan at lists.osuosl.org; Shrijeet Mukherjee; Alan Liebthal; Fujinaka, Todd
> Subject: Re: [PATCH v1 net-next 1/2] igb: add PHY support for Broadcom 5461S
> 
> On Thu, May 7, 2015 at 7:49 AM, Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> wrote:
> > On Fri, 2015-04-17 at 13:23 -0700, Jonathan Toppins wrote:
> >> From: Alan Liebthal <alanl@cumulusnetworks.com>
> >>
> >> The Quanta LY8 Ethernet management port uses a Broadcom 5461S chip
> >> for the PHY layer. This adds support for this PHY to the Intel igb driver.
> >>
> >> Signed-off-by: Alan Liebthal <alanl@cumulusnetworks.com>
> >> Signed-off-by: Jonathan Toppins <jtoppins@cumulusnetworks.com>
> >> ---
> >>  drivers/net/ethernet/intel/igb/e1000_82575.c   |   20 +++++-
> >>  drivers/net/ethernet/intel/igb/e1000_defines.h |    1 +
> >>  drivers/net/ethernet/intel/igb/e1000_hw.h      |    1 +
> >>  drivers/net/ethernet/intel/igb/e1000_phy.c     |   79
> >> ++++++++++++++++++++++++
> >>  drivers/net/ethernet/intel/igb/e1000_phy.h     |    2 +
> >>  5 files changed, 102 insertions(+), 1 deletion(-)
> >
> > After at lot of discussion on these changes, we would like to you to
> > use the PHYLib approach.  I know that means adding PHYLib support to
> > our drivers, which we currently do not have.
> 
> Jeff,
> 
> I think we would be willing to take on this task, but I would not like that to be a
> gating factor for upstream acceptance of the functionality added with this
> patch.  I see that Aaron has commented that no regressions were found with
> this patch, but based on current status in patchwork, it looks like Dave is
> waiting for something a bit more definitive before accepting it.  Can you ACK it
> first so we have support for this platform upstream and then we can go take a
> stab at phylib support for igb?
> 
> Thanks,
> 
> -andy
