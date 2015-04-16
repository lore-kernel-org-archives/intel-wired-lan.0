From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 16 Apr 2015 03:59:02 +0000
Subject: [Intel-wired-lan] [net-next] e100: don't initialize int object
 to zero
In-Reply-To: <1428447545.28000.4.camel@jtkirshe-mobl>
References: <1428273124-14321-1-git-send-email-sakiwit@gmail.com>
 <1428447545.28000.4.camel@jtkirshe-mobl>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B78DA39AC@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Tuesday, April 07, 2015 3:59 PM
> To: J?an Sacren
> Cc: intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [net-next] e100: don't initialize int
> object to zero
> 
> On Sun, 2015-04-05 at 16:32 -0600, J?an Sacren wrote:
> > From: Jean Sacren <sakiwit@gmail.com>
> >
> > 'err' will be overwritten so no need to initialize it to zero.
> >
> > Signed-off-by: Jean Sacren <sakiwit@gmail.com>
> > ---
> >  drivers/net/ethernet/intel/e100.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Thanks Jean, I have applied your patch to my queue.
> --
> git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
> dev-queue

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
