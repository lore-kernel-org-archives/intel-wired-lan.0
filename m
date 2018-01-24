From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 24 Jan 2018 03:41:36 +0000
Subject: [Intel-wired-lan] [PATCH] igb: add VF trust infrastructure
In-Reply-To: <CAKgT0Uemj7-ZQDzmMoUppp22iuSEcPj7JECFmhbx-WV9qg_4Jw@mail.gmail.com>
References: <20180117105339.9336-1-vinschen@redhat.com>
 <20180122085441.GR18814@calimero.vinschen.de>
 <CAKgT0Uemj7-ZQDzmMoUppp22iuSEcPj7JECFmhbx-WV9qg_4Jw@mail.gmail.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C7B808B@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, January 22, 2018 2:58 PM
> To: intel-wired-lan <intel-wired-lan@lists.osuosl.org>; Netdev
> <netdev@vger.kernel.org>
> Cc: Corinna Vinschen <vinschen@redhat.com>
> Subject: Re: [Intel-wired-lan] [PATCH] igb: add VF trust infrastructure
> 
> Hi Corinna,
> 
> I've looked over the patch and didn't see any issues. My understanding
> is that Jeff has pulled it into his tree and it should be going
> through testing shortly.

Indeed it is / was ;)

> 
> Thanks.
> 
> - Alex
> 
> On Mon, Jan 22, 2018 at 12:54 AM, Corinna Vinschen
> <vinschen@redhat.com> wrote:
> > Hi,
> >
> > Could somebody please review this patch?
> >
> >
> > Thanks,
> > Corinna
> >
> >
> > On Jan 17 11:53, Corinna Vinschen wrote:
> >> * Add a per-VF value to know if a VF is trusted, by default don't
> >>   trust VFs.
> >>
> >> * Implement netdev op to trust VFs (igb_ndo_set_vf_trust) and add
> >>   trust status to ndo_get_vf_config output.
> >>
> >> * Allow a trusted VF to change MAC and MAC filters even if MAC
> >>   has been administratively set.
> >>
> >> Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
> >> ---
> >>  drivers/net/ethernet/intel/igb/igb.h      |  1 +
> >>  drivers/net/ethernet/intel/igb/igb_main.c | 30
> +++++++++++++++++++++++++++---
> >>  2 files changed, 28 insertions(+), 3 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
