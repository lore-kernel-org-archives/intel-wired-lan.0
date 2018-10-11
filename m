From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 11 Oct 2018 21:39:35 +0000
Subject: [Intel-wired-lan] [PATCH v2 05/12] Documentation: igbvf:
 Prepare documentation for RST conversion
In-Reply-To: <20181010191613.2770-6-jeffrey.t.kirsher@intel.com>
References: <20181010191613.2770-1-jeffrey.t.kirsher@intel.com>
 <20181010191613.2770-6-jeffrey.t.kirsher@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9657A49E@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Wednesday, October 10, 2018 12:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 05/12] Documentation: igbvf: Prepare
> documentation for RST conversion
> 
> Before making the conversion to the rst (reStructured Text) format, there
> are changes needed to the documentation so that there are no build errors.
> 
> Also fixed old/broken URLs to the correct or updated URL.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  Documentation/networking/igbvf.txt | 82 ++++++++++++------------------
>  1 file changed, 33 insertions(+), 49 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
... with one minor suggestion below.
<snip>

>  Identifying Your Adapter
>  ========================
> +For information on how to identify your adapter, and for the latest Intel
> +network drivers, refer to the Intel Support website:
> +http://www.intel.com/support
>
This should be https:// This does currently resolve to https:// so it works, but should be https:// to match the second (near) instance of this URL below.  

> -The igbvf driver supports 82576-based virtual function devices that can only
> -be activated on kernels that support SR-IOV.

<snip>
