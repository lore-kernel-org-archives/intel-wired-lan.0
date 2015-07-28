From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 28 Jul 2015 21:11:30 +0000
Subject: [Intel-wired-lan] [next PATCH S9 09/15] i40e: Remove useless
 message
In-Reply-To: <1437684884-222825-10-git-send-email-catherine.sullivan@intel.com>
References: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
 <1437684884-222825-10-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE520@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, July 23, 2015 1:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S9 09/15] i40e: Remove useless
> message
> 
> From: Greg Rose <gregory.v.rose@intel.com>
> 
> Remove a useless message that blathers on whenever a vxlan port is
> deleted.
> 
> Signed-off-by: Greg Rose <gregory.v.rose@intel.com>
> Change-ID: If63fb8cf38e56cf433b68e498f11389de51919ba
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 3 ---
>  1 file changed, 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Present in git log, code changes present in tree.
