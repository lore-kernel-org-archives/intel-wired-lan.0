From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 15 Feb 2019 00:06:48 +0000
Subject: [Intel-wired-lan] [PATCH S11 15/16] ice: Fix for FC get rx/tx
 pause params
In-Reply-To: <20190208205043.11975-16-anirudh.venkataramanan@intel.com>
References: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
 <20190208205043.11975-16-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3662B4@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, February 8, 2019 12:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S11 15/16] ice: Fix for FC get rx/tx pause
> params
> 
> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
> 
> Ethtool reported pause params based on the currently negotiated link
> settings instead of current PHY config. User was not able to turn off pause
> params because ethtool was incorrectly reporting parameters as off when
> link was down even though PHY was configured to support pause frames.
> Now pause params are taken from PHY config instead of link status.
> 
> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 37 +++++++++++++++++++--
> -------
>  1 file changed, 26 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


