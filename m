From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 12 Mar 2018 19:29:09 +0000
Subject: [Intel-wired-lan] [S87 v5 1/7] i40e: Fix attach VF to VM issue
In-Reply-To: <20180308225211.12254-1-jeffrey.t.kirsher@intel.com>
References: <20180308225211.12254-1-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94BDEB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Thursday, March 8, 2018 2:52 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Jablonski, Pawel <pawel.jablonski@intel.com>
> Subject: [Intel-wired-lan] [S87 v5 1/7] i40e: Fix attach VF to VM issue
> 
> From: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
> 
> Fix for "Resource temporarily unavailable" problem when virsh is trying to
> attach a device to VM. When the VF driver is loaded on host and virsh is
> trying to attach it to the VM and set a MAC address, it ends with a race
> condition between i40e_reset_vf and i40e_ndo_set_vf_mac functions. The
> bug is fixed by adding polling in i40e_ndo_set_vf_mac function For when the
> VF is in Reset mode.
> 
> Signed-off-by: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


