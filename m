From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 6 Apr 2017 21:31:26 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: only register client
	on	iWarp-capable devices
In-Reply-To: <1491334816-27356-1-git-send-email-mitch.a.williams@intel.com>
References: <1491334816-27356-1-git-send-email-mitch.a.williams@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040B10A@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mitch Williams
> Sent: Tuesday, April 4, 2017 12:40 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; sassmann at kpanic.de
> Subject: [Intel-wired-lan] [PATCH] i40e: only register client on iWarp-capable
> devices
> 
> The client interface is only intended for use on devices that support iWarp).
> Only register with the client if this is the case.
> 
> This fixes a panic when loading i40iw on X710 devices.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Reported-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


