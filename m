From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 24 Dec 2015 17:03:27 +0000
Subject: [Intel-wired-lan] [next PATCH 2/2] i40e: allow zero MAC address
 for	VFs
In-Reply-To: <1450827283-34667-2-git-send-email-mitch.a.williams@intel.com>
References: <1450827283-34667-1-git-send-email-mitch.a.williams@intel.com>
 <1450827283-34667-2-git-send-email-mitch.a.williams@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F96FB98@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mitch Williams
> Sent: Tuesday, December 22, 2015 3:35 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 2/2] i40e: allow zero MAC address for
> VFs
> 
> Allow the user to specify a zero MAC address for VFs. This removes the
> existing MAC address and allows the VF to use a random address. Libvirt
> does this normally when removing a VF from a VM.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, setting MAC to all zero causes driver to assign random on reload
