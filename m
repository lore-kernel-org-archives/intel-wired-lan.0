From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 25 May 2017 19:01:20 +0000
Subject: [Intel-wired-lan] [PATCH v7 1/2] i40e: add XDP support for pass
 and	drop actions
In-Reply-To: <20170524055535.14155-2-bjorn.topel@gmail.com>
References: <20170524055535.14155-1-bjorn.topel@gmail.com>
 <20170524055535.14155-2-bjorn.topel@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA412F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Bj?rn T?pel
> Sent: Tuesday, May 23, 2017 10:56 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; alexander.duyck at gmail.com
> Cc: daniel at iogearbox.net; Topel, Bjorn <bjorn.topel@intel.com>; Karlsson,
> Magnus <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH v7 1/2] i40e: add XDP support for pass and
> drop actions
> 
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> This commit adds basic XDP support for i40e derived NICs. All XDP actions will
> end up in XDP_DROP.
> 
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |   7 ++
>  drivers/net/ethernet/intel/i40e/i40e_main.c |  87 +++++++++++++++++++
> drivers/net/ethernet/intel/i40e/i40e_txrx.c | 130
> +++++++++++++++++++++-------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h |   1 +
>  4 files changed, 194 insertions(+), 31 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


