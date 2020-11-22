From: Kees Cook <keescook@chromium.org>
Date: Sun, 22 Nov 2020 08:17:03 -0800
Subject: [Intel-wired-lan] [PATCH 000/141] Fix fall-through warnings for
 Clang
In-Reply-To: <20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <20201120105344.4345c14e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011201129.B13FDB3C@keescook>
 <20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <202011220816.8B6591A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Nov 20, 2020 at 11:51:42AM -0800, Jakub Kicinski wrote:
> On Fri, 20 Nov 2020 11:30:40 -0800 Kees Cook wrote:
> > On Fri, Nov 20, 2020 at 10:53:44AM -0800, Jakub Kicinski wrote:
> > > On Fri, 20 Nov 2020 12:21:39 -0600 Gustavo A. R. Silva wrote:  
> > > > This series aims to fix almost all remaining fall-through warnings in
> > > > order to enable -Wimplicit-fallthrough for Clang.
> > > > 
> > > > In preparation to enable -Wimplicit-fallthrough for Clang, explicitly
> > > > add multiple break/goto/return/fallthrough statements instead of just
> > > > letting the code fall through to the next case.
> > > > 
> > > > Notice that in order to enable -Wimplicit-fallthrough for Clang, this
> > > > change[1] is meant to be reverted at some point. So, this patch helps
> > > > to move in that direction.
> > > > 
> > > > Something important to mention is that there is currently a discrepancy
> > > > between GCC and Clang when dealing with switch fall-through to empty case
> > > > statements or to cases that only contain a break/continue/return
> > > > statement[2][3][4].  
> > > 
> > > Are we sure we want to make this change? Was it discussed before?
> > > 
> > > Are there any bugs Clangs puritanical definition of fallthrough helped
> > > find?
> > > 
> > > IMVHO compiler warnings are supposed to warn about issues that could
> > > be bugs. Falling through to default: break; can hardly be a bug?!  
> > 
> > It's certainly a place where the intent is not always clear. I think
> > this makes all the cases unambiguous, and doesn't impact the machine
> > code, since the compiler will happily optimize away any behavioral
> > redundancy.
> 
> If none of the 140 patches here fix a real bug, and there is no change
> to machine code then it sounds to me like a W=2 kind of a warning.

FWIW, this series has found at least one bug so far:
https://lore.kernel.org/lkml/CAFCwf11izHF=g1mGry1fE5kvFFFrxzhPSM6qKAO8gxSp=Kr_CQ at mail.gmail.com/

-- 
Kees Cook
