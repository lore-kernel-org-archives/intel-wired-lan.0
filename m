From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Aug 2016 16:42:15 +0000
Subject: [Intel-wired-lan] [PATCH 3/3] ixgbevf: only check Tx
	queue	enablement when debugging
In-Reply-To: <20160729173016.25548.28505.stgit@localhost6.localdomain6>
References: <20160729173006.25548.93033.stgit@localhost6.localdomain6>
 <20160729173016.25548.28505.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F72BB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Friday, July 29, 2016 10:30 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 3/3] ixgbevf: only check Tx queue
> enablement when debugging
> 
> Following a write the VFTXDCTL.ENABLE bit is set only when the Tx queue is
> actually enabled, which may not happen during the configure phase even if
> we waited for it. Make this check debug only since this is causing confusion
> with users who notice the warning in dmesg.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

