From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 29 Aug 2018 01:14:00 +0000
Subject: [Intel-wired-lan] [PATCH v5] Documentation: fm10k: Add kernel
 documentation
In-Reply-To: <20180820203745.13448-1-jeffrey.t.kirsher@intel.com>
References: <20180820203745.13448-1-jeffrey.t.kirsher@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B96551B01@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Jeff Kirsher
> Sent: Monday, August 20, 2018 1:38 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v5] Documentation: fm10k: Add kernel
> documentation
> 
> Added the fm10k kernel documentation, which apparently was missing.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
> v1/v2: Initial attempt to produce fm10k documentation
> 
> v3: converted to RST format and addressed Shannon Nelson's feedback
> 
> V4: Fixed documentation title, no reason for it to say "README ..." and
>     addressed more of Shannon's feedback
> 
> v5: added SPDX-License-Identifier
> 
>  Documentation/networking/fm10k.rst | 141
> +++++++++++++++++++++++++++++
>  Documentation/networking/index.rst |   1 +
>  MAINTAINERS                        |   1 +
>  drivers/net/ethernet/intel/Kconfig |   3 +
>  4 files changed, 146 insertions(+)
>  create mode 100644 Documentation/networking/fm10k.rst
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
