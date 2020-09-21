From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Mon, 21 Sep 2020 22:21:36 +0000
Subject: [Intel-wired-lan] [next-queue v7] igb: add XDP support
In-Reply-To: <20200921095821.jmle6qdcn2ksmtee@SvensMacbookPro.hq.voleatech.com>
References: <20200902203222.185141-1-anthony.l.nguyen@intel.com>
 <20200921095821.jmle6qdcn2ksmtee@SvensMacbookPro.hq.voleatech.com>
Message-ID: <bbb768aefcb41310f036477c015f101269c53444.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2020-09-21 at 11:58 +0200, Sven Auhagen wrote:
> On Wed, Sep 02, 2020 at 01:32:22PM -0700, Tony Nguyen wrote:
> > From: Sven Auhagen <Sven.Auhagen@voleatech.de>
> > 
> > Add XDP support to the IGB driver.
> > The implementation follows the IXGBE XDP implementation
> > closely and I used the following patches as basis:
> > 
> > 1. commit 924708081629 ("ixgbe: add XDP support for pass and drop
> > actions")
> > 2. commit 33fdc82f0883 ("ixgbe: add support for XDP_TX action")
> > 3. commit ed93a3987128 ("ixgbe: tweak page counting for
> > XDP_REDIRECT")
> > 
> > Due to the hardware constraints of the devices using the
> > IGB driver we must share the TX queues with XDP which
> > means locking the TX queue for XDP.
> > 
> > I ran tests on an older device to get better numbers.
> > Test machine:
> > 
> > Intel(R) Atom(TM) CPU C2338 @ 1.74GHz (2 Cores)
> > 2x Intel I211
> > 
> > Routing Original Driver Network Stack: 382 Kpps
> > 
> > Routing XDP Redirect (xdp_fwd_kern): 1.48 Mpps
> > XDP Drop: 1.48 Mpps
> > 
> > Using XDP we can achieve line rate forwarding even on
> > an older Intel Atom CPU.
> > 
> > Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
> 
> Hello Tony,
> 
> thanks for the patch update.
> How is the process to get this accepted?
> 
Hi Sven,

I've been waiting for validation to test this. When I get word that
everything is ok, I'll send the patch to net-next along with other 1Gb
changes.

Thanks,
Tony
