From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 6 Mar 2017 17:42:27 +0000
Subject: [Intel-wired-lan] [PART1 PATCH 02/11] i40e: don't use arrays
 for	(src|dst)_ip
In-Reply-To: <20170206223846.31052-3-jacob.e.keller@intel.com>
References: <20170206223846.31052-1-jacob.e.keller@intel.com>
 <20170206223846.31052-3-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10401D1A@ORSMSX101.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PART1 PATCH 02/11] i40e: don't use arrays for
> (src|dst)_ip
> 
> The code originally included src_ip and dst_ip with enough space to support
> ipv6 filters. However, no actual support for ipv6 filters has been
> implemented. Thus, remove the arrays and just use __be32 values.
> Should ipv6 support be added in the future, we can replace these with a
> union that has sizes for both values.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-Id: I1bc04032244a80eb6ebc8a4e6c723a4a665c1dd5
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |  4 ++--
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 12 ++++++------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 12 ++++++------
>  3 files changed, 14 insertions(+), 14 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


