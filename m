From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 17 May 2018 22:15:04 +0000
Subject: [Intel-wired-lan] [next PATCH S92 8/9] i40e: add function doc
 headers for ethtool stats functions
In-Reply-To: <20180517080840.30192-8-alice.michael@intel.com>
References: <20180517080840.30192-1-alice.michael@intel.com>
 <20180517080840.30192-8-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1B7718A0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, May 17, 2018 1:09 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S92 8/9] i40e: add function doc
> headers for ethtool stats functions
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Add documentation for the i40e_get_stats_count, i40e_get_stat_strings and
> i40e_get_ethtool_stats explaining that the number and ordering of statistics
> must remain constant for a given netdevice.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 38
> ++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


