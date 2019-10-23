From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 23 Oct 2019 02:10:09 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v2 2/2] e1000e: Drop
 unnecessary __E1000_DOWN bit twiddling
In-Reply-To: <20191011153459.22313.17985.stgit@localhost.localdomain>
References: <20191011153219.22313.60179.stgit@localhost.localdomain>
 <20191011153459.22313.17985.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B97154E17@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Alexander Duyck
> Sent: Friday, October 11, 2019 8:35 AM
> To: alexander.h.duyck at linux.intel.com; intel-wired-lan at lists.osuosl.org;
> Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; zdai at us.ibm.com; zdai at linux.vnet.ibm.com
> Subject: [Intel-wired-lan] [next-queue PATCH v2 2/2] e1000e: Drop
> unnecessary __E1000_DOWN bit twiddling
> 
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> Since we no longer check for __E1000_DOWN in e1000e_close we can drop
> the
> spot where we were restoring the bit. This saves us a bit of unnecessary
> complexity.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
