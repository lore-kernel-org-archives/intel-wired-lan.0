From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Aug 2019 17:03:42 +0000
Subject: [Intel-wired-lan] [PATCH S28 4/9] ice: Report VF link status
 with opcode to get resources
In-Reply-To: <20190827131354.12703-4-anthony.l.nguyen@intel.com>
References: <20190827131354.12703-1-anthony.l.nguyen@intel.com>
 <20190827131354.12703-4-anthony.l.nguyen@intel.com>
Message-ID: <5633f003076947d5b2fba3ec9fd03ef0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Tuesday, August 27, 2019 6:14 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S28 4/9] ice: Report VF link status with
> opcode to get resources
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> This patch changes how and when the driver report link status, instead of
> waiting till the call to enable queues for VF, we should report link status
> earlier with opcode to get VF resources - So as to avoid reporting erroneous
> information, especially when queues have not been configured.
> In addition, we can also make a call to get and report link status change after
> when queue is enabled, at least to report netdev or PHY link status.
> This is in accordance to how link speed is being reported for PF...
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


