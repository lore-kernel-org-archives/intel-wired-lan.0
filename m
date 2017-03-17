From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 17 Mar 2017 19:07:30 +0000
Subject: [Intel-wired-lan] [PART1 PATCH 05/11] i40e: exit ATR mode only
 when	adding TCP/IPv4 filter succeeds
In-Reply-To: <20170206223846.31052-6-jacob.e.keller@intel.com>
References: <20170206223846.31052-1-jacob.e.keller@intel.com>
 <20170206223846.31052-6-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10403055@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Monday, February 6, 2017 2:39 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PART1 PATCH 05/11] i40e: exit ATR mode only
> when adding TCP/IPv4 filter succeeds
> 
> Move ATR exit check after we have sent the TCP/IPv4 filter to the ring
> successfully. This avoids an issue where we potentially update the filter
> count without actually succeeding in adding the filter. Now, we only
> increment the fd_tcp_rule after we've succeeded. Additionally, we will re-
> enable ATR mode only after deletion of the filter is actually posted to the
> FDIR ring.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Williams, Mitch A <mitch.a.williams@intel.com>
> Change-ID: If5c1dea422081cc5e2de65618b01b4c3bf6bd586
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 34 ++++++++++++++-----------
> ----
>  1 file changed, 17 insertions(+), 17 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


