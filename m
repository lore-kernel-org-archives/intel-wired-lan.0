From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 29 Sep 2021 10:20:02 +0800
Subject: [Intel-wired-lan] [PATCH v7] ixgbe: let the xdpdrv work with
 more than 64 cpus
In-Reply-To: <a1ea0abaadc59bdbc6504a64bae594b059c26cdf.camel@intel.com>
References: <20210901101206.50274-1-kerneljasonxing@gmail.com>
 <CAL+tcoCOnCpxLXLyAxb+BgumQBpo2PPqSQXY=Xvs-8R48Om=cw@mail.gmail.com>
 <a1ea0abaadc59bdbc6504a64bae594b059c26cdf.camel@intel.com>
Message-ID: <CAL+tcoALdQQPy+9G_azrGqSugGcNjFfYqmf72aNRPahgggeeVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Sep 29, 2021 at 6:17 AM Nguyen, Anthony L
<anthony.l.nguyen@intel.com> wrote:
>
> On Thu, 2021-09-16 at 14:41 +0800, Jason Xing wrote:
> > Hello guys,
> >
> > any suggestions or comments on this v7 patch?
> >
> > Thanks,
> > Jason
> >
> > On Wed, Sep 1, 2021 at 6:12 PM <kerneljasonxing@gmail.com> wrote:
> > > From: Jason Xing <xingwanli@kuaishou.com>
> > >
> > > Originally, ixgbe driver doesn't allow the mounting of xdpdrv if
> > > the
> > > server is equipped with more than 64 cpus online. So it turns out
> > > that
> > > the loading of xdpdrv causes the "NOMEM" failure.
> > >
> > > Actually, we can adjust the algorithm and then make it work through
> > > mapping the current cpu to some xdp ring with the protect of
> > > @tx_lock.
> > >
> > > Here're some numbers before/after applying this patch with xdp-
> > > example
> > > loaded on the eth0X:
> > >
> > > As client (tx path):
> > >                      Before    After
> > > TCP_STREAM send-64   734.14    714.20
> > > TCP_STREAM send-128  1401.91   1395.05
> > > TCP_STREAM send-512  5311.67   5292.84
> > > TCP_STREAM send-1k   9277.40   9356.22 (not stable)
> > > TCP_RR     send-1    22559.75  21844.22
> > > TCP_RR     send-128  23169.54  22725.13
> > > TCP_RR     send-512  21670.91  21412.56
> > >
> > > As server (rx path):
> > >                      Before    After
> > > TCP_STREAM send-64   1416.49   1383.12
> > > TCP_STREAM send-128  3141.49   3055.50
> > > TCP_STREAM send-512  9488.73   9487.44
> > > TCP_STREAM send-1k   9491.17   9356.22 (not stable)
> > > TCP_RR     send-1    23617.74  23601.60
> > > ...
> > >
> > > Notice: the TCP_RR mode is unstable as the official document
> > > explaines.
> > >
> > > I tested many times with different parameters combined through
> > > netperf.
> > > Though the result is not that accurate, I cannot see much influence
> > > on
> > > this patch. The static key is places on the hot path, but it
> > > actually
> > > shouldn't cause a huge regression theoretically.
> > >
> > > Fixes: 33fdc82f08 ("ixgbe: add support for XDP_TX action")
>
> Hi Jason,
>
> The patch doesn't have an explicit target of net or net-next. I assume
> since you put a Fixes tag you're wanting it to go through net, however,
> this seems more like an improvement that should go through net-next.

Yes, it is like an improvement. At first I wanted to label it as net,
but it isn't a fix as you said. So I agree with you and please help me
send it to net-next.

thanks,
Jason

> Please let me know if you disagree, otherwise I will send to net-next.
>
> Thanks,
> Tony
>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Co-developed-by: Shujin Li <lishujin@kuaishou.com>
> > > Signed-off-by: Shujin Li <lishujin@kuaishou.com>
> > > Signed-off-by: Jason Xing <xingwanli@kuaishou.com>
> >
