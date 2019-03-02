From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Sat, 2 Mar 2019 00:00:01 +0000
Subject: [Intel-wired-lan] [next PATCH S2-V2 03/12] i40e: don't allow
 changes to HW vlan stripping on active port vlans
In-Reply-To: <20190206230826.24970-3-alice.michael@intel.com>
References: <20190206230826.24970-1-alice.michael@intel.com>
 <20190206230826.24970-3-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D36769B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, February 6, 2019 3:08 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S2-V2 03/12] i40e: don't allow changes
> to HW vlan stripping on active port vlans
> 
> From: Nicholas Nunley <nicholas.d.nunley@intel.com>
> 
> Modifying the vlan stripping options when a port vlan is configured will break
> traffic for the VSI, and conceptually doesn't make sense, so don't allow this.
> 
> Signed-off-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


