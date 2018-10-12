From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 12 Oct 2018 01:26:57 +0000
Subject: [Intel-wired-lan] [PATCH v2 09/12] Documentation: iavf: Prepare
 documentation for RST conversion
In-Reply-To: <20181010191613.2770-10-jeffrey.t.kirsher@intel.com>
References: <20181010191613.2770-1-jeffrey.t.kirsher@intel.com>
 <20181010191613.2770-10-jeffrey.t.kirsher@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9657A60F@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Wednesday, October 10, 2018 12:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 09/12] Documentation: iavf: Prepare
> documentation for RST conversion
> 
> Before making the conversion to the rst (reStructured Text) format, there
> are changes needed to the documentation so that there are no build errors.
> 
> Also fixed old/broken URLs to the correct or updated URL.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  Documentation/networking/iavf.txt | 271
> +++++++++++++++++++++++++++---
>  1 file changed, 248 insertions(+), 23 deletions(-)
> 
<snip>

>  Identifying Your Adapter
>  ========================
> +The driver in this kernel is compatible with devices based on the following:
> + * Intel(R) XL710 X710 Virtual Function
> + * Intel(R) X722 Virtual Function
> + * Intel(R) XXV710 Virtual Function
> + * Intel(R) Ethernet Adaptive Virtual Function
> +
> +For the best performance, make sure the latest NVM/FW is installed on
> your
> +device.
> +
> +For information on how to identify your adapter, and for the latest
> NVM/FW
> +images and Intel network drivers, refer to the Intel Support website:
> +http://www.intel.com/support

Oh right, this should be https://...  Resolves, but be good to have it right.
