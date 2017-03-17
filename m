From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 17 Mar 2017 19:08:15 +0000
Subject: [Intel-wired-lan] [PART1 PATCH 06/11] i40e: remove redundant
 check	for fd_tcp_rule when restoring filters
In-Reply-To: <20170206223846.31052-7-jacob.e.keller@intel.com>
References: <20170206223846.31052-1-jacob.e.keller@intel.com>
 <20170206223846.31052-7-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040306F@ORSMSX101.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PART1 PATCH 06/11] i40e: remove redundant
> check for fd_tcp_rule when restoring filters
> 
> i40e_fdir_filter_restore re-adds all existing filters, which already checks
> when adding a TCPv4 filter to disable ATR. We don't need to make the check
> twice, so remove this redundant code.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: Ia0b0690e23523915199d601494557def135c9d7f
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 6 ------
>  1 file changed, 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


