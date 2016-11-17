From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 17 Nov 2016 19:28:52 +0000
Subject: [Intel-wired-lan] [next PATCH S54 05/15] i40e: factor
	out	addition/deletion of VLAN per each MAC address
In-Reply-To: <1478896779-13697-6-git-send-email-bimmy.pujari@intel.com>
References: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
 <1478896779-13697-6-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA37FF2@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Friday, November 11, 2016 12:39 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S54 05/15] i40e: factor out
> addition/deletion of VLAN per each MAC address
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> A future refactor of how the PF assigns a PVID to a VF will want to be able to
> add and remove a block of filters by VLAN without worrying about
> accidentally triggering the accounting for I40E_VLAN_ANY. Additionally the
> PVID assignment would like to be able to batch several changes under one
> use of the mac_filter_hash_lock.
> 
> Factor out the addition and deletion of a VLAN on all MACs into their own
> function which i40e_vsi_(add|kill)_vlan can use. These new functions expect
> the caller to take the hash lock, as well as perform any necessary accounting
> for updating I40E_VLAN_ANY filters if we are now operating under VLAN
> mode.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: If79e5b60b770433275350a74b3f1880333a185d5
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 68
> +++++++++++++++++++++++------
>  1 file changed, 55 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


