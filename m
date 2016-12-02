From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 2 Dec 2016 22:36:56 +0000
Subject: [Intel-wired-lan] [next PATCH S56 1/8] i40e: Clean up dead code
In-Reply-To: <1480710782-9195-2-git-send-email-bimmy.pujari@intel.com>
References: <1480710782-9195-1-git-send-email-bimmy.pujari@intel.com>
 <1480710782-9195-2-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA39222@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Friday, December 02, 2016 12:33 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S56 1/8] i40e: Clean up dead code
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> The function i40e_client_prepare() can never return an error. So make it void
> and quit checking its return value.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I9ff311e2324dde329eb68648efb2c94aaff856db
> ---
> Testing Hints : Found by static code analysis. Not possible to test, just code
> cleanup.
> 
>  drivers/net/ethernet/intel/i40e/i40e_client.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


