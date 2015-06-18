From: Young, James M <james.m.young@intel.com>
Date: Thu, 18 Jun 2015 00:09:04 +0000
Subject: [Intel-wired-lan] [net-next S5 07/15] i40e: do a proper reset
 when	disabling a VF
In-Reply-To: <1430161042-28494-8-git-send-email-catherine.sullivan@intel.com>
References: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
 <1430161042-28494-8-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA19AC1@ORSMSX102.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [net-next S5 07/15] i40e: do a proper reset when
> disabling a VF
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> The VF disable code was just whanging on the reset bit without properly
> cleaning up the VF, which would leave the VF in an indeterminate state from
> which it could not recover. Fix this by notifying the VF and then by calling the
> normal VF reset routine.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I862b9dfa919368773cbdc212b805b520db2f7430
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
Tested-by: Jim Young <james.m.young@intel.com>

