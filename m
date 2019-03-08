From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 8 Mar 2019 00:53:25 +0000
Subject: [Intel-wired-lan] [PATCH S13 v2 11/17] ice: Set LAN_EN for all
 directional rules
In-Reply-To: <20190227003523.28733-12-anirudh.venkataramanan@intel.com>
References: <20190227003523.28733-1-anirudh.venkataramanan@intel.com>
 <20190227003523.28733-12-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D368FB6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, February 26, 2019 4:35 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S13 v2 11/17] ice: Set LAN_EN for all
> directional rules
> 
> From: Yashaswini Raghuram Prathivadi Bhayankaram
> <yashaswini.raghuram.prathivadi.bhayankaram@intel.com>
> 
> The LAN_EN bit for a switch rule determines if the packet can go out on the
> wire or not. Set the LAN_EN flag in the switch action for all directional rules.
> 
> Signed-off-by: Yashaswini Raghuram Prathivadi Bhayankaram
> <yashaswini.raghuram.prathivadi.bhayankaram@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


