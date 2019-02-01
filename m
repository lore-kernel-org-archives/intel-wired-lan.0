From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 1 Feb 2019 23:47:00 +0000
Subject: [Intel-wired-lan] [next v2] docs/networking: fix formatting of
 Intel drivers documentation
In-Reply-To: <20181212224424.16787-1-jeffrey.t.kirsher@intel.com>
References: <20181212224424.16787-1-jeffrey.t.kirsher@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B96621285@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Wednesday, December 12, 2018 2:44 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Subject: [Intel-wired-lan] [next v2] docs/networking: fix formatting of Intel
> drivers documentation
> 
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The documentation of Intel drivers is missing the heading adornment for
> document titles.
> 
> This causes the generated html to have TOC entries from these documents
> to
> appear as top level TOC entries:
> 
> * Linux* Base Driver for Intel(R) Ethernet Network Connection
> * Contents
> * Identifying Your Adapter
> * Command Line Parameters
>   * AutoNeg
>   * Duplex
>   ...
> 
> Add overline heading adornment to document titles.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
> v2: update the Documentation path with the current net-next tree
> 
> Another interesting thing is that many of these documents have very similar
> or even identical titles.
> It would be nice to include the adapter name in the titles to make them
> distinguishable.
> 
>  Documentation/networking/device_drivers/intel/e100.rst    | 1 +
>  Documentation/networking/device_drivers/intel/e1000.rst   | 1 +
>  Documentation/networking/device_drivers/intel/e1000e.rst  | 1 +
>  Documentation/networking/device_drivers/intel/fm10k.rst   | 1 +
>  Documentation/networking/device_drivers/intel/i40e.rst    | 1 +
>  Documentation/networking/device_drivers/intel/iavf.rst    | 1 +
>  Documentation/networking/device_drivers/intel/ice.rst     | 1 +
>  Documentation/networking/device_drivers/intel/igb.rst     | 1 +
>  Documentation/networking/device_drivers/intel/igbvf.rst   | 1 +
>  Documentation/networking/device_drivers/intel/ixgb.rst    | 1 +
>  Documentation/networking/device_drivers/intel/ixgbe.rst   | 1 +
>  Documentation/networking/device_drivers/intel/ixgbevf.rst | 1 +
>  12 files changed, 12 insertions(+)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
