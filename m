From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Wed, 22 Apr 2015 22:42:37 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Use a signed type to hold
 error codes
In-Reply-To: <1428706542.2729.128.camel@jtkirshe-mobl>
References: <20150410173636.9380.22272.stgit@mdrustad-wks.jf.intel.com>
 <1428706542.2729.128.camel@jtkirshe-mobl>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E17F8214A2@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Friday, April 10, 2015 3:56 PM
> To: Rustad, Mark D
> Cc: intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH] ixgbe: Use a signed type to hold error
> codes
> 
> On Fri, 2015-04-10 at 10:36 -0700, Mark D Rustad wrote:
> > Because error codes are negative, it only makes sense to consistently
> > use signed types when handling them. Also remove some explicit
> > comparisons with 0 on these variables.
> >
> > Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> 
> Thanks Mark, I have applied your patch to my queue.
> --
> git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
> dev-queue

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
