From: Young, James M <james.m.young@intel.com>
Date: Wed, 6 May 2015 16:33:36 +0000
Subject: [Intel-wired-lan] [net-next S4 05/15] i40e: Remove unnecessary
 pf	members
In-Reply-To: <1429229172-143692-6-git-send-email-catherine.sullivan@intel.com>
References: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
 <1429229172-143692-6-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783E9F9242@ORSMSX102.amr.corp.intel.com>
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
> Cc: Singhai, Anjali
> Subject: [Intel-wired-lan] [net-next S4 05/15] i40e: Remove unnecessary pf
> members
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> We can use the stat index macro directly, a variable is not required.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: I19f08ac16353dc0cd87a1a8248d714e15a54aa8a
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |  2 --
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 10 ++++------
>  3 files changed, 5 insertions(+), 9 deletions(-)

Tested-by: Jim Young <james.m.young@intel.com>

