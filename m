From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 17 Mar 2017 19:10:39 +0000
Subject: [Intel-wired-lan] [PART1 PATCH 09/11] i40e: add counters
	for	UDP/IPv4 and IPv4 filters
In-Reply-To: <20170206223846.31052-10-jacob.e.keller@intel.com>
References: <20170206223846.31052-1-jacob.e.keller@intel.com>
 <20170206223846.31052-10-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A104030A2@ORSMSX101.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PART1 PATCH 09/11] i40e: add counters for
> UDP/IPv4 and IPv4 filters
> 
> In preparation for adding code to properly check the mask values, we will
> need to know the number of active filters for each type. Add counters for
> each filter type. Rename the already existing fd_tcp_rule to
> fd_tcp4_filter_cnt to match the style of other names. To avoid style
> warnings, avoid assigning multiple parameters at once, and fix up one other
> case where we did so previously.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  9 ++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 19 +++++++++++++------
> drivers/net/ethernet/intel/i40e/i40e_txrx.c | 17 +++++++++++++----
>  3 files changed, 34 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


