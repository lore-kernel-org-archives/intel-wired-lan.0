From: Jakub Kicinski <kuba@kernel.org>
Date: Sat, 5 Dec 2020 15:49:51 -0800
Subject: [Intel-wired-lan] [PATCH v3 0/7] Improve s0ix flows for systems
 i219LM
In-Reply-To: <CAKgT0UfuyrbzpDNySMmnAkqKnw9cYuEM1LhgG0QvmrY=smR-uw@mail.gmail.com>
References: <20201204200920.133780-1-mario.limonciello@dell.com>
 <CAKgT0Uc=OxcuHbZihY3zxsxzPprJ_8vGHr=reBJFMrf=V9A5kg@mail.gmail.com>
 <DM6PR19MB2636B200D618A5546E7BBB57FAF10@DM6PR19MB2636.namprd19.prod.outlook.com>
 <CAKgT0UfuyrbzpDNySMmnAkqKnw9cYuEM1LhgG0QvmrY=smR-uw@mail.gmail.com>
Message-ID: <20201205154951.4dd92194@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 4 Dec 2020 14:38:03 -0800 Alexander Duyck wrote:
> > > The patches look good to me. Just need to address the minor issue that
> > > seems to have been present prior to the introduction of this patch
> > > set.
> > >
> > > Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>  
> >
> > Thanks for your review.  Just some operational questions - since this previously
> > existed do you want me to re-spin the series to a v4 for this, or should it be
> > a follow up after the series?
> >
> > If I respin it, would you prefer that change to occur at the start or end
> > of the series?  
> 
> I don't need a respin, but if you are going to fix it you should
> probably put out the patch as something like a 8/7. If you respin it
> should happen near the start of the series as it is a bug you are
> addressing.

Don't we need that patch to be before this series so it can be
back ported easily? Or is it not really a bug?
