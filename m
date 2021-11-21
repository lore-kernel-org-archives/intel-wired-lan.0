From: Danielle Ratson <danieller@nvidia.com>
Date: Sun, 21 Nov 2021 11:44:51 +0000
Subject: [Intel-wired-lan] [igb] netconsole triggers warning in
 netpoll_poll_dev
In-Reply-To: <CAKgT0UfGvcGXAC5VBjXRpR5Y5uAPEPPCsYWjQR8RmW_1kw8TMQ@mail.gmail.com>
References: <DM6PR12MB45165BFF3AB84602238FA595D89B9@DM6PR12MB4516.namprd12.prod.outlook.com>
 <CAKgT0UfGvcGXAC5VBjXRpR5Y5uAPEPPCsYWjQR8RmW_1kw8TMQ@mail.gmail.com>
Message-ID: <DM6PR12MB45162662DF7FAF82E7BD2207D89E9@DM6PR12MB4516.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> > > >  drivers/net/ethernet/intel/igb/igb_main.c | 12 ++++++++----
> > > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
> > > > b/drivers/net/ethernet/intel/igb/igb_main.c
> > > > index 0cd37ad81b4e..b0a9bed14071 100644
> > > > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > > > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > > > @@ -7991,12 +7991,16 @@ static void igb_ring_irq_enable(struct
> > > igb_q_vector *q_vector)
> > > >   **/
> > > >  static int igb_poll(struct napi_struct *napi, int budget)  {
> > > > -       struct igb_q_vector *q_vector = container_of(napi,
> > > > -                                                    struct igb_q_vector,
> > > > -                                                    napi);
> > > > -       bool clean_complete = true;
> > > > +       struct igb_q_vector *q_vector;
> > > > +       bool clean_complete;
> > > >         int work_done = 0;
> > > >
> > > > +       /* if budget is zero, we have a special case for netconsole, so
> > > > +        * make sure to set clean_complete to false in that case.
> > > > +        */
> > > > +       clean_complete = !!budget;
> > > > +
> > > > +       q_vector = container_of(napi, struct igb_q_vector, napi);
> > > >  #ifdef CONFIG_IGB_DCA
> > > >         if (q_vector->adapter->flags & IGB_FLAG_DCA_ENABLED)
> > > >                 igb_update_dca(q_vector);
> > >
> > > I'm not a big fan of moving the q_vector init as a part of this
> > > patch since it just means more backport work.
> > >
> > > That said the change itself should be harmless so I am good with it
> > > either way.
> > >
> > > Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
> >
> > Hi,
> >
> > I have lately added the netconsole module, and since then we see the
> same warning constantly in the logs.
> > I have tried to apply Jesse's patch but it didn't seem to solve the issue.
> >
> > Did anyone managed to solve the issue and can share with us?
> >
> > Thanks,
> > Danielle
> 
> The one issue I can see is that it basically leaves the igb_poll call stuck in
> polling mode.
> 
> The easiest fix for all of this in the in-kernel driver is to just get rid of the
> "min" at the end and instead just "return work_done;". The extra
> complication is only needed if you were to be polling multiple queues and
> that isn't the case here so we should simplify it and get rid of the buggy
> "budget - 1" return value.

Thank you very much for your reply Alexander!
It seems to work well!

Are you planning to send it upstream?

Thanks,
Danielle

