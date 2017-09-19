From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 19 Sep 2017 19:19:35 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: fix the FWSM.PT check
	in	ixgbe_mng_present()
In-Reply-To: <20170911212136.27262.78426.stgit@localhost6.localdomain6>
References: <20170911212131.27262.52988.stgit@localhost6.localdomain6>
 <20170911212136.27262.78426.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAA900@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Monday, September 11, 2017 2:22 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: fix the FWSM.PT check in
> ixgbe_mng_present()
> 
> Bits other than FWSM.PT can be set in IXGBE_SWFW_MODE_MASK making
> the previous check invalid.
> 
> Change the check for MNG present to be only based on FWSM.PT bit.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


