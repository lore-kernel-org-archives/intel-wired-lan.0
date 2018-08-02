From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 2 Aug 2018 18:33:04 +0000
Subject: [Intel-wired-lan] [next PATCH S93 08/11] i40e: fix warning
 about shadowed ring parameter
In-Reply-To: <20180731104148.11896-8-alice.michael@intel.com>
References: <20180731104148.11896-1-alice.michael@intel.com>
 <20180731104148.11896-8-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2DB382@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, July 31, 2018 3:42 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S93 08/11] i40e: fix warning about
> shadowed ring parameter
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> In commit 147e81ec7568 ("i40e: Test memory before ethtool alloc succeeds")
> code was added to handle ring allocation on systems with low memory.
> 
> It shadowed the ring parameter pointer by introducing a local ring pointer
> inside the for loop. Most of the code in the loop already just accessed the
> ring via &rx_rings[i]. Since most of the code already does this, just remove
> the local variable.
> 
> If someone considers it worth keeping a local around, they should use it for
> the whole section instead of just a couple of accesses.
> 
> This fixes a warning when -Wshadow is enabled
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


