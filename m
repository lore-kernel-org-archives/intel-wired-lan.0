From: Amit Pundir <amit.pundir@linaro.org>
Date: Mon, 27 Nov 2017 19:06:16 +0530
Subject: [Intel-wired-lan] [PATCH for-4.14.y 0/5] e1000e: Upstream fixes
 for linux-4.14.y
In-Reply-To: <1511787217-10987-1-git-send-email-amit.pundir@linaro.org>
References: <1511787217-10987-1-git-send-email-amit.pundir@linaro.org>
Message-ID: <CAMi1Hd11D3J5V0-oBhcthO_6T4CQX8v3DcLV8f_EVy9UyvkRAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 27 November 2017 at 18:23, Amit Pundir <amit.pundir@linaro.org> wrote:
> Hi Greg,
>
> Found few e100e upstream fixes from Benjamin Poirier in lede
> source tree, https://git.lede-project.org/?p=source.git, and
> these fixes seem reasonable enough for 4.14.y too.
>
> Also submitting an e1000e buffer overrun fix by Sasha Neftin.
>
> Cherry-picked and build tested for linux v4.14.2 for ARCH=arm/arm64.
>
> Regards,
> Amit Pundir
>
>
> Benjamin Poirier (4):
>   e1000e: Fix error path in link detection
>   e1000e: Fix return value test
>   e1000e: Separate signaling for link check/link up
>   e1000e: Avoid receiver overrun interrupt bursts

Also all the above fixes from Benjamin Poirier are to be marked for
4.9 and first 3 fixes for 4.4, 3.18 as well. Build tested for
ARCH=arm/arm64.

Regards,
Amit Pundir

>
> Sasha Neftin (1):
>   e1000e: fix buffer overrun while the I219 is processing DMA
>     transactions
>
>  drivers/net/ethernet/intel/e1000e/defines.h |  1 +
>  drivers/net/ethernet/intel/e1000e/mac.c     | 11 +++++--
>  drivers/net/ethernet/intel/e1000e/netdev.c  | 45 ++++++++++++++++++++---------
>  drivers/net/ethernet/intel/e1000e/phy.c     |  7 +++--
>  4 files changed, 45 insertions(+), 19 deletions(-)
>
> --
> 2.7.4
>
