From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 23 Dec 2016 17:36:09 +0000
Subject: [Intel-wired-lan] [PATCH v4 3/4] i40e: Add XDP_TX support
In-Reply-To: <20161217134000.31640-4-bjorn.topel@gmail.com>
References: <20161217134000.31640-1-bjorn.topel@gmail.com>
 <20161217134000.31640-4-bjorn.topel@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA4C1ED@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bj?rn T?pel
> Sent: Saturday, December 17, 2016 5:40 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: daniel at iogearbox.net; Topel, Bjorn <bjorn.topel@intel.com>; Karlsson,
> Magnus <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH v4 3/4] i40e: Add XDP_TX support
> 
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> This patch adds proper XDP_TX support.
> 
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |   5 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 294
> +++++++++++++++++++++++-----
> drivers/net/ethernet/intel/i40e/i40e_txrx.c | 255
> +++++++++++++++++++++---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h |   5 +
>  4 files changed, 478 insertions(+), 81 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Does not break base driver


