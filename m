From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 17:02:43 +0000
Subject: [Intel-wired-lan] [PATCH 12/16] ice: Check for actual link
 state of port after reset
In-Reply-To: <20180920002319.10971-13-anirudh.venkataramanan@intel.com>
References: <20180920002319.10971-1-anirudh.venkataramanan@intel.com>
 <20180920002319.10971-13-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC57A@ORSMSX106.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 12/16] ice: Check for actual link state of
> port after reset
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> We are currently replaying the link state of a port after a reset, but it is
> possible that the link state of a port can change during the reset process. So
> check for the current link state of a port during the rebuild process of a reset.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> minor
> cleanup for upstream submission]
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 3 +--
> drivers/net/ethernet/intel/ice/ice_common.h | 1 +
>  drivers/net/ethernet/intel/ice/ice_main.c   | 4 ++++
>  3 files changed, 6 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


