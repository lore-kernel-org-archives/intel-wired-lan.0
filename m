From: Young, James M <james.m.young@intel.com>
Date: Fri, 19 Jun 2015 20:32:53 +0000
Subject: [Intel-wired-lan] [net-next S5 06/15] i40e: correctly
	program	filters for VFs
In-Reply-To: <1430161042-28494-7-git-send-email-catherine.sullivan@intel.com>
References: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
 <1430161042-28494-7-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA1A0E4@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, April 27, 2015 11:57 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next S5 06/15] i40e: correctly program filters
> for VFs
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> MAC filters for VFs were being programmed with 0 for the VLAN value when
> there was no VLAN assigned. This is incorrect and actually assigns the VF to
> VLAN 0. Instead, we must use -1 to indicate that no VLAN is in use. This
> change programs the filters correctly and gets rid of a bogus error message
> when setting a port VLAN on an active VF.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Ica9a9906d768405377ff3308e27f7d0b5b2ea96e
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Tested-by: Jim Young <james.m.young@intel.com>

