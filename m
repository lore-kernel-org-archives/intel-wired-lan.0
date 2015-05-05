From: Young, James M <james.m.young@intel.com>
Date: Tue, 5 May 2015 17:35:02 +0000
Subject: [Intel-wired-lan] [net-next S4 07/15] i40evf: restore state
In-Reply-To: <1429229172-143692-8-git-send-email-catherine.sullivan@intel.com>
References: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
 <1429229172-143692-8-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783E9F8F95@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, April 16, 2015 5:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next S4 07/15] i40evf: restore state
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> If the netdev is closed when a reset occurs, the adapter state will be left in
> the RESETTING state incorrectly. Correct this deficiency.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Ia0c5bf0449f7c81609f6f646e6b805f030d3360d
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

My testing for this patch showed the issue as unresolved.  
