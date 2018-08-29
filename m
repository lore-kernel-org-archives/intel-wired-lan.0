From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 29 Aug 2018 00:07:54 +0000
Subject: [Intel-wired-lan] [PATCH v4] Documentation: e1000e: Update
 kernel documentation
In-Reply-To: <20180827193513.12705-1-jeffrey.t.kirsher@intel.com>
References: <20180827193513.12705-1-jeffrey.t.kirsher@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B96551A89@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Jeff Kirsher
> Sent: Monday, August 27, 2018 12:35 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v4] Documentation: e1000e: Update kernel
> documentation
> 
> Updated the e1000e kernel documentation with the latest information.
> Also remove the command line parameters, which do not exist with the
> in-kernel driver.  Converted the documentation to the RST format.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
> v1/v2: initial documentation update
> 
> v3: convert to RST format, remove module parameters that do not exist
>     and add SPDX header
> 
> v4: add back in module parameters documentation
> 
>  Documentation/networking/e1000e.rst | 361
> ++++++++++++++++++++++++++++
>  Documentation/networking/e1000e.txt | 312 ------------------------
>  Documentation/networking/index.rst  |   1 +
>  MAINTAINERS                         |   2 +-
>  drivers/net/ethernet/intel/Kconfig  |   3 +
>  5 files changed, 366 insertions(+), 313 deletions(-)
>  create mode 100644 Documentation/networking/e1000e.rst
>  delete mode 100644 Documentation/networking/e1000e.txt
> 

This appears to have some rst errors, it fails when I run rst2html:
u1485:[1]/usr/src/kernels/next-queue/Documentation/networking> rst2html e1000e.rst > ~/e1000e.html
e1000e.rst:201: (WARNING/2) Block quote ends without a blank line; unexpected unindent.
e1000e.rst:265: (ERROR/3) Unexpected indentation.
u1485:[1]/usr/src/kernels/next-queue/Documentation/networking>
