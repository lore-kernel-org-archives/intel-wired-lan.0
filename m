From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 11 Apr 2019 22:02:57 +0000
Subject: [Intel-wired-lan] [PATCH 4/5] ixgbe: use 'cc' instead of
 'hw_cc' for local variable
In-Reply-To: <20190408235202.10676-4-jacob.e.keller@intel.com>
References: <20190408235202.10676-1-jacob.e.keller@intel.com>
 <20190408235202.10676-4-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D38D236@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Monday, April 8, 2019 4:52 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH 4/5] ixgbe: use 'cc' instead of 'hw_cc' for
> local variable
> 
> The ixgbe_ptp.c file sometimes uses hw_cc as the local variable for the cycle
> counter in ixgbe_ptp_read_X550. However, we use just 'cc' as a local variable
> for this by convention else where in the file.
> 
> Convert this lone usage of 'hw_cc' into just the shorter 'cc' name to match
> the other read functions in the file.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


