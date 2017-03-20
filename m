From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 20 Mar 2017 19:40:56 +0000
Subject: [Intel-wired-lan] [PART2 PATCH 3/9] i40e: restore default input
 set	for each flow type
In-Reply-To: <20170206223852.31177-4-jacob.e.keller@intel.com>
References: <20170206223852.31177-1-jacob.e.keller@intel.com>
 <20170206223852.31177-4-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040652D@ORSMSX101.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PART2 PATCH 3/9] i40e: restore default input set
> for each flow type
> 
> Ensure that the default input set is correctly reprogrammed when cleaning
> up after disabling flow director support. This ensures that the programmed
> value will be in a clean state.
> 
> Although we do not yet have support for SCTPv4 filters, a future patch will
> add support for this protocol, so we will correctly restore the
> SCTPv4 input set here as well. Note that strictly speaking the default
> hardware value for SCTP includes matching the verification tag. However, the
> ethtool API does not have support for specifying this value, so there is no
> reason to keep the verification field enabled.
> 
> This patch is the next step on the way to enabling partial tuple filters which
> will be implemented in a following patch.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-Id: c22e1c267ae37518bb036aca4a5694681449f283
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      | 18 ++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 19 +++++++++++++++++++
>  2 files changed, 37 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


