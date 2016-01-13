From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Jan 2016 19:28:57 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] i40e:
	use	eth_platform_get_mac_address()
In-Reply-To: <2da591718f08ebe8285b6bf9376893ec73ac98bb.1452655484.git.sowmini.varadhan@oracle.com>
References: <cover.1452655483.git.sowmini.varadhan@oracle.com>
 <2da591718f08ebe8285b6bf9376893ec73ac98bb.1452655484.git.sowmini.varadhan@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F980226@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Sowmini Varadhan
> Sent: Tuesday, January 12, 2016 7:33 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; Nelson, Shannon
> <shannon.nelson@intel.com>; Wyborny, Carolyn
> <carolyn.wyborny@intel.com>; Skidmore, Donald C
> <donald.c.skidmore@intel.com>; Allan, Bruce W <bruce.w.allan@intel.com>;
> Ronciak, John <john.ronciak@intel.com>; Williams, Mitch A
> <mitch.a.williams@intel.com>; intel-wired-lan at lists.osuosl.org
> Cc: sowmini.varadhan at oracle.com; davem at davemloft.net
> Subject: [Intel-wired-lan] [PATCH 2/2] i40e: use
> eth_platform_get_mac_address()
> 
> This commit converts commit b499ffb0a22c ("i40e: Look up MAC address in
> Open Firmware or IDPROM") to use eth_platform_get_mac_address()
> added by commit c7f5d105495a ("net: Add eth_platform_get_mac_address()
> helper.")
> 
> Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c |   19 +------------------
>  1 files changed, 1 insertions(+), 18 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, MAC address lookup works correctly
