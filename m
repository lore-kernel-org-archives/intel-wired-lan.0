From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Sat, 2 Mar 2019 00:08:49 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: fix i40e_ptp_adjtime when given
 a negative delta
In-Reply-To: <20190225192005.3233-1-jacob.e.keller@intel.com>
References: <20190225192005.3233-1-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3676AF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Monday, February 25, 2019 11:20 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Subject: [Intel-wired-lan] [PATCH] i40e: fix i40e_ptp_adjtime when given a
> negative delta
> 
> Commit 0ac30ce43323 ("i40e: fix up 32 bit timespec references",
> 2017-07-26) claims to be cleaning up references to 32-bit timespecs.
> 
> The actual contents of the commit make no sense, as it converts a call to
> timespec64_add into timespec64_add_ns. This would seem ok, if (a) the
> change was documented in the commit message, and (b)
> timespec64_add_ns supported negative numbers.
> 
> timespec64_add_ns doesn't work with signed deltas, because the
> implementation is based around iter_div_u64_rem. This change resulted in a
> regression where i40e_ptp_adjtime would interpret small negative
> adjustments as large positive additions, resulting in incorrect behavior.
> 
> This commit doesn't appear to fix anything, is not well explained, and
> introduces a bug, so lets just revert it.
> 
> Reverts: 0ac30ce43323 ("i40e: fix up 32 bit timespec references", 2017-07-26)
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


