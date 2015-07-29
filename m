From: David Miller <davem@davemloft.net>
Date: Wed, 29 Jul 2015 14:31:41 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH 0/2] igb/ixgbe: Fix ordering of SR-IOV
	teardown
In-Reply-To: <1438198387.13460.68.camel@redhat.com>
References: <20150727223753.10121.78169.stgit@gimli.home>
 <20150729.121630.2264285348757503000.davem@davemloft.net>
 <1438198387.13460.68.camel@redhat.com>
Message-ID: <20150729.143141.657802657776347202.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 29 Jul 2015 13:33:07 -0600

> I expect that's because of this patch that's in Jeff's dev-queue branch:
> 
> http://git.kernel.org/cgit/linux/kernel/git/jkirsher/next-queue.git/commit/?h=dev-queue&id=ddf766a812a13eca1116b5905e902184904266f9
> 
> I based these patches off that branch, assuming they'd take the same
> route and avoid the merge conflict.  If you'd rather take these, I'll be
> happy to respin.  Apologies for not noting the base branch in the
> series.  Thanks,

No, that's fine, this would normally go via Jeff's tree anyways.

I just didn't see him take it so I assumed that it should go via me.
