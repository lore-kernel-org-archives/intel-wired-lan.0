From: KY Srinivasan <kys@microsoft.com>
Date: Wed, 27 Apr 2016 18:33:30 +0000
Subject: [Intel-wired-lan] [PATCH net-next V5 2/2] intel: ixgbevf:
	Support	Windows hosts (Hyper-V)
In-Reply-To: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D2A6A@ORSMSX104.amr.corp.intel.com>
References: <1461118655-28103-1-git-send-email-kys@microsoft.com>
 <1461118677-28142-1-git-send-email-kys@microsoft.com>
 <1461118677-28142-2-git-send-email-kys@microsoft.com>
 <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D2A6A@ORSMSX104.amr.corp.intel.com>
Message-ID: <CH1PR03MB19153BF4C1251F8CAB3DF4CFA0640@CH1PR03MB1915.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bowers, AndrewX
> Sent: Friday, April 22, 2016 12:32 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH net-next V5 2/2] intel: ixgbevf: Support
> Windows hosts (Hyper-V)
> 
> > -----Original Message-----
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> > Behalf Of K. Y. Srinivasan
> > Sent: Tuesday, April 19, 2016 7:18 PM
> > To: davem at davemloft.net; netdev at vger.kernel.org; linux-
> > kernel at vger.kernel.org; devel at linuxdriverproject.org; olaf at aepfle.de;
> > apw at canonical.com; jasowang at redhat.com; eli at mellanox.com;
> > jackm at mellanox.com; yevgenyp at mellanox.com; Ronciak, John
> > <john.ronciak@intel.com>; intel-wired-lan at lists.osuosl.org;
> > alexander.duyck at gmail.com
> > Subject: [Intel-wired-lan] [PATCH net-next V5 2/2] intel: ixgbevf: Support
> > Windows hosts (Hyper-V)
> >
> > On Hyper-V, the VF/PF communication is a via software mediated path as
> > opposed to the hardware mailbox. Make the necessary adjustments to
> > support Hyper-V.
> >
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > ---
> > 	V2: Addressed most of the comments from
> > 	    Alexander Duyck <alexander.duyck@gmail.com>
> > 	    and Rustad, Mark D <mark.d.rustad@intel.com>.
> >
> > 	V3: Addressed additional comments from
> > 	    Alexander Duyck <alexander.duyck@gmail.com>
> >
> > 	V4: Addressed kbuild errors reported by:
> > 	    kbuild test robot <lkp@intel.com>
> >
> > 	V5: Addressed additional comments from
> > 	    Alexander Duyck <alexander.duyck@gmail.com>
> >
> >  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |   12 ++
> >  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   31 +++-
> >  drivers/net/ethernet/intel/ixgbevf/mbx.c          |   12 ++
> >  drivers/net/ethernet/intel/ixgbevf/vf.c           |  216
> > +++++++++++++++++++++
> >  drivers/net/ethernet/intel/ixgbevf/vf.h           |    2 +
> >  5 files changed, 266 insertions(+), 7 deletions(-)
> 
> Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
> VF driver correctly builds and changes correctly applied.

Andrew,

This is the first time I am submitting a patch to Intel. What is involved in getting this into David Miller's tree.
Should I submit these to net-next?

K. Y
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> https://na01.safelinks.protection.outlook.com/?url=http%3a%2f%2flists.osu
> osl.org%2fmailman%2flistinfo%2fintel-wired-
> lan&data=01%7c01%7ckys%40microsoft.com%7c7d63df5a7fa44a1adb7108d3
> 6ae4ceea%7c72f988bf86f141af91ab2d7cd011db47%7c1&sdata=GrSw%2fY6G
> qTRkotjWVIdXpG2fMrL5wp4zI2rmXJMhf%2fQ%3d
