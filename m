From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Jul 2016 19:10:53 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbevf: add VF support for new
 hardware
In-Reply-To: <1467243144-28174-1-git-send-email-donald.c.skidmore@intel.com>
References: <1467243144-28174-1-git-send-email-donald.c.skidmore@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9EA5DF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Donald C Skidmore
> Sent: Wednesday, June 29, 2016 4:32 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbevf: add VF support for new hardware
> 
> This patch add VF support for the new X553 hardware.
> 
> Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/defines.h      | 1 +
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      | 2 ++
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 ++
>  drivers/net/ethernet/intel/ixgbevf/vf.c           | 5 +++++
>  drivers/net/ethernet/intel/ixgbevf/vf.h           | 1 +
>  5 files changed, 11 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
New device IDs present in module
