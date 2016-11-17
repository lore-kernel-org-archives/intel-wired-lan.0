From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 17 Nov 2016 18:33:14 +0000
Subject: [Intel-wired-lan] [next PATCH S52-V2 13/15] i40e: remove code
 to	handle dev_addr specially
In-Reply-To: <1478639119-14656-14-git-send-email-bimmy.pujari@intel.com>
References: <1478639119-14656-1-git-send-email-bimmy.pujari@intel.com>
 <1478639119-14656-14-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA37F47@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, November 08, 2016 1:05 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S52-V2 13/15] i40e: remove code to
> handle dev_addr specially
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The netdev->dev_addr MAC filter already exists in the MAC/VLAN hash
> table, as it is added when we configure the netdev in
> i40e_configure_netdev. Because we already know that this address will be
> updated in the hash_for_each loops, we do not need to handle it specially.
> This removes duplicate code and simplifies the i40e_vsi_add_vlan and
> i40e_vsi_kill_vlan functions.
> Because we know these filters must be part of the MAC/VLAN hash table,
> this should not have any functional impact on what filters are included and is
> merely a code simplification.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I5e648302dbdd7cc29efc6d203b7019c11f0b5705
> ---
> Testing-hints:
>   Ensure that adding and removing VLANs correctly updates the filters
>   for the MAC address of the device.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 43 +++++------------------------
>  1 file changed, 7 insertions(+), 36 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Adding/removing VLANs correctly updates MAC filter table


