From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 9 May 2016 17:41:46 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: use correct mask when
	enabling	sriov
In-Reply-To: <20160504220127.3998.27301.stgit@localhost6.localdomain6>
References: <20160504220127.3998.27301.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D5EBE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Wednesday, May 04, 2016 3:01 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: use correct mask when enabling
> sriov
> 
> Swap the parameters in GENMASK in order to generate the correct mask.
> 
> This change fixes Tx hangs when enabling SRIOV.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Enabling SR-IOV does not generate tx hang with traffic passing
