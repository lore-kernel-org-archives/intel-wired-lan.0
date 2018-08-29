From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 29 Aug 2018 01:08:42 +0000
Subject: [Intel-wired-lan] Documentation: networking: ixgb: Remove
 reference to IXGB_NAPI
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B96551AEA@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> NAPI is enabled by default and IXGB_NAPI was removed since
> commit 6d37ab282e24 ("ixgb: make NAPI the only option and the default")
> Update the doc accordingly.

> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  Documentation/networking/ixgb.txt | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
I'm sure I applied a "Tested-by:" on this before, but it's not showing in patchwork so...

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

