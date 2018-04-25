From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 25 Apr 2018 00:28:17 +0000
Subject: [Intel-wired-lan] [PATCH] Documentation: e1000: Update kernel
 documentation
In-Reply-To: <20180412210452.5491-1-jeffrey.t.kirsher@intel.com>
References: <20180412210452.5491-1-jeffrey.t.kirsher@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C85DE71@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Thursday, April 12, 2018 2:05 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] Documentation: e1000: Update kernel
> documentation
> 
> Updated the e1000.txt kernel documentation with the latest information.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  Documentation/networking/e1000.txt | 55 ++++++-------------------------------
> -
>  1 file changed, 8 insertions(+), 47 deletions(-)
> 
> diff --git a/Documentation/networking/e1000.txt
> b/Documentation/networking/e1000.txt
> index 1f6ed848363d..fd4aae0d8056 100644
> --- a/Documentation/networking/e1000.txt
> +++ b/Documentation/networking/e1000.txt
> @@ -167,8 +167,8 @@ NOTE:  When e1000 is loaded with default settings
> and multiple adapters
> 
>  RxDescriptors
>  -------------
> -Valid Range:   80-256 for 82542 and 82543-based adapters
> -               80-4096 for all other supported adapters
> +Valid Range:   48-256 for 82542 and 82543-based adapters
> +               48-4096 for all other supported adapters
>  Default Value: 256
> 
>  This value specifies the number of receive buffer descriptors allocated
> @@ -230,8 +230,8 @@ speed.  Duplex should also be set when Speed is set
> to either 10 or 100.
> 
>  TxDescriptors
>  -------------
> -Valid Range:   80-256 for 82542 and 82543-based adapters
> -               80-4096 for all other supported adapters
> +Valid Range:   48-256 for 82542 and 82543-based adapters
> +               48-4096 for all other supported adapters
>  Default Value: 256
> 
>  This value is the number of transmit descriptors allocated by the driver.
> @@ -242,41 +242,10 @@ NOTE:  Depending on the available system
> resources, the request for a
>         higher number of transmit descriptors may be denied.  In this case,
>         use a lower number.
> 
> -TxDescriptorStep
> -----------------
> -Valid Range:    1 (use every Tx Descriptor)
> -                4 (use every 4th Tx Descriptor)
> -
> -Default Value:  1 (use every Tx Descriptor)
> -
> -On certain non-Intel architectures, it has been observed that intense TX
> -traffic bursts of short packets may result in an improper descriptor
> -writeback. If this occurs, the driver will report a "TX Timeout" and reset
> -the adapter, after which the transmit flow will restart, though data may
> -have stalled for as much as 10 seconds before it resumes.
> -
> -The improper writeback does not occur on the first descriptor in a system
> -memory cache-line, which is typically 32 bytes, or 4 descriptors long.
> -
> -Setting TxDescriptorStep to a value of 4 will ensure that all TX descriptors
> -are aligned to the start of a system memory cache line, and so this problem
> -will not occur.
> -
> -NOTES: Setting TxDescriptorStep to 4 effectively reduces the number of
> -       TxDescriptors available for transmits to 1/4 of the normal allocation.
> -       This has a possible negative performance impact, which may be
> -       compensated for by allocating more descriptors using the TxDescriptors
> -       module parameter.
> -
> -       There are other conditions which may result in "TX Timeout", which will
> -       not be resolved by the use of the TxDescriptorStep parameter. As the
> -       issue addressed by this parameter has never been observed on Intel
> -       Architecture platforms, it should not be used on Intel platforms.
> -
>  TxIntDelay
>  ----------
>  Valid Range:   0-65535 (0=off)
> -Default Value: 64
> +Default Value: 8
> 
>  This value delays the generation of transmit interrupts in units of
>  1.024 microseconds.  Transmit interrupt reduction can improve CPU
> @@ -288,7 +257,7 @@ TxAbsIntDelay
>  -------------
>  (This parameter is supported only on 82540, 82545 and later adapters.)
>  Valid Range:   0-65535 (0=off)
> -Default Value: 64
> +Default Value: 32
> 
>  This value, in units of 1.024 microseconds, limits the delay in which a
>  transmit interrupt is generated.  Useful only if TxIntDelay is non-zero,
> @@ -310,7 +279,7 @@ Copybreak
>  ---------
>  Valid Range:   0-xxxxxxx (0=off)
>  Default Value: 256
> -Usage: insmod e1000.ko copybreak=128
> +Usage: modprobe e1000.ko copybreak=128
> 
>  Driver copies all packets below or equaling this size to a fresh RX
>  buffer before handing it up the stack.
> @@ -328,14 +297,6 @@ Default Value:  0 (disabled)
>  Allows PHY to turn off in lower power states. The user can turn off
>  this parameter in supported chipsets.
> 
> -KumeranLockLoss
> ----------------
> -Valid Range: 0-1
> -Default Value: 1 (enabled)
> -
> -This workaround skips resetting the PHY at shutdown for the initial
> -silicon releases of ICH8 systems.
> -
>  Speed and Duplex Configuration
>  ==============================
> 
> @@ -435,7 +396,7 @@ Additional Configurations
>    version 1.6 or later is required for this functionality.
> 
>    The latest release of ethtool can be found from
> -  https://www.kernel.org/pub/software/network/ethtool/
> +  http://ftp.kernel.org/pub/software/network/ethtool/

This change needs to be removed.  The existing link, https://www.kernel.org/pub/software/network/ethtool/, works fine but the for the new link, ftp.kernel.org name does not resolve.

> 
>    Enabling Wake on LAN* (WoL)
>    ---------------------------
> --
> 2.14.3
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
