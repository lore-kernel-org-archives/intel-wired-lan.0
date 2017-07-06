From: Greg Rose <gvrose8192@gmail.com>
Date: Thu, 6 Jul 2017 15:24:33 +0100
Subject: [Intel-wired-lan] [PATCH 1/2] i40e/i40evf: rename
 vf_offload_flags to vf_cap_flags in struct virtchnl_vf_resource
In-Reply-To: <9BBC4E0CF881AA4299206E2E1412B62650490D08@ORSMSX102.amr.corp.intel.com>
References: <20170629131225.9251-1-sassmann@kpanic.de>
 <20170629131225.9251-2-sassmann@kpanic.de>
 <9BBC4E0CF881AA4299206E2E1412B62650490D08@ORSMSX102.amr.corp.intel.com>
Message-ID: <CALgkqUpFST=oiS+yAFpkCiRS6JPqVg9R7_+3GMNvWoVnB_zoXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jul 5, 2017 at 10:15 PM, Wyborny, Carolyn
<carolyn.wyborny@intel.com> wrote:
>
> > -----Original Message-----
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> > Of Stefan Assmann
> > Sent: Thursday, June 29, 2017 6:12 AM
> > To: intel-wired-lan at lists.osuosl.org
> > Cc: netdev at vger.kernel.org; davem at davemloft.net; sassmann at kpanic.de
> > Subject: [Intel-wired-lan] [PATCH 1/2] i40e/i40evf: rename vf_offload_flags to
> > vf_cap_flags in struct virtchnl_vf_resource
> >
> > The current name of vf_offload_flags indicates that the bitmap is
> > limited to offload related features. Make this more generic by renaming
> > it to vf_cap_flags, which allows for other capabilities besides
> > offloading to be added.
> >
> > Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> > ---
>
> Hello Stefan,
>
> Thanks for the patch series, but we believe the vf should be ignorant of its trusted status.

Hi Carolyn,

Might I ask why?

Thanks,

- Greg
