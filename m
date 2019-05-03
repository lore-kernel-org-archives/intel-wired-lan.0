From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 3 May 2019 23:39:28 +0000
Subject: [Intel-wired-lan] [next PATCH S5 08/10] i40e: Check if the BAR
 size is large enough before writing to registers
In-Reply-To: <20190424122055.27896-8-alice.michael@intel.com>
References: <20190424122055.27896-1-alice.michael@intel.com>
 <20190424122055.27896-8-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39C6EE@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 24, 2019 5:21 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Ludkiewicz, Adam <adam.ludkiewicz@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S5 08/10] i40e: Check if the BAR size is
> large enough before writing to registers
> 
> From: Adam Ludkiewicz <adam.ludkiewicz@intel.com>
> 
> This patch fixes the problem with a kernel panic occurring when trying to bind
> the i40e driver to a non-i40e port. The problem is fixed by checking if the BAR
> size in the device is large enough by reading the highest register.
> 
> Signed-off-by: Adam Ludkiewicz <adam.ludkiewicz@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


