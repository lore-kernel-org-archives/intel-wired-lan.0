From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 27 Nov 2018 20:36:05 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: fix kerneldoc for xsk methods
In-Reply-To: <8DB98857419E2C4496D37EA0B91B597076B0D9EA@IRSMSX103.ger.corp.intel.com>
References: <8DB98857419E2C4496D37EA0B91B597076B0D9EA@IRSMSX103.ger.corp.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D32BF05@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of Sokolowski, Jan
>Sent: Tuesday, November 27, 2018 12:20 AM
To: intel-wired-lan@osuosl.org
>Cc: netdev at vger.kernel.org
>Subject: [Intel-wired-lan] [PATCH] i40e: fix kerneldoc for xsk methods
>
>One method, xsk_umem_setup, had an incorrect kernel doc
>description, which has been corrected.
>
>Also fixes small typos found in the comments.
>
>Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
>---
>drivers/net/ethernet/intel/i40e/i40e_xsk.c | 14 +++++++-------
>1 file changed, 7 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


