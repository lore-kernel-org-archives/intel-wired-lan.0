From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 6 Mar 2017 17:53:53 +0000
Subject: [Intel-wired-lan] [PART1 PATCH 10/11] i40e: explicitly fail
	on	extended MAC field for ethtool_rx_flow_spec
In-Reply-To: <20170206223913.31525-1-jacob.e.keller@intel.com>
References: <20170206223913.31525-1-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10401D4D@ORSMSX101.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PART1 PATCH 10/11] i40e: explicitly fail on
> extended MAC field for ethtool_rx_flow_spec
> 
> Although we will fail the filter later due to checking flow_type which will have
> a bogus invalid type, it is possible future refactoring will remove this hidden
> failure case. Avoid a possible issue in the future by explicitly checking the
> flow type at the start.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-Id: Ia98eb26f7b93ccbe38c7141e8f203ef496fc6598
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 4 ++++
>  1 file changed, 4 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


