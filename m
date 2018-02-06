From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 6 Feb 2018 13:01:26 -0800
Subject: [Intel-wired-lan] [PATCH] Documentation: networking: Update
 ixgb kconfig select documentation
In-Reply-To: <1517949734-27314-1-git-send-email-clabbe@baylibre.com>
References: <1517949734-27314-1-git-send-email-clabbe@baylibre.com>
Message-ID: <CAKgT0Uc-br8akeUyjf0FenLPLxDdq14D1rppjvb1yfNU33t+Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Feb 6, 2018 at 12:42 PM, Corentin Labbe <clabbe@baylibre.com> wrote:
> Update documentation on how to enable ixgb and ixgb DCB.
> Simply remove NETDEV_10000 and replace it with the new used kconfig names.

Minor typo in the patch description. I assume you mean "ixgb and ixgbe
DCB". Also you might want to mention ixgbe somewhere in the patch
title.

>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  Documentation/networking/ixgb.txt  | 3 ++-
>  Documentation/networking/ixgbe.txt | 7 ++++---
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/networking/ixgb.txt b/Documentation/networking/ixgb.txt
> index 09f71d71920a..b10f360c57d4 100644
> --- a/Documentation/networking/ixgb.txt
> +++ b/Documentation/networking/ixgb.txt
> @@ -70,7 +70,8 @@ select m for "Intel(R) PRO/10GbE support" located at:
>        Location:
>          -> Device Drivers
>            -> Network device support (NETDEVICES [=y])
> -            -> Ethernet (10000 Mbit) (NETDEV_10000 [=y])
> +            -> Ethernet driver support (ETHERNET [=y])
> +              -> Intel devices (NET_VENDOR_INTEL [=y])
>  1. make modules && make modules_install
>
>  2. Load the module:
> diff --git a/Documentation/networking/ixgbe.txt b/Documentation/networking/ixgbe.txt
> index 687835415707..90a3860cca3d 100644
> --- a/Documentation/networking/ixgbe.txt
> +++ b/Documentation/networking/ixgbe.txt
> @@ -253,9 +253,10 @@ Additional Configurations
>
>          -> Device Drivers
>            -> Network device support (NETDEVICES [=y])
> -            -> Ethernet (10000 Mbit) (NETDEV_10000 [=y])
> -              -> Intel(R) 10GbE PCI Express adapters support
> -                -> Data Center Bridging (DCB) Support
> +            -> Ethernet driver (ETHERNET [=y])
> +              -> Intel devices (NET_VENDOR_INTEL [=y])
> +                -> Intel(R) 10GbE PCI Express adapters support (IXGBE [=y])
> +                  -> Data Center Bridging (DCB) Support (IXGBE_DCB [=y])
>
>    After these options are selected, you must rebuild your kernel and your
>    modules.
> --
> 2.13.6
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
