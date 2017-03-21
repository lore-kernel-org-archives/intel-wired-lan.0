From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 21 Mar 2017 16:45:00 +0000
Subject: [Intel-wired-lan] [next PATCH S63 5/6] i40e/i40evf: Add
 legacy-rx private flag to allow fallback to old Rx flow
In-Reply-To: <CAKgT0UcRcspygmMMK68ZyDouVCu5tBmAd496vuUyYku3xb9jvw@mail.gmail.com>
References: <1489511727-10959-1-git-send-email-bimmy.pujari@intel.com>
 <1489511727-10959-5-git-send-email-bimmy.pujari@intel.com>
 <CAKgT0UcRcspygmMMK68ZyDouVCu5tBmAd496vuUyYku3xb9jvw@mail.gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10406851@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Friday, March 17, 2017 8:58 AM
> To: Pujari, Bimmy <bimmy.pujari@intel.com>
> Cc: intel-wired-lan <intel-wired-lan@lists.osuosl.org>
> Subject: Re: [Intel-wired-lan] [next PATCH S63 5/6] i40e/i40evf: Add legacy-rx
> private flag to allow fallback to old Rx flow
> 
> On Tue, Mar 14, 2017 at 10:15 AM, Bimmy Pujari <bimmy.pujari@intel.com>
> wrote:
> > From: Alexander Duyck <alexander.h.duyck@intel.com>
> >
> > This patch adds a control which will allow us to toggle into and out
> > of the legacy Rx mode.  The legacy Rx mode is what we currently do
> > when performing Rx.  As I make further changes what should happen is
> > that the driver will fall back to the behavior for Rx as of this patch should
> the "legacy-rx"
> > flag be set to on.
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> > Change-ID: I0342998849bbb31351cce05f6e182c99174e7751
> > ---
> > Testing Hints:
> >         This flag should not appear on kernels prior to 4.10.
> >         On kernels 4.10 and later the "legacy-rx" flag should appear
> >         and can be toggled between on and off. As we add more features the
> >         behavior of the driver should change when this value is toggled.
> >
> >         Toggling this for now will only cause a reset of the interface.
> >
> >         For the VF we are specifically replacing the define that was
> >         stripping the code for the flag needed for the "legacy-rx" flag
> >         since it doesn't make sense to have the interface defined when
> >         there are no flags present.  In the case of a kernel build the
> >         #ifdefs should be stripped and the code will remain.
> >
> >  drivers/net/ethernet/intel/i40e/i40e.h             |   1 +
> >  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   5 +-
> >  drivers/net/ethernet/intel/i40evf/i40evf.h         |   2 +
> >  drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 104
> > +++++++++++++++++++++
> >  4 files changed, 111 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


