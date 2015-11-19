From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 19 Nov 2015 22:21:31 +0000
Subject: [Intel-wired-lan] :  [next-queue, v2,
 7/8] e1000: fix kernel-doc argument being missing
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81D3D798@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Jean Sacren <sakiwit@gmail.com>
>
> Due to historical reason, 'phy_data' has never been included in the
> kernel doc. Fix it so that the requirement could be fulfilled.
>
> Signed-off-by: Jean Sacren <sakiwit@gmail.com>
> ---
> v2: No changes.
>
> drivers/net/ethernet/intel/e1000/e1000_hw.c | 1 +
> 1 file changed, 1 insertion(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
