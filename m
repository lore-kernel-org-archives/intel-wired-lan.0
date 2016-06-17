From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 17 Jun 2016 16:36:39 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbevf: fix NACK check
	in	ixgbevf_set_uc_addr_vf()
In-Reply-To: <20160609174534.25671.50164.stgit@localhost6.localdomain6>
References: <20160609174534.25671.50164.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9E75E8@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Thursday, June 09, 2016 10:46 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbevf: fix NACK check in
> ixgbevf_set_uc_addr_vf()
> 
> Fix the NACK check in ixgbevf_set_uc_addr_vf() for instances where index
> != 0.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/vf.c |   14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Driver builds, compiles, and passes traffic
