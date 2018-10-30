From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Oct 2018 22:23:05 +0000
Subject: [Intel-wired-lan] [PATCH S9 09/15] ice: Do not set LAN_EN for
 MAC-VLAN filters
In-Reply-To: <20181026184447.13547-10-anirudh.venkataramanan@intel.com>
References: <20181026184447.13547-1-anirudh.venkataramanan@intel.com>
 <20181026184447.13547-10-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D328E19@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, October 26, 2018 11:45 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S9 09/15] ice: Do not set LAN_EN for MAC-
> VLAN filters
> 
> From: Yashaswini Raghuram Prathivadi Bhayankaram
> <yashaswini.raghuram.prathivadi.bhayankaram@intel.com>
> 
> In the action fields for a MAC-VLAN filter, do not set the LAN_EN flag if the
> MAC in the MAC-VLAN is unicast MAC. The unicast packets that match should
> not be forwarded to the wire.
> 
> Signed-off-by: Yashaswini Raghuram Prathivadi Bhayankaram
> <yashaswini.raghuram.prathivadi.bhayankaram@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 37 +++++++++++++++++++---
> -------
>  1 file changed, 24 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


