From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Apr 2017 22:38:24 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: enable L3/L4 filtering for
	Tx	switched packets
In-Reply-To: <20170425183106.14275.33565.stgit@localhost6.localdomain6>
References: <20170425183106.14275.33565.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA17E8@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Tuesday, April 25, 2017 11:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: enable L3/L4 filtering for Tx
> switched packets
> 
> This will ensure that VF-to-VF traffic on the same PF is filtered to allow RSS
> operation.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


