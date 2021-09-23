From: Leon Romanovsky <leon@kernel.org>
Date: Fri, 24 Sep 2021 02:11:19 +0300
Subject: [Intel-wired-lan] [PATCH net-next 1/6] bnxt_en: Check devlink
 allocation and registration status
In-Reply-To: <CAKOOJTz4A2ER8MQE1dW27Spocds09SYafjeuLcFDJ0nL6mKyOw@mail.gmail.com>
References: <cover.1632420430.git.leonro@nvidia.com>
 <e7708737fadf4fe6f152afc76145c728c201adad.1632420430.git.leonro@nvidia.com>
 <CAKOOJTz4A2ER8MQE1dW27Spocds09SYafjeuLcFDJ0nL6mKyOw@mail.gmail.com>
Message-ID: <YU0JlzFOa7kpKgnd@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Sep 23, 2021 at 02:11:40PM -0700, Edwin Peer wrote:
> On Thu, Sep 23, 2021 at 11:13 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > From: Leon Romanovsky <leonro@nvidia.com>
> >
> > devlink is a software interface that doesn't depend on any hardware
> > capabilities. The failure in SW means memory issues, wrong parameters,
> > programmer error e.t.c.
> >
> > Like any other such interface in the kernel, the returned status of
> > devlink APIs should be checked and propagated further and not ignored.
> >
> > Fixes: 4ab0c6a8ffd7 ("bnxt_en: add support to enable VF-representors")
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c         |  5 ++++-
> >  drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c | 13 ++++++-------
> >  drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.h | 13 -------------
> >  3 files changed, 10 insertions(+), 21 deletions(-)

<...>

> > @@ -835,9 +837,6 @@ void bnxt_dl_unregister(struct bnxt *bp)
> >  {
> >         struct devlink *dl = bp->dl;
> >
> > -       if (!dl)
> > -               return;
> > -
> 
> minor nit: There's obviously nothing incorrect about doing this (and
> adding the additional error label in the cleanup code above), but bnxt
> has generally adopted a style of having cleanup functions being
> idempotent. It generally makes error handling simpler and less error
> prone.

I would argue that opposite is true. Such "impossible" checks hide unwind
flow errors, missing releases e.t.c.

<...>

> >
> 
> Reviewed-by: Edwin Peer <edwin.peer@broadcom.com>

Thanks for the review.


> 
> Regards,
> Edwin Peer
