From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 7 Feb 2018 22:54:19 +0000
Subject: [Intel-wired-lan] Documentation: networking: ixgb: Remove
 reference to IXGB_NAPI
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C7E2AAF@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> Date: Mon, 29 Jan 2018 12:17:54 +0000
>  From: Corentin Labbe <clabbe@baylibre.com>
> To: corbet at lwn.net, jeffrey.t.kirsher at intel.com
> Cc: Corentin Labbe <clabbe@baylibre.com>, intel-wired-lan at lists.osuosl.org, 
> linux-kernel at vger.kernel.org, linux-doc at vger.kernel.org
> List-Id: Intel Wired Ethernet Linux Kernel Driver Development
>  <intel-wired-lan.osuosl.org>
> 
> NAPI is enabled by default and IXGB_NAPI was removed since
> commit 6d37ab282e24 ("ixgb: make NAPI the only option and the default")
> Update the doc accordingly.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  Documentation/networking/ixgb.txt | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
