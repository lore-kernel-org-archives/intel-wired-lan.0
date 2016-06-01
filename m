From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 01 Jun 2016 07:56:45 -0700
Subject: [Intel-wired-lan] [PATCH 5/5] ethernet: Use
	pci_(request|release)_mem_regions
In-Reply-To: <20160601085112.ve6k7bzspapjsswf@c203.arch.suse.de>
References: <cover.1464694724.git.jthumshirn@suse.de>
 <3f24b687c31dea31a03cd3a529de790e942dd5bb.1464694724.git.jthumshirn@suse.de>
 <20160601075956.GD11923@infradead.org>
 <20160601085112.ve6k7bzspapjsswf@c203.arch.suse.de>
Message-ID: <1464793005.2960.3.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-06-01 at 10:51 +0200, Johannes Thumshirn wrote:
> On Wed, Jun 01, 2016 at 12:59:56AM -0700, Christoph Hellwig wrote:
> > On Tue, May 31, 2016 at 02:05:13PM +0200, Johannes Thumshirn wrote:
> > > Now that we do have pci_request_mem_regions() and
> pci_release_mem_regions() at
> > > hand, use it in the ethernet drivers.
> >?
> > This should probably be one patch per driver.
> 
> I though if I do one patch per subsystem it'll be less a hassle for the
> individual maintainers, but if the netdev people want it as split up,
> I'll be
> doing it of cause.

Since almost all the changes are to Intel wired LAN drivers, if you just
split off the atheros change into a separate patch, I would be happy. ?Then
you could keep just one patch to change all the Intel drivers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160601/1368fa74/attachment.asc>
