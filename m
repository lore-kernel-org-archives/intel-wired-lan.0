From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 03 Aug 2015 15:51:08 -0700
Subject: [Intel-wired-lan] [PATCH 0/2] igb/ixgbe: Fix ordering of SR-IOV
	teardown
In-Reply-To: <20150729.143141.657802657776347202.davem@davemloft.net>
References: <20150727223753.10121.78169.stgit@gimli.home>
 <20150729.121630.2264285348757503000.davem@davemloft.net>
 <1438198387.13460.68.camel@redhat.com>
 <20150729.143141.657802657776347202.davem@davemloft.net>
Message-ID: <1438642268.3467.8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2015-07-29 at 14:31 -0700, David Miller wrote:
> From: Alex Williamson <alex.williamson@redhat.com>
> Date: Wed, 29 Jul 2015 13:33:07 -0600
> 
> > I expect that's because of this patch that's in Jeff's dev-queue branch:
> > 
> > http://git.kernel.org/cgit/linux/kernel/git/jkirsher/next-queue.git/commit/?h=dev-queue&id=ddf766a812a13eca1116b5905e902184904266f9
> > 
> > I based these patches off that branch, assuming they'd take the same
> > route and avoid the merge conflict.  If you'd rather take these, I'll be
> > happy to respin.  Apologies for not noting the base branch in the
> > series.  Thanks,
> 
> No, that's fine, this would normally go via Jeff's tree anyways.
> 
> I just didn't see him take it so I assumed that it should go via me.

Sorry, was on vacation last week and cell coverage was spotty where I
was at.  I have picked up the series.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150803/aee7f638/attachment.asc>
