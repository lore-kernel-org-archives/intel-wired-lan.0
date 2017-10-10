From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 10 Oct 2017 17:43:34 +0000
Subject: [Intel-wired-lan] [PATCH v3 10/14 net-next] ethtool:
	add	ethtool_intersect_link_masks
In-Reply-To: <20171005215344.2886-11-alan.brady@intel.com>
References: <20171005215344.2886-1-alan.brady@intel.com>
 <20171005215344.2886-11-alan.brady@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAC2CE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alan Brady
> Sent: Thursday, October 5, 2017 2:54 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3 10/14 net-next] ethtool: add
> ethtool_intersect_link_masks
> 
> This function provides a way to intersect two link masks together to find the
> common ground between them.  For example in i40e, the driver first
> generates link masks for what is supported by the PHY type.  The driver then
> gets the link masks for what the NVM supports.  The resulting intersection
> between them yields what can truly be supported.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  include/linux/ethtool.h | 10 ++++++++++
>  net/core/ethtool.c      | 16 ++++++++++++++++
>  2 files changed, 26 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


