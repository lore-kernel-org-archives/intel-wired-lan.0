From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 10 May 2021 08:06:00 +0200
Subject: [Intel-wired-lan] [PATCH intel-net 0/5] i40e: ice: ixgbe:
 ixgbevf: igb: add correct exception tracing for XDP
In-Reply-To: <75d0a1d13a755bc128458c0d43f16d54fe08051e.camel@intel.com>
References: <20210423100446.15412-1-magnus.karlsson@gmail.com>
 <75d0a1d13a755bc128458c0d43f16d54fe08051e.camel@intel.com>
Message-ID: <CAJ8uoz0Pgfn8kai34_MFGYv3m7c24bpo4DhjZ8oLgd4zaGMWsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, May 8, 2021 at 12:58 AM Nguyen, Anthony L
<anthony.l.nguyen@intel.com> wrote:
>
> On Fri, 2021-04-23 at 12:04 +0200, Magnus Karlsson wrote:
> > Add missing exception tracing to XDP when a number of different
> > errors
> > can occur. The support was only partial. Several errors where not
> > logged which would confuse the user quite a lot not knowing where and
> > why the packets disappeared.
> >
> > This patch set fixes this for all Intel drivers with XDP support.
> >
> > Thanks: Magnus
>
> This doesn't apply anymore with the 5.13 patches. It looks like your
> "optimize for XDP_REDIRECT in xsk path" patches are conflicting with
> some of these. Did you want to rework them?

I will rebase them and resubmit.

> Thanks,
> Tony
>
> > Magnus Karlsson (5):
> >   i40e: add correct exception tracing for XDP
> >   ice: add correct exception tracing for XDP
> >   ixgbe: add correct exception tracing for XDP
> >   igb add correct exception tracing for XDP
> >   ixgbevf: add correct exception tracing for XDP
> >
> >  drivers/net/ethernet/intel/i40e/i40e_txrx.c      |  7 ++++++-
> >  drivers/net/ethernet/intel/i40e/i40e_xsk.c       |  7 ++++++-
> >  drivers/net/ethernet/intel/ice/ice_txrx.c        | 12 +++++++++---
> >  drivers/net/ethernet/intel/ice/ice_xsk.c         |  7 ++++++-
> >  drivers/net/ethernet/intel/igb/igb_main.c        | 10 ++++++----
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 16 ++++++++----
> > ----
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c     | 13 ++++++++-----
> >  .../net/ethernet/intel/ixgbevf/ixgbevf_main.c    |  3 +++
> >  8 files changed, 52 insertions(+), 23 deletions(-)
> >
> >
> > base-commit: bb556de79f0a9e647e8febe15786ee68483fa67b
> > --
> > 2.29.0
