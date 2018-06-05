From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 5 Jun 2018 23:15:26 +0000
Subject: [Intel-wired-lan] [PATCH] igb: Use dma_wmb() instead of wmb()
 before doorbell writes
In-Reply-To: <CAKgT0UdovBv3gbcW6UOj1M6mn1++QuPifGj_ijYEfe11t=eJ+A@mail.gmail.com>
References: <20180525041321.140516-1-venkateshs@google.com>
 <CAKgT0UdovBv3gbcW6UOj1M6mn1++QuPifGj_ijYEfe11t=eJ+A@mail.gmail.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B964FEED6@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Friday, May 25, 2018 8:56 AM
> To: Venkatesh Srinivas <venkateshs@google.com>
> Cc: vsrinivas at ops101.org; intel-wired-lan <intel-wired-lan@lists.osuosl.org>
> Subject: Re: [Intel-wired-lan] [PATCH] igb: Use dma_wmb() instead of wmb()
> before doorbell writes
> 
> On Thu, May 24, 2018 at 9:13 PM, Venkatesh Srinivas
> <venkateshs@google.com> wrote:
> > igb writes to doorbells to post transmit and receive descriptors;
> > after writing descriptors to memory but before writing to doorbells,
> > use dma_wmb() rather than wmb(). wmb() is more heavyweight than
> > necessary before doorbell writes.
> >
> > On x86, this avoids SFENCEs before doorbell writes in both the
> > tx and rx refill paths.
> >
> > Signed-off-by: Venkatesh Srinivas <venkateshs@google.com>
> > ---
> >  drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
