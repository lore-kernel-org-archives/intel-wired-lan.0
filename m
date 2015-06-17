From: Young, James M <james.m.young@intel.com>
Date: Wed, 17 Jun 2015 23:52:11 +0000
Subject: [Intel-wired-lan] [net-next S5 08/15] i40e: un-disable VF
	after	reset
In-Reply-To: <1430161042-28494-9-git-send-email-catherine.sullivan@intel.com>
References: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
 <1430161042-28494-9-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA19AA4@ORSMSX102.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [net-next S5 08/15] i40e: un-disable VF after reset
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> When a VF is disabled, there is no way for it to recover until either the PF
> driver is reloaded or SR-IOV is disabled and enabled. To correct this, enable
> the VF after a successful reset.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I9e0788476c4d53d5407961b503febdfff2b8a7c6
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
Tested-by: Jim Young <james.m.young@intel.com>

