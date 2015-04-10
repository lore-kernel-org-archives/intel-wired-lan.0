From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Fri, 10 Apr 2015 23:12:51 +0000
Subject: [Intel-wired-lan] [PATCH net-next v10 1/7] if_link: Add an
 additional parameter to ifla_vf_info for RSS querying
In-Reply-To: <1427787296.2497.109.camel@jtkirshe-mobl>
References: <1427740529-9605-1-git-send-email-vladz@cloudius-systems.com>
 <1427740529-9605-2-git-send-email-vladz@cloudius-systems.com>
 <1427787296.2497.109.camel@jtkirshe-mobl>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E17F813045@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Tuesday, March 31, 2015 12:35 AM
> To: Vlad Zolotarov
> Cc: netdev at vger.kernel.org; avi at cloudius-systems.com; intel-wired-
> lan at lists.osuosl.org; gleb at cloudius-systems.com
> Subject: Re: [Intel-wired-lan] [PATCH net-next v10 1/7] if_link: Add an additional
> parameter to ifla_vf_info for RSS querying
> 
> On Mon, 2015-03-30 at 21:35 +0300, Vlad Zolotarov wrote:
> > Add configuration setting for drivers to allow/block an RSS
> > Redirection Table and a Hash Key querying for discrete VFs.
> >
> > On some devices VF share the mentioned above information with PF and
> > querying it may adduce a theoretical security risk. We want to let a
> > system administrator to decide if he/she wants to take this risk or
> > not.
> >
> > Signed-off-by: Vlad Zolotarov <vladz@cloudius-systems.com>
> > ---
> >  include/linux/if_link.h      |  1 +
> >  include/linux/netdevice.h    |  8 ++++++++
> >  include/uapi/linux/if_link.h |  8 ++++++++
> >  net/core/rtnetlink.c         | 32 ++++++++++++++++++++++++++------
> >  4 files changed, 43 insertions(+), 6 deletions(-)
> 
> Thanks Vlad, applied to my queue.
> --
> git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
> dev-queue

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
