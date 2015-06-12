From: Young, James M <james.m.young@intel.com>
Date: Fri, 12 Jun 2015 18:19:11 +0000
Subject: [Intel-wired-lan] [net-next S5 04/15] i40e: Remove
	incorrect	#ifdef's
In-Reply-To: <1430161042-28494-5-git-send-email-catherine.sullivan@intel.com>
References: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
 <1430161042-28494-5-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA16E07@ORSMSX102.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [net-next S5 04/15] i40e: Remove incorrect #ifdef's
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> This patch removes some #ifdef's that should not be there. They were
> stopping code that is needed from being compiled in.
> 
> With these #ifdef's removed, changes are needed in the driver to fix some
> compile errors: adding missing parameters to the definition of
> ndo_bridge_setlink and a ndo_dflt_brige_getlink call.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Change-ID: I5516614e1bc50b6bca0647cef971bc96161ba2de
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 

Tested-by: Jim Young <james.m.young@intel.com>

