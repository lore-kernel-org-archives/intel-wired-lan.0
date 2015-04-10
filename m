From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Fri, 10 Apr 2015 23:12:11 +0000
Subject: [Intel-wired-lan] [PATCH net-next v10 6/7] ixgbevf: Add RSS
	Key	query code
In-Reply-To: <1427787373.2497.114.camel@jtkirshe-mobl>
References: <1427740529-9605-1-git-send-email-vladz@cloudius-systems.com>
 <1427740529-9605-7-git-send-email-vladz@cloudius-systems.com>
 <1427787373.2497.114.camel@jtkirshe-mobl>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E17F812FF2@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Tuesday, March 31, 2015 12:36 AM
> To: Vlad Zolotarov
> Cc: netdev at vger.kernel.org; avi at cloudius-systems.com; intel-wired-
> lan at lists.osuosl.org; gleb at cloudius-systems.com
> Subject: Re: [Intel-wired-lan] [PATCH net-next v10 6/7] ixgbevf: Add RSS Key
> query code
> 
> On Mon, 2015-03-30 at 21:35 +0300, Vlad Zolotarov wrote:
> > Add the ixgbevf_get_rss_key() function that queries the PF for an RSS
> > Random Key using a new VF-PF channel IXGBE_VF_GET_RSS_KEY command.
> >
> > This patch adds the support for 82599 and x540 devices only. Support
> > for other devices will be added later.
> >
> > Signed-off-by: Vlad Zolotarov <vladz@cloudius-systems.com>
> > ---
> > New in v10:
> >    - Expose the _locked function in the vf.h interface according
> >      to the current ixgbevf layering model.
> >    - Return EOPNOTSUPP in cases then operation is not supported.
> >
> > New in v9:
> >    - Reduce the support to 82599 and x540 devices only.
> >    - Added IXGBEVF_RSS_HASH_KEY_SIZE macro.
> >
> > New in v8:
> >    - Protect a mailbox access.
> >
> > New in v6:
> >    - Return a proper return code when an operation is blocked by PF.
> >
> > New in v2:
> >    - Added a more detailed patch description.
> >
> > New in v1 (compared to RFC):
> >    - Use "if-else" statement instead of a "switch-case" for a single
> > option case
> >      (in ixgbevf_get_rss_key()).
> > ---
> >  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h |  1 +
> >  drivers/net/ethernet/intel/ixgbevf/mbx.h     |  1 +
> >  drivers/net/ethernet/intel/ixgbevf/vf.c      | 54
> > ++++++++++++++++++++++++++++
> >  drivers/net/ethernet/intel/ixgbevf/vf.h      |  1 +
> >  4 files changed, 57 insertions(+)
> 
> Thanks Vlad, applied to my queue.
> --
> git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
> dev-queue

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
