From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 03 Oct 2018 14:06:58 -0700
Subject: [Intel-wired-lan] i40e Q
In-Reply-To: <d4f60ae6ded4f39c6c912c6bc971394b9ed6d81d.camel@coverfire.com>
References: <f3c0595d07643496e1d3f411bfaab2deec93d750.camel@coverfire.com>
 <09ad93bed0f6d9e0abe79e79953b83050e3e7a8a.camel@intel.com>
 <d4f60ae6ded4f39c6c912c6bc971394b9ed6d81d.camel@coverfire.com>
Message-ID: <cb8104d446604cdea1659ca1cd303e845236efa0.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2018-10-03 at 13:08 -0400, Dan Siemon wrote:
> On Wed, 2018-10-03 at 08:04 -0700, Jeff Kirsher wrote:
> > On Tue, 2018-10-02 at 22:24 -0400, Dan Siemon wrote:
> > > Sorry for the direct email but I see on Netdev that you do some
> > > work
> > > on
> > > the i40e driver so I'm hoping you can point me in the right
> > > direction
> > > or to the right forum/person.
> > > 
> > > We have a product based on the X710 and Linux. We occasionally
> see
> > > kernel error messages like the one pasted below. Our product
> > > creates
> > > a
> > > large number of qdiscs, this may be related to tearing down the
> > > qdisc
> > > hierarchy.
> > > 
> > > I'd appreciate any help you can give.
> > 
> > Adding the intel-wired-lan mailing list, as well as the current
> i40e
> > maintainer...
> > 
> > What kernel are you running?
> > Also can you provide the output of lspci -vvv for the network
> > interface?
> > 
> > You say you are running with a large number of qdiscs, can you
> > provide
> > the setup/configuration that you are running?  It would be helpful
> in
> > trying to reproduce the issue in-house and so we can debug the
> issue.
> 
> Thank you for taking the time to forward this on.
> 
> The kernel version is 4.18.X, I don't recall which point release the
> below dump below is from. I've seen similar errors on 4.17 and
> probably
> 4.16 as well though I don't have dumps from those available.
> 
> I have attached the lspci output.
> 
> The qdisc config is essentially a large flat tree of HTB classes each
> with an FQ-CoDel qdisc attached (an eBPF program directs traffic to
> the
> appropriate class). At the moment I can't reproduce that easily
> without
> our software but I can write a script to create the same structure if
> that would be helpful.

If you could provide a script to create the same structure, that would
be good.  You will most likely need to tar it up or put it in a text
file to ensure it does not get stripped by mail servers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20181003/cceacf73/attachment.asc>
