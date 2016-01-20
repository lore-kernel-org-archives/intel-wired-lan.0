From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Jan 2016 22:36:51 +0000
Subject: [Intel-wired-lan] [next PATCH 3/3] i40e: Fix build warnings
 when	geneve is not enabled
In-Reply-To: <20160115044209.24270.5939.stgit@localhost.localdomain>
References: <20160115043921.24270.62791.stgit@localhost.localdomain>
 <20160115044209.24270.5939.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F989C68@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Thursday, January 14, 2016 8:42 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 3/3] i40e: Fix build warnings when
> geneve is not enabled
> 
> My default config didn't have geneve enabled.  As a result I was getting
> warnings about the port functions being defined but not used.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied,no build warnings w/ Geneve disabled
