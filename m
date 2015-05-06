From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Wed, 6 May 2015 19:47:42 +0000
Subject: [Intel-wired-lan] [PATCH v2 0/3] RSS fix for ixgbe/ixgbevf
In-Reply-To: <1430398781.2669.110.camel@jtkirshe-mobl>
References: <1430276261-29821-1-git-send-email-fan.du@intel.com>
 <1430398781.2669.110.camel@jtkirshe-mobl>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E17F8287BF@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Thursday, April 30, 2015 6:00 AM
> To: Du, Fan
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH v2 0/3] RSS fix for ixgbe/ixgbevf
> 
> On Wed, 2015-04-29 at 10:57 +0800, Fan Du wrote:
> > This patchset provides RSS hash value for upper stack by indicating
> > whether it's a L3 or L4 hash. Thus other component of network stack
> > could utilize this hash value provided by NIC without caculating by
> > themselves.
> >
> > Test:
> > * Simple iperf test using ixgbe for 82599ES
> > * Build test only for ixgbevf
> > * make C=1 CF=-D__CHECK_ENDIAN__, no warnings introduced by this
> > patchset
> >
> > Changelog:
> > v2:
> >   - Add patch3 to make all hash value from RSS part.
> > v1:
> >   - Code style issue suggeted by Tantilov, Emil S.
> >   - Initial version
> >
> > Fan Du (3):
> >   ixgbe: Specify rx hash type wrt rx desc RSS type
> >   ixgbevf: Set rx hash type for ingress packets
> >   ixgbe: Don't report flow director filter's status
> >
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c    |    2 -
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |   25 ++++++++++++++++---
> >  drivers/net/ethernet/intel/ixgbevf/defines.h      |   12 +++++++++
> >  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   27
> +++++++++++++++++++++
> >  4 files changed, 60 insertions(+), 6 deletions(-)
> >
> 
> Thanks Fan, I have added your series to my queue for further review and testing.

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
