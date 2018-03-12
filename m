From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 12 Mar 2018 19:28:03 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix disabling hide vlan on vf
 reset
In-Reply-To: <1520511968-20947-1-git-send-email-paul.greenwalt@intel.com>
References: <1520511968-20947-1-git-send-email-paul.greenwalt@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94BDDF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Paul Greenwalt
> Sent: Thursday, March 8, 2018 4:26 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: fix disabling hide vlan on vf reset
> 
> If port vlan is enabled, set PFQDE.HIDE_VLAN during vf reset.
> 
> Setting only PFQDE.PFQDE during vf reset was clearing PFQDE.HIDE_VLAN.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


