From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 25 Jan 2016 22:05:25 +0000
Subject: [Intel-wired-lan] [v2 next PATCH S27 09/15] i40e/i40evf: try
 again	after failure
In-Reply-To: <1452732712-12248-10-git-send-email-joshua.a.hay@intel.com>
References: <1452732712-12248-1-git-send-email-joshua.a.hay@intel.com>
 <1452732712-12248-10-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98C490@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Wednesday, January 13, 2016 4:52 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [v2 next PATCH S27 09/15] i40e/i40evf: try again
> after failure
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> This is the "Don't Give Up" patch.  Previously the driver could fail an
> allocation, and then possibly stall a queue forever, by never coming back to
> continue receiving or allocating buffers.
> 
> With this patch, the driver will keep polling trying to allocate receive buffers
> until it succeeds.  This should keep all receive queues running even in the
> face of memory pressure.
> 
> Also update copyright year in file header.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I2b103d1ce95b9831288a7222c3343ffa1988b81b
> ---
> Testing Hints: Load RHEL 7.1 -229 default kernel with firewall enabled, and
> receive more packets per second than the kernel can handle (indicating
> drops) and observe that kernel starts printing OOM errors.  After OOM
> errors, stop incoming traffic and make sure all rx queues are still
> active/working.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 51
> ++++++++++++++++++++++-----
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  6 ++--
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 51
> ++++++++++++++++++++++-----
> drivers/net/ethernet/intel/i40evf/i40e_txrx.h |  4 +--
>  4 files changed, 89 insertions(+), 23 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, receive queues properly recover after failure
