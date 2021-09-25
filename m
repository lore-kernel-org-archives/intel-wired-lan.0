From: Leon Romanovsky <leon@kernel.org>
Date: Sat, 25 Sep 2021 13:01:29 +0300
Subject: [Intel-wired-lan] [PATCH net-next 1/6] bnxt_en: Check devlink
 allocation and registration status
In-Reply-To: <CAKOOJTwh6TnNM4uSM2rbaij=xO92UzF2hs11pgOFUniOb3HAkA@mail.gmail.com>
References: <cover.1632420430.git.leonro@nvidia.com>
 <e7708737fadf4fe6f152afc76145c728c201adad.1632420430.git.leonro@nvidia.com>
 <CAKOOJTz4A2ER8MQE1dW27Spocds09SYafjeuLcFDJ0nL6mKyOw@mail.gmail.com>
 <YU0JlzFOa7kpKgnd@unreal>
 <20210923183956.506bfde2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAKOOJTwh6TnNM4uSM2rbaij=xO92UzF2hs11pgOFUniOb3HAkA@mail.gmail.com>
Message-ID: <YU7zeca8AsJwQTsD@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Sep 24, 2021 at 10:20:32AM -0700, Edwin Peer wrote:
> On Thu, Sep 23, 2021 at 6:39 PM Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > On Fri, 24 Sep 2021 02:11:19 +0300 Leon Romanovsky wrote:
> > > > minor nit: There's obviously nothing incorrect about doing this (and
> > > > adding the additional error label in the cleanup code above), but bnxt
> > > > has generally adopted a style of having cleanup functions being
> > > > idempotent. It generally makes error handling simpler and less error
> > > > prone.
> > >
> > > I would argue that opposite is true. Such "impossible" checks hide unwind
> > > flow errors, missing releases e.t.c.
> >
> > +1, fwiw
> 
> I appreciate that being more explicit can improve visibility, but it
> does not make error handling inherently less error prone, nor is it
> simpler (ie. the opposite isn't true). Idempotency is orthogonal to
> unwind flow or the presence or not of a particular unwind handler (one
> can still enforce either in review). But, if release handlers are
> independent (most in bnxt are), then permitting other orderings can be
> perfectly valid and places less burden on achieving the canonical form
> for correctness (ie. usage is simpler and less error prone). That's
> not to say we should throw caution to the wind and allow arbitrary
> unwind flows, but it does mean certain mistakes don't result in actual
> bugs. There are other flexibility benefits too. A single, unwind
> everything, handler can be reused in more than one context.

And this is where the fun begins. Different context means different
lifetime expectations, maybe need of locking and unpredictable flows
from reader perspective.

For example, in this devlink case, it took me time to check all driver
to see that pf can't be null. 

The idea that adding code that maybe will be used can be seen as
anti-pattern.

Thanks
