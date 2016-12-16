From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 16 Dec 2016 22:55:25 +0000
Subject: [Intel-wired-lan] [PATCH v2] i40e: don't
	allow	i40e_vsi_(add|kill)_vlan to operate when VID<1
In-Reply-To: <20161207220534.21018-1-jacob.e.keller@intel.com>
References: <20161207220534.21018-1-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA49A50@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Wednesday, December 07, 2016 2:06 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH v2] i40e: don't allow
> i40e_vsi_(add|kill)_vlan to operate when VID<1
> 
> Now that we have the separate i40e_(add|rm)_vlan_all_mac functions, we
> should not be using the i40e_vsi_kill_vlan or i40e_vsi_add_vlan functions
> when PVID is set or when VID is less than 1. This allows us to remove some
> checks in i40e_vsi_add_vlan and ensures that callers which need to handle
> VID=0 or VID=-1 don't accidentally invoke the VLAN mode handling used to
> convert filters when entering VLAN mode. We also update the functions to
> take u16 instead of s16 as well since they no longer expect to be called with
> VID=I40E_VLAN_ANY.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: Ibddf44a8bb840dde8ceef2a4fdb92fd953b05a57
> ---
> v2
> * Use !vid instead of !(vid > 0)
> 
>  drivers/net/ethernet/intel/i40e/i40e.h      |  4 ++--
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 14 ++++++++++----
>  2 files changed, 12 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
