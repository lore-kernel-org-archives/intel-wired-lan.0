From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 19 Jan 2021 09:05:39 -0800
Subject: [Intel-wired-lan] [PATCH 2/2] ethernet: igb: e1000_phy: Check
 for ops.force_speed_duplex existence
In-Reply-To: <19eab284-b7b0-7053-1aa7-5fedcee04263@molgen.mpg.de>
References: <20201102231307.13021-1-pmenzel@molgen.mpg.de>
 <20201102231307.13021-3-pmenzel@molgen.mpg.de>
 <20201102161943.343586b1@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <36ce1f2e-843c-4995-8bb2-2c2676f01b9d@molgen.mpg.de>
 <20201103103940.2ed27fa2@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <c1ad26c6-a4a6-d161-1b18-476b380f4e58@molgen.mpg.de>
 <X/ShBVXp32Y+Jeds@kroah.com>
 <19eab284-b7b0-7053-1aa7-5fedcee04263@molgen.mpg.de>
Message-ID: <20210119090539.22c3d29e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 19 Jan 2021 07:55:19 +0100 Paul Menzel wrote:
> Am 05.01.21 um 18:25 schrieb Greg KH:
> > On Tue, Jan 05, 2021 at 06:16:59PM +0100, Paul Menzel wrote:  
> >> Am 03.11.20 um 19:39 schrieb Jakub Kicinski:  
> >>> On Tue, 3 Nov 2020 08:35:09 +0100 Paul Menzel wrote:  
> >>>> According to *Developer's Certificate of Origin 1.1* [3], it?s my
> >>>> understanding, that it is *not* required. The items (a), (b), and (c)
> >>>> are connected by an *or*.
> >>>>  
> >>>>>           (b) The contribution is based upon previous work that, to the best
> >>>>>               of my knowledge, is covered under an appropriate open source
> >>>>>               license and I have the right under that license to submit that
> >>>>>               work with modifications, whether created in whole or in part
> >>>>>               by me, under the same open source license (unless I am
> >>>>>               permitted to submit under a different license), as indicated
> >>>>>               in the file; or  
> >>>
> >>> Ack, but then you need to put yourself as the author, because it's
> >>> you certifying that the code falls under (b).
> >>>
> >>> At least that's my understanding.  
> >>
> >> Greg, can you please clarify, if it?s fine, if I upstream a patch authored
> >> by somebody else and distributed under the GPLv2? I put them as the author
> >> and signed it off.  
> > 
> > You can't add someone else's signed-off-by, but you can add your own and
> > keep them as the author, has happened lots of time in the past.
> > 
> > Or, you can make the From: line be from you if the original author
> > doesn't want their name/email in the changelog, we've done that as well,
> > both are fine.  
> 
> Greg, thank you for the clarification.
> 
> Jakub, with that out of the way, can you please take patch 2/2?

Please repost the patches, if you know how please add a lore link to
this posting, thanks!
