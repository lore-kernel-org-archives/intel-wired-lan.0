From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 17 Mar 2017 19:10:03 +0000
Subject: [Intel-wired-lan] [PART1 PATCH 08/11] i40e: don't re-enable
	ATR	when flushing filters if SB has TCP4/IPv4 rules
In-Reply-To: <20170206223846.31052-9-jacob.e.keller@intel.com>
References: <20170206223846.31052-1-jacob.e.keller@intel.com>
 <20170206223846.31052-9-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10403091@ORSMSX101.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PART1 PATCH 08/11] i40e: don't re-enable ATR
> when flushing filters if SB has TCP4/IPv4 rules
> 
> When flushing and replaying FDIR filters, it is possible we would disable ATR,
> and then re-enable it even though we should have kept it disabled due to
> existing TCP/IPv4 filters. Fix this by checking whether we have TCP4/IPv4
> filters before re-enabling.
> 
> Alternatively, we could instead restore ATR and then replay filters, however,
> this would cause us to rapidly enable and then disable ATR in some cases.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Dayanand, Avinash <avinash.dayanand@intel.com>
> Reviewed-by: Brady, Alan <alan.brady@intel.com>
> Reviewed-by: Williams, Mitch A <mitch.a.williams@intel.com>
> Change-ID: I076e4cc1e4409bce7f98f3c213295433a4ff43d8
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


