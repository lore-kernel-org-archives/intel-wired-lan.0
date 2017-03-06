From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 6 Mar 2017 17:44:03 +0000
Subject: [Intel-wired-lan] [PART1 PATCH 04/11] i40e: return immediately
 when	failing to add fdir filter
In-Reply-To: <20170206223846.31052-5-jacob.e.keller@intel.com>
References: <20170206223846.31052-1-jacob.e.keller@intel.com>
 <20170206223846.31052-5-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10401D36@ORSMSX101.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PART1 PATCH 04/11] i40e: return immediately
> when failing to add fdir filter
> 
> Instead of setting err=true and checking this to determine when to free the
> raw_packet near the end of the function, simply kfree and return
> immediately. The resulting code is a bit cleaner and has one less variable. This
> also resolves a subtle bug in the ipv4 case which could fail to add the first
> filter and then never free the memory, resulting in a small memory leak.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Dayanand, Avinash <avinash.dayanand@intel.com>
> Reviewed-by: Brady, Alan <alan.brady@intel.com>
> Reviewed-by: Williams, Mitch A <mitch.a.williams@intel.com>
> Change-ID: I7583aac033481dc794b4acaa14445059c8930ff1
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 33 ++++++++++++--------------
> ---
>  1 file changed, 14 insertions(+), 19 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


