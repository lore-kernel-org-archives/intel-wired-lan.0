From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 23 Dec 2016 17:35:39 +0000
Subject: [Intel-wired-lan] [PATCH v4 2/4] i40e: Initial support for XDP
In-Reply-To: <20161217134000.31640-3-bjorn.topel@gmail.com>
References: <20161217134000.31640-1-bjorn.topel@gmail.com>
 <20161217134000.31640-3-bjorn.topel@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA4C1DA@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v4 2/4] i40e: Initial support for XDP
> 
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> This commit adds basic XDP support for i40e derived NICs. All XDP actions will
> end up in XDP_DROP.
> 
> Only the default/main VSI has support for enabling XDP.
> 
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |  13 +++
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |   4 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c    |  83 +++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 124
> +++++++++++++++++++++++--
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h    |   2 +
>  5 files changed, 220 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Does not break base driver


