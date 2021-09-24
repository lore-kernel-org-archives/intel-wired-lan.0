From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 23 Sep 2021 18:39:56 -0700
Subject: [Intel-wired-lan] [PATCH net-next 1/6] bnxt_en: Check devlink
 allocation and registration status
In-Reply-To: <YU0JlzFOa7kpKgnd@unreal>
References: <cover.1632420430.git.leonro@nvidia.com>
 <e7708737fadf4fe6f152afc76145c728c201adad.1632420430.git.leonro@nvidia.com>
 <CAKOOJTz4A2ER8MQE1dW27Spocds09SYafjeuLcFDJ0nL6mKyOw@mail.gmail.com>
 <YU0JlzFOa7kpKgnd@unreal>
Message-ID: <20210923183956.506bfde2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 24 Sep 2021 02:11:19 +0300 Leon Romanovsky wrote:
> > > @@ -835,9 +837,6 @@ void bnxt_dl_unregister(struct bnxt *bp)
> > >  {
> > >         struct devlink *dl = bp->dl;
> > >
> > > -       if (!dl)
> > > -               return;
> > > -  
> > 
> > minor nit: There's obviously nothing incorrect about doing this (and
> > adding the additional error label in the cleanup code above), but bnxt
> > has generally adopted a style of having cleanup functions being
> > idempotent. It generally makes error handling simpler and less error
> > prone.  
> 
> I would argue that opposite is true. Such "impossible" checks hide unwind
> flow errors, missing releases e.t.c.

+1, fwiw
