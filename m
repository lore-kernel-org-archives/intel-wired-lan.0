From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 18 May 2017 22:39:36 +0000
Subject: [Intel-wired-lan] [PATCH 4/5] ixgbe: add missing configuration
 for	rate select 1
In-Reply-To: <20170517221756.15538.27845.stgit@localhost6.localdomain6>
References: <20170517221424.15538.5968.stgit@localhost6.localdomain6>
 <20170517221756.15538.27845.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA3B21@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Wednesday, May 17, 2017 3:18 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 4/5] ixgbe: add missing configuration for
> rate select 1
> 
> Add RS1 configuration to ixgbe_set_soft_rate_select_speed()
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |   19
> +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


