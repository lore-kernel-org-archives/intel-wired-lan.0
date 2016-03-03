From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 3 Mar 2016 20:05:00 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: make __ixgbe_setup_tc static
In-Reply-To: <20160217235506.31327.63137.stgit@localhost6.localdomain6>
References: <20160217235506.31327.63137.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99C44D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Wednesday, February 17, 2016 3:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: make __ixgbe_setup_tc static
> 
> This function is only used in ixgbe_main.c Resolves a "missing prototype"
> warning when building the driver with W=1
> 
> Reported-by: Phil Schmitt <phillip.j.schmitt@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
No "missing prototype" warning at compile time
