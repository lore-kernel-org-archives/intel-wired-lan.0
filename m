From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 23 Mar 2017 22:25:24 -0700
Subject: [Intel-wired-lan] [next PATCH S63 5/6] i40e/i40evf: Add
 legacy-rx private flag to allow fallback to old Rx flow
In-Reply-To: <1490332661.5679.27.camel@intel.com>
References: <1489511727-10959-1-git-send-email-bimmy.pujari@intel.com>
 <1489511727-10959-5-git-send-email-bimmy.pujari@intel.com>
 <CAKgT0UcRcspygmMMK68ZyDouVCu5tBmAd496vuUyYku3xb9jvw@mail.gmail.com>
 <CAKgT0Ud_TSJK41zY9xyGmyvURUiO_EW6M17J7hRUYRZDULyPCA@mail.gmail.com>
 <1490332661.5679.27.camel@intel.com>
Message-ID: <1490333124.5679.29.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2017-03-23 at 22:17 -0700, Jeff Kirsher wrote:
> On Thu, 2017-03-23 at 21:23 -0700, Alexander Duyck wrote:
> > On Fri, Mar 17, 2017 at 8:57 AM, Alexander Duyck
> > <alexander.duyck@gmail.com> wrote:
> > > On Tue, Mar 14, 2017 at 10:15 AM, Bimmy Pujari <bimmy.pujari@inte
> l.
> > > com> wrote:
> > > > From: Alexander Duyck <alexander.h.duyck@intel.com>
> > > >?
> > > > This patch adds a control which will allow us to toggle into
> and
> > > > out of the
> > > > legacy Rx mode.? The legacy Rx mode is what we currently do
> when
> > > > performing
> > > > Rx.? As I make further changes what should happen is that the
> > > > driver will
> > > > fall back to the behavior for Rx as of this patch should the
> > > > "legacy-rx"
> > > > flag be set to on.
> > > >?
> > > > Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> > > > Change-ID: I0342998849bbb31351cce05f6e182c99174e7751
> > > > ---
> > > > Testing Hints:
> > > > ???????? This flag should not appear on kernels prior to 4.10.
> > > > ???????? On kernels 4.10 and later the "legacy-rx" flag should
> > > > appear
> > > > ???????? and can be toggled between on and off. As we add more
> > > > features the
> > > > ???????? behavior of the driver should change when this value
> is
> > > > toggled.
> > > >?
> > > > ???????? Toggling this for now will only cause a reset of the
> > > > interface.
> > > >?
> > > > ???????? For the VF we are specifically replacing the define
> that
> > > > was
> > > > ???????? stripping the code for the flag needed for the
> "legacy-
> > > > rx" flag
> > > > ???????? since it doesn't make sense to have the interface
> > > > defined when
> > > > ???????? there are no flags present.? In the case of a kernel
> > > > build the
> > > > ???????? #ifdefs should be stripped and the code will remain.
> > > >?
> > > > ? drivers/net/ethernet/intel/i40e/i40e.h???????????? |?? 1 +
> > > > ? drivers/net/ethernet/intel/i40e/i40e_ethtool.c???? |?? 5 +-
> > > > ? drivers/net/ethernet/intel/i40evf/i40evf.h???????? |?? 2 +
> > > > ? drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 104
> > > > +++++++++++++++++++++
> > > > ? 4 files changed, 111 insertions(+), 1 deletion(-)
> > > >?
> > > > diff --git a/drivers/net/ethernet/intel/i40e/i40e.h
> > > > b/drivers/net/ethernet/intel/i40e/i40e.h
> > > > index dcba258..561fe1f 100644
> > > > --- a/drivers/net/ethernet/intel/i40e/i40e.h
> > > > +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> > > > @@ -430,6 +430,7 @@ struct i40e_pf {
> > > > ? #define I40E_FLAG_TEMP_LINK_POLLING??????????? BIT_ULL(55)
> > > > ? #define I40E_FLAG_CLIENT_L2_CHANGE???????????? BIT_ULL(56)
> > > > ? #define I40E_FLAG_WOL_MC_MAGIC_PKT_WAKE???????????????
> > > > BIT_ULL(57)
> > > > +#define I40E_FLAG_LEGACY_RX??????????????????? BIT_ULL(57)
> > >?
> > > It looks like we lost sync between upstream and out-of-tree at
> some
> > > point.? We are defining both of these using the same bit.? We
> need
> > > to
> > > use a different value for the LEGACY_RX bit in the upstream it
> > > looks
> > > like.
> >?
> > Any chance we can get a fix for this?? It has been almost a week
> > since
> > I pointed out that we have a duplicate bit here, and I haven't seen
> > any updates.
> >?
> > We either need to submit a new version of this patch with us
> setting
> > I40E_FLAG_LEGACY_RX as bit 58, or if we can just get the tweak made
> > to
> > the patch while it is in the tree I would be good with that as
> well.
> > We have some other patches that are going to be adding some more
> > flags
> > in the pipeline and I would rather not have to push a fix for this
> > and
> > instead have it fixed in the patch.
> 
> I will fix this inline, so no need to resubmit with the desired fix.

Ok I have made the change, but in the process of making this fix, I see
there is a fairly significant disconnect between upstream and the out-
of-tree driver when it looking at these flag values.

I will see if I can come up with either a internal patch or kernel
patch to at least clean up these flag value out of sync issue.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170323/3ea061b9/attachment.asc>
