From: Forrest Fleming <ffleming@gmail.com>
Date: Tue, 27 Aug 2019 12:45:58 -0700
Subject: [Intel-wired-lan] [PATCH] net: intel: Cleanup e1000 - add space
 between }}
In-Reply-To: <b1ea77866e8736fa691cf4658a87ca2c1bf642d6.camel@perches.com>
References: <20190823191421.3318-1-ffleming@gmail.com>
 <c2279a78904b581924894b712403299903eacbfc.camel@intel.com>
 <877726fc009ee5ffde50e589d332db90c9695f06.camel@perches.com>
 <c40b4043424055fc4dae97771bb46c8ab15c6230.camel@intel.com>
 <b1ea77866e8736fa691cf4658a87ca2c1bf642d6.camel@perches.com>
Message-ID: <CAE7kSDuHi3e_b0qyvXqocSVaNJrj3X7PPiawBWa68ZyrLSAZyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Aug 27, 2019 at 12:07 PM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2019-08-27 at 12:02 -0700, Jeff Kirsher wrote:
> > On Mon, 2019-08-26 at 20:41 -0700, Joe Perches wrote:
> > > On Mon, 2019-08-26 at 01:03 -0700, Jeff Kirsher wrote:
> > > > On Fri, 2019-08-23 at 19:14 +0000, Forrest Fleming wrote:
> > > > > suggested by checkpatch
> > > > >
> > > > > Signed-off-by: Forrest Fleming <ffleming@gmail.com>
> > > > > ---
> > > > >  .../net/ethernet/intel/e1000/e1000_param.c    | 28 +++++++++--
> > > > > --------
> > > > >  1 file changed, 14 insertions(+), 14 deletions(-)
> > > >
> > > > While I do not see an issue with this change, I wonder how
> > > > important it is
> > > > to make such a change.  Especially since most of the hardware
> > > > supported by
> > > > this driver is not available for testing.  In addition, this is one
> > > > suggested change by checkpatch.pl that I personally do not agree
> > > > with.
> > >
> > > I think checkpatch should allow consecutive }}.
> >
> > Agreed, have you already submitted a formal patch Joe with the
> > suggested change below?
>
> No.
>
> >   If so, I will ACK it.
>
> Of course you can add an Acked-by:
>

Totally fair - I don't have strong feelings regarding the particular rule. I do
feel strongly that we should avoid violating our rules as encoded by checkpatch,
but I'm perfectly happy for the change to take the form of modifying checkpatch
to allow a perfectly sensible (and readable) construct.

I'm happy to withdraw this patch from consideration; I couldn't find anything
about there being a formal procedure for so doing, so please let me know if
there's anything more I need to do (or point me to the relevant docs).

Thanks to everyone!
