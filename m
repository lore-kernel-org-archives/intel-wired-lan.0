From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 31 May 2019 17:58:16 +0000
Subject: [Intel-wired-lan] [next PATCH S6 1/7] i40e: fix 'Unknown bps'
 in dmesg for 2.5Gb/5Gb speeds
In-Reply-To: <20190528175921.30534-1-alice.michael@intel.com>
References: <20190528175921.30534-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3DD58F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, May 28, 2019 10:59 AM
> To: alice.micheal at intel.com; intel-wired-lan at lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S6 1/7] i40e: fix 'Unknown bps' in
> dmesg for 2.5Gb/5Gb speeds
> 
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> This patch fixes 'NIC Link is Up, Unknown bps' message in dmesg for
> 2.5Gb/5Gb speeds. This problem is fixed by adding constants for
> VIRTCHNL_LINK_SPEED_2_5GB and VIRTCHNL_LINK_SPEED_5GB cases in the
> i40e_virtchnl_link_speed() function.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h | 4 ++++
>  include/linux/avf/virtchnl.h                     | 4 ++++
>  2 files changed, 8 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


