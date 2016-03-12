From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 12 Mar 2016 00:44:42 +0000
Subject: [Intel-wired-lan] [PATCH 5/5] igb: Add support for bulk Tx
 cleanup & cleanup boolean logic
In-Reply-To: <20160307173021.5682.83995.stgit@localhost.localdomain>
References: <20160307172722.5682.38580.stgit@localhost.localdomain>
 <20160307173021.5682.83995.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81EACFFE@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, March 7, 2016 9:30 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 5/5] igb: Add support for bulk Tx cleanup &
> cleanup boolean logic
> 
> This patch enables bulk free in Tx cleanup for igb and cleans up the
> boolean logic in the polling routines for igb in the hopes of avoiding
> any mix-ups similar to what occurred with i40e and i40evf.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c |   12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
