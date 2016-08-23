From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 23 Aug 2016 17:19:04 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: make
	ixgbe_led_on/off_t_x550em	static
In-Reply-To: <20160822232834.9806.70247.stgit@localhost6.localdomain6>
References: <20160822232834.9806.70247.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F97EE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Monday, August 22, 2016 4:29 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: make ixgbe_led_on/off_t_x550em
> static
> 
> These functions are only used in ixgbe_x550.c.
> 
> Fixes a warning when compiling with -Wmissing-prototypes
> 
> Reported-by: Krishneil Singh <krishneil.k.singh@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
No compiler warnings when compiled with -Wmissing-prototypes option


