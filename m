From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 19 Nov 2015 22:08:42 +0000
Subject: [Intel-wired-lan] [next-queue, v2,
 1/8] e1000: clean up the checking logic
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81D3D735@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Resending with subject line (hopefully) de-corrupted so patchwork will pick it up.

> The checking logic needed some clean-up work, so we rewrite it by
> checking for break first. With that change in place, we can even move
> the second check for goto statement outside of the loop.
>
> As this is merely a cleanup, no functional change is involved. The
> questionable 'tmp != 0xFF' is intentionally left alone.
>
> Mark Rustad and Alexander Duyck contributed to this patch.
>
> Signed-off-by: Jean Sacren <sakiwit@gmail.com>
> Cc: "Rustad, Mark D" <mark.d.rustad@intel.com>
> Cc: Alexander Duyck <alexander.duyck@gmail.com>
> ---
> v2:
>
> 1) Update the changelog to reflect the rewrite of the checking logic and
>    others' contributions;
> 2) Update the changelog title accordingly;
> 3) Add credits and cc the pertinent parties.
> 
>  drivers/net/ethernet/intel/e1000/e1000_main.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

