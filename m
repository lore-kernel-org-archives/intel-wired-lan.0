From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 20 Mar 2019 22:24:45 +0000
Subject: [Intel-wired-lan] [PATCH] checkpatch: fix camel case seeding
 when run with --root
In-Reply-To: <52138d9db7b1765133f21fe08b0f3ad37da9d799.camel@perches.com>
References: <20190315010334.5707-1-jacob.e.keller@intel.com>
 <02874ECE860811409154E81DA85FBB589232E64D@ORSMSX121.amr.corp.intel.com>
 <52138d9db7b1765133f21fe08b0f3ad37da9d799.camel@perches.com>
Message-ID: <02874ECE860811409154E81DA85FBB589232E843@ORSMSX121.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Joe Perches [mailto:joe at perches.com]
> Sent: Wednesday, March 20, 2019 2:18 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>; linux-kernel at vger.kernel.org;
> apw at canonical.com; Joe Perches <golf@perches.com>
> Cc: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>; netdev at vger.kernel.org
> Subject: Re: [PATCH] checkpatch: fix camel case seeding when run with --root
> 
> On Wed, 2019-03-20 at 20:09 +0000, Keller, Jacob E wrote:
> > > -----Original Message-----
> > > From: Keller, Jacob E
> > > Sent: Thursday, March 14, 2019 6:04 PM
> > > To: linux-kernel at vger.kernel.org
> > > Cc: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>; netdev at vger.kernel.org;
> > > Keller, Jacob E <jacob.e.keller@intel.com>; joe at perches.com
> > > Subject: [PATCH] checkpatch: fix camel case seeding when run with --root
> > >
> > > checkpatch.pl avoids warning about camel case of some definitions by
> > > seeding a file that tracks all of the currently committed camel case
> > > definitions.
> > >
> > > To build this seed file, checkpatch.pl decides between using git or the
> > > --root parameter.
> > >
> > > This works as long as you don't run checkpatch.pl from within
> > > a different git tree that is not the Linux kernel.
> 
> Odd use case, but I'll forward it on as it doesn't
> seem to have any other effect.
> 
> cheers, Joe

We run checkpatch.pl on Linux driver code which is out-of-tree to start with, and then will eventually be migrated into the in-tree kernel later as we develop it.

Without this patch, the use of checkpatch.pl with --root causes bogus hits with camel case issues.

Thanks,
Jake
