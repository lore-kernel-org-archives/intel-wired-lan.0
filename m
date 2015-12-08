From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 8 Dec 2015 19:46:38 +0000
Subject: [Intel-wired-lan] [PATCH v9] i40e: Look up MAC address in
	Open	Firmware or IDPROM
In-Reply-To: <20151207200634.GA4415@oracle.com>
References: <20151207200634.GA4415@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F96D2C3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Sowmini Varadhan
> Sent: Monday, December 07, 2015 12:07 PM
> To: sowmini.varadhan at oracle.com; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org
> Cc: andy.shevchenko at gmail.com; matthew.vick at intel.com;
> davem at davemloft.net
> Subject: [Intel-wired-lan] [PATCH v9] i40e: Look up MAC address in Open
> Firmware or IDPROM
> 
> 
> This is the i40e equivalent of commit c762dff24c06 ("ixgbe: Look up MAC
> address in Open Firmware or IDPROM").
> 
> As with that fix, attempt to look up the MAC address in Open Firmware on
> systems that support it, and use IDPROM on SPARC if no OF address is found.
> 
> In the case of the i40e there is an assumption that the default mac address
> has already been set up as the primary mac filter on probe, so if this filter is
> obtained from the Open Firmware or IDPROM, an explicit write is needed via
> i40e_aq_mac_address_write() and
> i40e_aq_add_macvlan() invocation.
> 
> The I40E_FLAG_PF_MAC flag in the platform-private i40e_pf structure tracks
> whether a platform-specific mac address was found, in which case calls to
> i40e_aq_mac_address_write() and i40e_aq_add_macvlan() will be triggered.
> 
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
> ---
> v2, v3: Andy Shevchenko comments
> v4: Shannon Nelson review: explicitly set up mac filters before
> register_netdev
> v5: Shannon Nelson code style comments
> v6: Shannon Nelson code style comments
> v7: Ensure that i40e_macaddr_init() is called only for VSI_MAIN, and only
>     if the mac address is not the default. Some additional code-refactoring
>     based on comments from Shannon Nelson
> v8: use pf->flags instead of bit value to track if we found a platform-specific
>     macaddr. Other code-style comments from Shannon Nelson
> v9: David Miller, Shannon Nelson comments for
> i40e_get_platform_mac_addr
> 
>  drivers/net/ethernet/intel/i40e/i40e.h      |    1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c |   90
> +++++++++++++++++++++++++++
>  2 files changed, 91 insertions(+), 0 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, driver displays correct MAC address, no more -11 error on driver init.
