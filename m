From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 11 Oct 2019 01:23:25 +0000
Subject: [Intel-wired-lan] [PATCH] Documentation: networking: device
 drivers: Remove stray asterisks
In-Reply-To: <20191002150956.16234-1-j.neuschaefer@gmx.net>
References: <20191002150956.16234-1-j.neuschaefer@gmx.net>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9714C898@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-owner at vger.kernel.org]
> On Behalf Of Jonathan Neusch?fer
> Sent: Wednesday, October 2, 2019 8:10 AM
> To: linux-doc at vger.kernel.org
> Cc: Jonathan Neusch?fer <j.neuschaefer@gmx.net>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; David S. Miller <davem@davemloft.net>;
> Jonathan Corbet <corbet@lwn.net>; Shannon Nelson <snelson@pensando.io>;
> Pensando Drivers <drivers@pensando.io>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [PATCH] Documentation: networking: device drivers: Remove stray
> asterisks
> 
> These asterisks were once references to a line that said:
>   "* Other names and brands may be claimed as the property of others."
> But now, they serve no purpose; they can only irritate the reader.
> 
> Fixes: de3edab4276c ("e1000: update README for e1000")
> Fixes: a3fb65680f65 ("e100.txt: Cleanup license info in kernel doc")
> Fixes: da8c01c4502a ("e1000e.txt: Add e1000e documentation")
> Fixes: f12a84a9f650 ("Documentation: fm10k: Add kernel documentation")
> Fixes: b55c52b1938c ("igb.txt: Add igb documentation")
> Fixes: c4e9b56e2442 ("igbvf.txt: Add igbvf Documentation")
> Fixes: d7064f4c192c ("Documentation/networking/: Update Intel wired LAN
> driver documentation")
> Fixes: c4b8c01112a1 ("ixgbevf.txt: Update ixgbevf documentation")
> Fixes: 1e06edcc2f22 ("Documentation: i40e: Prepare documentation for RST
> conversion")
> Fixes: 105bf2fe6b32 ("i40evf: add driver to kernel build system")
> Fixes: 1fae869bcf3d ("Documentation: ice: Prepare documentation for RST
> conversion")
> Fixes: df69ba43217d ("ionic: Add basic framework for IONIC Network device
> driver")
> Signed-off-by: Jonathan Neusch?fer <j.neuschaefer@gmx.net>
> ---
>  .../networking/device_drivers/intel/e100.rst       | 14 +++++++-------
>  .../networking/device_drivers/intel/e1000.rst      | 12 ++++++------
>  .../networking/device_drivers/intel/e1000e.rst     | 14 +++++++-------
>  .../networking/device_drivers/intel/fm10k.rst      | 10 +++++-----
>  .../networking/device_drivers/intel/i40e.rst       |  8 ++++----
>  .../networking/device_drivers/intel/iavf.rst       |  8 ++++----
>  .../networking/device_drivers/intel/ice.rst        |  6 +++---
>  .../networking/device_drivers/intel/igb.rst        | 12 ++++++------
>  .../networking/device_drivers/intel/igbvf.rst      |  6 +++---
>  .../networking/device_drivers/intel/ixgbe.rst      | 10 +++++-----
>  .../networking/device_drivers/intel/ixgbevf.rst    |  6 +++---
>  .../networking/device_drivers/pensando/ionic.rst   |  6 +++---
>  12 files changed, 56 insertions(+), 56 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

