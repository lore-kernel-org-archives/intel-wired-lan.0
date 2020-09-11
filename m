From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Fri, 11 Sep 2020 14:29:50 +0200
Subject: [Intel-wired-lan] [PATCH net-next] i40e: allow VMDQs to be used
 with AF_XDP zero-copy
In-Reply-To: <20200911120519.GA9758@ranger.igk.intel.com>
References: <1599826106-19020-1-git-send-email-magnus.karlsson@gmail.com>
 <20200911120519.GA9758@ranger.igk.intel.com>
Message-ID: <CAJ8uoz3ctVoANjiO_nQ38YA-JoB0nQH1B4W01AZFw3iCyCC_+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Sep 11, 2020 at 2:11 PM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Fri, Sep 11, 2020 at 02:08:26PM +0200, Magnus Karlsson wrote:
> > From: Magnus Karlsson <magnus.karlsson@intel.com>
> >
> > Allow VMDQs to be used with AF_XDP sockets in zero-copy mode. For some
> > reason, we only allowed main VSIs to be used with zero-copy, but
> > there is now reason to not allow VMDQs also.
>
> You meant 'to allow' I suppose. And what reason? :)

Yes, sorry. Should be "not to allow". I was too trigger happy ;-).

I have gotten requests from users that they want to use VMDQs in
conjunction with containers. Basically small slices of the i40e
portioned out as netdevs. Do you see any problems with using a VMDQ
iwth zero-copy?

/Magnus

> >
> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > index 2a1153d..ebe15ca 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > @@ -45,7 +45,7 @@ static int i40e_xsk_pool_enable(struct i40e_vsi *vsi,
> >       bool if_running;
> >       int err;
> >
> > -     if (vsi->type != I40E_VSI_MAIN)
> > +     if (!(vsi->type == I40E_VSI_MAIN || vsi->type == I40E_VSI_VMDQ2))
> >               return -EINVAL;
> >
> >       if (qid >= vsi->num_queue_pairs)
> > --
> > 2.7.4
> >
