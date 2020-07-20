From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 20 Jul 2020 10:44:44 -0700
Subject: [Intel-wired-lan] [PATCH for v5.9] Documentation: intel:
 Replace HTTP links with HTTPS ones
In-Reply-To: <20200719154836.59873-1-grandmaster@al2klimov.de>
References: <20200719154836.59873-1-grandmaster@al2klimov.de>
Message-ID: <CAKgT0Ud4jwxD_NHqLdcWXJSdVJ3CZtzosCwODtdfKnV48GfPfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Jul 19, 2020 at 8:49 AM Alexander A. Klimov
<grandmaster@al2klimov.de> wrote:
>
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
>
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
>
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
>
>  If there are any URLs to be removed completely
>  or at least not (just) HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
>
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
>
>  If you apply the patch, please let me know.
>
>  Sorry again to all maintainers who complained about subject lines.
>  Now I realized that you want an actually perfect prefixes,
>  not just subsystem ones.
>  I tried my best...
>  And yes, *I could* (at least half-)automate it.
>  Impossible is nothing! :)
>
>
>  Documentation/networking/device_drivers/intel/e100.rst  | 4 ++--
>  Documentation/networking/device_drivers/intel/e1000.rst | 2 +-
>  Documentation/networking/device_drivers/intel/fm10k.rst | 2 +-
>  Documentation/networking/device_drivers/intel/iavf.rst  | 2 +-
>  Documentation/networking/device_drivers/intel/igb.rst   | 2 +-
>  Documentation/networking/device_drivers/intel/igbvf.rst | 2 +-
>  Documentation/networking/device_drivers/intel/ixgb.rst  | 2 +-
>  7 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/networking/device_drivers/intel/e100.rst b/Documentation/networking/device_drivers/intel/e100.rst
> index 3ac21e7119a7..3d4a9ba21946 100644
> --- a/Documentation/networking/device_drivers/intel/e100.rst
> +++ b/Documentation/networking/device_drivers/intel/e100.rst
> @@ -41,7 +41,7 @@ Identifying Your Adapter
>
>  For information on how to identify your adapter, and for the latest Intel
>  network drivers, refer to the Intel Support website:
> -http://www.intel.com/support
> +https://www.intel.com/support
>
>  Driver Configuration Parameters
>  ===============================
> @@ -179,7 +179,7 @@ filtering by
>  Support
>  =======
>  For general information, go to the Intel support website at:
> -http://www.intel.com/support/
> +https://www.intel.com/support/
>
>  or the Intel Wired Networking project hosted by Sourceforge at:
>  http://sourceforge.net/projects/e1000
> diff --git a/Documentation/networking/device_drivers/intel/e1000.rst b/Documentation/networking/device_drivers/intel/e1000.rst
> index 4aaae0f7d6ba..9d99ff15d737 100644
> --- a/Documentation/networking/device_drivers/intel/e1000.rst
> +++ b/Documentation/networking/device_drivers/intel/e1000.rst
> @@ -44,7 +44,7 @@ NOTES:
>          For more information about the InterruptThrottleRate,
>          RxIntDelay, TxIntDelay, RxAbsIntDelay, and TxAbsIntDelay
>          parameters, see the application note at:
> -        http://www.intel.com/design/network/applnots/ap450.htm
> +        https://www.intel.com/design/network/applnots/ap450.htm

So I think this link is broken. What it leads you to is not the
application note. We should either find the replacement link or just
drop this reference.
