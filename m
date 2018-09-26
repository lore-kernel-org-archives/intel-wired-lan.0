From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 17:00:44 +0000
Subject: [Intel-wired-lan] [PATCH 14/16] ice: Implement ethtool hook for
 RSS switch
In-Reply-To: <20180920002319.10971-15-anirudh.venkataramanan@intel.com>
References: <20180920002319.10971-1-anirudh.venkataramanan@intel.com>
 <20180920002319.10971-15-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC547@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, September 19, 2018 5:23 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 14/16] ice: Implement ethtool hook for RSS
> switch
> 
> From: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
> 
> This patch implements ethtool hook for enabling/disabling RSS. While
> disabling RSS, the LUT should be cleared. And the LUT should be reconfigured
> while enabling RSS.
> 
> Signed-off-by: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 32
> +++++++++++++++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_lib.h  |  2 ++
> drivers/net/ethernet/intel/ice/ice_main.c |  6 ++++++
>  3 files changed, 40 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


