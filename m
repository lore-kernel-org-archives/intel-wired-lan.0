From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Oct 2016 22:09:28 +0000
Subject: [Intel-wired-lan] [next PATCH S51-V2 4/8] i40e: remove second
 check	of VLAN_N_VID in i40e_vlan_rx_add_vid
In-Reply-To: <1477436933-13679-5-git-send-email-bimmy.pujari@intel.com>
References: <1477436933-13679-1-git-send-email-bimmy.pujari@intel.com>
 <1477436933-13679-5-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA2929E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, October 25, 2016 4:09 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S51-V2 4/8] i40e: remove second
> check of VLAN_N_VID in i40e_vlan_rx_add_vid
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Replace a check of magic number 4095 with VLAN_N_VID. This makes it
> obvious that a later check against VLAN_N_VID is always true and can be
> removed.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I28998f127a61a529480ce63d8a07e266f6c63b7b
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


