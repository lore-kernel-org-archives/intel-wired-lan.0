From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 11 Oct 2018 21:14:49 +0000
Subject: [Intel-wired-lan] [PATCH v2 03/12] Documentation: e1000e:
 Prepare documentation for RST conversion
In-Reply-To: <20181010191613.2770-4-jeffrey.t.kirsher@intel.com>
References: <20181010191613.2770-1-jeffrey.t.kirsher@intel.com>
 <20181010191613.2770-4-jeffrey.t.kirsher@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9657A463@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Wednesday, October 10, 2018 12:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 03/12] Documentation: e1000e: Prepare
> documentation for RST conversion
> 
> Before making the conversion to the rst (reStructured Text) format, there
> are changes needed to the documentation so that there are no build errors.
> 
> Also fixed old/broken URLs to the correct or updated URL.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  Documentation/networking/e1000e.txt | 426 ++++++++++++++++------------
>  1 file changed, 248 insertions(+), 178 deletions(-)
> <snip >

> 
> -Command Line Parameters
> -=======================
> +    modprobe e1000e InterruptThrottleRate=16000,16000
> 
> +In this case, there are two network ports supported by e1000e in the
> system.
>  The default value for each parameter is generally the recommended setting,
>  unless otherwise noted.
> 
> -NOTES:  For more information about the InterruptThrottleRate,
> -        RxIntDelay, TxIntDelay, RxAbsIntDelay, and TxAbsIntDelay
> -        parameters, see the application note at:
> -        http://www.intel.com/design/network/applnots/ap450.htm
> +NOTE: A descriptor describes a data buffer and attributes related to the
> data
> +buffer. This information is accessed by the hardware.
> 

Re-reading after I gave me Tested-by: (the file was still open) ... I don't this makes a lot of sense right here in the general description of parameter usage.  It probably makes more sense to be down with RxIntDelay and TxIntDelay as I believe those are the only places this file discusses descriptors.  But then it would either be between parameter descriptions or repeated, so maybe leaving it here is best.

>  InterruptThrottleRate
>  ---------------------
<snip>
