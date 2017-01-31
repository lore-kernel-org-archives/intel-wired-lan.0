From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 31 Jan 2017 19:37:04 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: add default setup_link
	for	x550em_a MAC type
In-Reply-To: <20170119235512.24962.55784.stgit@localhost6.localdomain6>
References: <20170119235512.24962.55784.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5D7AF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Thursday, January 19, 2017 3:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: add default setup_link for
> x550em_a MAC type
> 
> Add default setting for mac->ops.setup_link on x550em_a MAC types.
> This fixes a link issue on KR parts.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


