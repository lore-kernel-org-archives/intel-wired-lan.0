From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 29 Dec 2016 18:01:41 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbevf: Add support for
	VF	promiscuous mode
In-Reply-To: <1481854712-29454-1-git-send-email-donald.c.skidmore@intel.com>
References: <1481854712-29454-1-git-send-email-donald.c.skidmore@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA4C896@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Donald C Skidmore
> Sent: Thursday, December 15, 2016 6:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/2] ixgbevf: Add support for VF
> promiscuous mode
> 
> This patch extends the mailbox message to allow for VF promiscous mode
> support.
> 
> Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |  1 +
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 15 +++++++++++++-
>  drivers/net/ethernet/intel/ixgbevf/mbx.h          |  1 +
>  drivers/net/ethernet/intel/ixgbevf/vf.c           | 24 +++++++++++++++++++--
> --
>  4 files changed, 36 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


