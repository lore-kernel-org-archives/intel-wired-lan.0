From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 14 Sep 2016 17:43:55 -0700
Subject: [Intel-wired-lan] [net-next PATCH v3 1/3] e1000: track BQL
 bytes regardless of skb or not
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B81F90268@ORSMSX101.amr.corp.intel.com>
References: <20160912220312.5610.77528.stgit@john-Precision-Tower-5810>
 <20160912221327.5610.74333.stgit@john-Precision-Tower-5810>
 <309B89C4C689E141A5FF6A0C5FB2118B81F90268@ORSMSX101.amr.corp.intel.com>
Message-ID: <20160915004353.GA63116@ast-mbp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Sep 14, 2016 at 11:57:24PM +0000, Brown, Aaron F wrote:
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> > Behalf Of John Fastabend
> > Sent: Monday, September 12, 2016 3:13 PM
> > To: bblanco at plumgrid.com; john.fastabend at gmail.com;
> > alexei.starovoitov at gmail.com; Kirsher, Jeffrey T
> > <jeffrey.t.kirsher@intel.com>; brouer at redhat.com; davem at davemloft.net
> > Cc: xiyou.wangcong at gmail.com; intel-wired-lan at lists.osuosl.org;
> > u9012063 at gmail.com; netdev at vger.kernel.org
> > Subject: [Intel-wired-lan] [net-next PATCH v3 1/3] e1000: track BQL bytes
> > regardless of skb or not
> > 
> > The BQL API does not reference the sk_buff nor does the driver need to
> > reference the sk_buff to calculate the length of a transmitted frame.
> > This patch removes an sk_buff reference from the xmit irq path and
> > also allows packets sent from XDP to use BQL.
> > 
> > Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
> > ---
> >  drivers/net/ethernet/intel/e1000/e1000_main.c |    7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> This patch is causing all my e1000 adapters to fail a simple ftp session with really slow response (hashing on) followed by adapter resets.  I have seen this on 4 different e1000 nics now, an 82543GC, 82544GC, 82546EB and an 82545GM.  On a few occasions I get a splat captured to dmesg.  Here is an example:
> --------------------------------
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 0 at net/sched/sch_generic.c:316 dev_watchdog+0x1c2/0x1d0
> NETDEV WATCHDOG: eth1 (e1000): transmit queue 0 timed out

Thanks a lot for the tests! Really appreciate it.

