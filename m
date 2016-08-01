From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 1 Aug 2016 14:06:44 +0000
Subject: [Intel-wired-lan] [PATCH 2/3] ixgbevf: change hw_dbg to
	use	netdev_dbg
In-Reply-To: <20160729173011.25548.74817.stgit@localhost6.localdomain6>
References: <20160729173006.25548.93033.stgit@localhost6.localdomain6>
 <20160729173011.25548.74817.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F1F4F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Friday, July 29, 2016 10:30 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/3] ixgbevf: change hw_dbg to use
> netdev_dbg
> 
> Instead of the home brewed macro make use of netdev_dbg same as the
> ixgbe driver.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |   11 ++++-------
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    1 +
>  2 files changed, 5 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
