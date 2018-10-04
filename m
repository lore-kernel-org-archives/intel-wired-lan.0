From: Dan Siemon <dan@coverfire.com>
Date: Thu, 04 Oct 2018 09:49:26 -0400
Subject: [Intel-wired-lan] i40e Q
In-Reply-To: <cb8104d446604cdea1659ca1cd303e845236efa0.camel@intel.com>
References: <f3c0595d07643496e1d3f411bfaab2deec93d750.camel@coverfire.com>
 <09ad93bed0f6d9e0abe79e79953b83050e3e7a8a.camel@intel.com>
 <d4f60ae6ded4f39c6c912c6bc971394b9ed6d81d.camel@coverfire.com>
 <cb8104d446604cdea1659ca1cd303e845236efa0.camel@intel.com>
Message-ID: <11470a947ce16e68e0bc802cf8f1afcf09ee3f53.camel@coverfire.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2018-10-03 at 14:06 -0700, Jeff Kirsher wrote:
> > The qdisc config is essentially a large flat tree of HTB classes
> > each
> > with an FQ-CoDel qdisc attached (an eBPF program directs traffic to
> > the
> > appropriate class). At the moment I can't reproduce that easily
> > without
> > our software but I can write a script to create the same structure
> > if
> > that would be helpful.
> 
> If you could provide a script to create the same structure, that
> would
> be good.  You will most likely need to tar it up or put it in a text
> file to ensure it does not get stripped by mail servers.

I have attached a tarball with a short script that approximates the
qdisc setup that we use. When we see this problem, most of the classes
are seeing some traffic. If you need a way to generate traffic for all
these classes, I can provide a small program that does that (it just
spoofs a bunch of UDP traffic).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: script.tar
Type: application/x-tar
Size: 10240 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20181004/b83ae322/attachment.tar>
