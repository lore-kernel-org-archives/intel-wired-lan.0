From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 5 Jan 2018 19:28:21 +0000
Subject: [Intel-wired-lan] [next PATCH S85-V1 07/14] i40e: Warn when
 setting link-down-on-close while in MFP
In-Reply-To: <20171229135020.14457-1-alice.michael@intel.com>
References: <20171229135020.14457-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D7227@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, December 29, 2017 5:50 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Jablonski, Pawel <pawel.jablonski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S85-V1 07/14] i40e: Warn when
> setting link-down-on-close while in MFP
> 
> From: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
> 
> This patch adds a warning message when the link-down-on-close flag is
> setting on. The warning is printed only on MFP devices
> 
> Signed-off-by: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


