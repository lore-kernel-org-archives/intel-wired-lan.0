From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 12 Oct 2018 01:00:23 +0000
Subject: [Intel-wired-lan] [PATCH v2 11/12] Documentation: fm10k: Add
 kernel documentation
In-Reply-To: <20181010191613.2770-12-jeffrey.t.kirsher@intel.com>
References: <20181010191613.2770-1-jeffrey.t.kirsher@intel.com>
 <20181010191613.2770-12-jeffrey.t.kirsher@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9657A5E6@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Wednesday, October 10, 2018 12:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 11/12] Documentation: fm10k: Add
> kernel documentation
> 
> Added the fm10k kernel documentation, which apparently was missing.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  Documentation/networking/fm10k.rst | 141
> +++++++++++++++++++++++++++++
>  Documentation/networking/index.rst |   1 +
>  MAINTAINERS                        |   1 +
>  drivers/net/ethernet/intel/Kconfig |   3 +
>  4 files changed, 146 insertions(+)
>  create mode 100644 Documentation/networking/fm10k.rst
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
<snip>

With the minor exception below:

> +Identifying Your Adapter
> +========================
> +The driver in this release is compatible with devices based on the Intel(R)
> +Ethernet Multi-host Controller.
> +
> +For information on how to identify your adapter, and for the latest Intel
> +network drivers, refer to the Intel Support website:
> +http://www.intel.com/support
>

This does resolve to https, but should be listed as https:// to match other instance of support site later in file.


