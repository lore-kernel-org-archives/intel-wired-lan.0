From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 19 Nov 2015 22:17:16 +0000
Subject: [Intel-wired-lan] [next-queue, v2,
 3/8] e1000e: clean up the local variable
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81D3D773@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Jean Sacren <sakiwit@gmail.com>

> The local variable 'ret' doesn't serve much purpose so we might as well
> clean it up.

> Signed-off-by: Jean Sacren <sakiwit@gmail.com>
> ---
> v2: No changes.

> drivers/net/ethernet/intel/e1000e/netdev.c | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
