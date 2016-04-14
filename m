From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 14 Apr 2016 17:19:54 +0000
Subject: [Intel-wired-lan] [PATCH v2 13/13] e1000e: fix misuse of
 ret_val variable and error handling
In-Reply-To: <1460616080.2960.53.camel@intel.com>
References: <1460588914-20143-1-git-send-email-jacob.e.keller@intel.com>
 <1460588914-20143-14-git-send-email-jacob.e.keller@intel.com>
 <1460616080.2960.53.camel@intel.com>
Message-ID: <1460654394.28210.0.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-04-13 at 23:41 -0700, Jeff Kirsher wrote:
> On Wed, 2016-04-13 at 16:08 -0700, Jacob Keller wrote:
> > 
> > A patch introduced the use of ret_val variable but only assigned it
> > once
> > and didn't use it. e1000_probe already has a rval variable, which
> > is
> > what was checked, so remove use of ret_val in favor of rval.
> > 
> > Fixes: 7739e79c2ff7 ("e1000e: Fix ptp time reset on network
> > interruption", 2016-04-12)
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > ---
> > ?drivers/net/ethernet/intel/e1000e/netdev.c | 3 +--
> > ?1 file changed, 1 insertion(+), 2 deletions(-)
> Dropped, because it does not apply.

Ya, it looks like this got fixed by?f9c22b9ec50c ("e1000e: Cleanup
consistency in ret_val variable usage", 2016-04-13)

Thanks,
Jake
