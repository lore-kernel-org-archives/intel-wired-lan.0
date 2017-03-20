From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 20 Mar 2017 19:42:39 +0000
Subject: [Intel-wired-lan] [PART2 PATCH 6/9] i40e: add parsing of
 flexible	filter fields from userdef
In-Reply-To: <20170206223852.31177-7-jacob.e.keller@intel.com>
References: <20170206223852.31177-1-jacob.e.keller@intel.com>
 <20170206223852.31177-7-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040655D@ORSMSX101.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PART2 PATCH 6/9] i40e: add parsing of flexible
> filter fields from userdef
> 
> Add code to parse the user-def field into a data structure format. This code is
> intended to allow future extensions of the user-def field by keeping all code
> that actually reads and writes the field into a single location. This ensures that
> we do not litter the driver with references to the user-def field and
> minimizes the amount of bitwise operations we need to do on the data.
> 
> Add code which parses the lower 32bits into a flexible word and its offset.
> This will be used in a future patch to enable flexible filters which can match
> on some arbitrary data in the packet payload. For now, we just return -
> EOPNOTSUPP when this is used.
> 
> Add code to fill in the user-def field when reporting the filter back, even
> though we don't actually implement any user-def fields yet.
> 
> Additionally, ensure that we mask the extended FLOW_EXT bit from the
> flow_type now that we will be accepting filters which have the FLOW_EXT bit
> set (and thus make use of the user-def field).
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-Id: 238845035c179380a347baa8db8223304f5f6dd7
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |   9 +++
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 108
> ++++++++++++++++++++++++-
>  2 files changed, 116 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


