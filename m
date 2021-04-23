From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Fri, 23 Apr 2021 10:19:44 +0200
Subject: [Intel-wired-lan] [igb] netconsole triggers warning in
 netpoll_poll_dev
In-Reply-To: <CAKgT0UcQXVOifi_2r_Y6meg_zvHDBf1me8VwA4pvEtEMzOaw2Q@mail.gmail.com>
References: <20210406123619.rhvtr73xwwlbu2ll@spock.localdomain>
 <20210406114734.0e00cb2f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210407060053.wyo75mqwcva6w6ci@spock.localdomain>
 <20210407083748.56b9c261@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAKgT0UfLLQycLsAZQ98ofBGYPwejA6zHbG6QsNrU92mizS7e0g@mail.gmail.com>
 <20210407110722.1eb4ebf2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAKgT0UcQXVOifi_2r_Y6meg_zvHDBf1me8VwA4pvEtEMzOaw2Q@mail.gmail.com>
Message-ID: <20210423081944.kvvm4v7jcdyj74l3@spock.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello.

On Wed, Apr 07, 2021 at 04:06:29PM -0700, Alexander Duyck wrote:
> On Wed, Apr 7, 2021 at 11:07 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Wed, 7 Apr 2021 09:25:28 -0700 Alexander Duyck wrote:
> > > On Wed, Apr 7, 2021 at 8:37 AM Jakub Kicinski <kuba@kernel.org> wrote:
> > > >
> > > > On Wed, 7 Apr 2021 08:00:53 +0200 Oleksandr Natalenko wrote:
> > > > > Thanks for the effort, but reportedly [1] it made no difference,
> > > > > unfortunately.
> > > > >
> > > > > [1] https://bugzilla.kernel.org/show_bug.cgi?id=212573#c8
> > > >
> > > > The only other option I see is that somehow the NAPI has no rings.
> > > >
> > > > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> > > > index a45cd2b416c8..24568adc2fb1 100644
> > > > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > > > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > > > @@ -7980,7 +7980,7 @@ static int igb_poll(struct napi_struct *napi, int budget)
> > > >         struct igb_q_vector *q_vector = container_of(napi,
> > > >                                                      struct igb_q_vector,
> > > >                                                      napi);
> > > > -       bool clean_complete = true;
> > > > +       bool clean_complete = q_vector->tx.ring || q_vector->rx.ring;
> > > >         int work_done = 0;
> > > >
> > > >  #ifdef CONFIG_IGB_DCA
> > >
> > > It might make sense to just cast the work_done as a unsigned int, and
> > > then on the end of igb_poll use:
> > >   return min_t(unsigned int, work_done, budget - 1);
> >
> > Sure, that's simplest. I wasn't sure something is supposed to prevent
> > this condition or if it's okay to cover it up.
> 
> I'm pretty sure it is okay to cover it up. In this case the "budget -
> 1" is supposed to be the upper limit on what can be reported. I think
> it was assuming an unsigned value anyway.
> 
> Another alternative would be to default clean_complete to !!budget.
> Then if budget is 0 clean_complete would always return false.

So, among all the variants, which one to try? Or there was a separate
patch sent to address this?

Thanks.

-- 
  Oleksandr Natalenko (post-factum)
