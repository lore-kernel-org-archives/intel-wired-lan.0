From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 28 Jul 2015 21:09:30 +0000
Subject: [Intel-wired-lan] [next PATCH S9 08/15] i40e: limit debugfs io
 ops
In-Reply-To: <1437684884-222825-9-git-send-email-catherine.sullivan@intel.com>
References: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
 <1437684884-222825-9-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE510@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S9 08/15] i40e: limit debugfs io ops
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Don't let the debugfs register read and write commands try to access outside
> of the ioremapped space.  While we're at it, remove the use of a misleading
> constant.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: Ifce2893e232c65c7a76c23532c658f298218a81b
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |  3 ++-
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 12 ++++++------
>  drivers/net/ethernet/intel/i40e/i40e_main.c    |  9 ++++-----
>  3 files changed, 12 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Present in git log, code changes present in tree.
