From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 11 Oct 2018 15:44:19 +0000
Subject: [Intel-wired-lan] [PATCH v2 12/12] Documentation: intel:
 Convert to RST format
In-Reply-To: <20181010191613.2770-13-jeffrey.t.kirsher@intel.com>
References: <20181010191613.2770-1-jeffrey.t.kirsher@intel.com>
 <20181010191613.2770-13-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D30CE1D@FMSMSX152.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Wednesday, October 10, 2018 12:16 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 12/12] Documentation: intel: Convert to
> RST format
> 
> Now that the documents have been updated to conform to the reStructured
> Text guidelines, we can now change the file extensions and update the other
> related references.
> 
> This converts all of the Intel wired LAN driver documentation to *.rst.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  Documentation/networking/00-INDEX             | 20 ----------------
>  .../networking/{e1000e.txt => e1000e.rst}     |  0
>  .../networking/{i40e.txt => i40e.rst}         |  0
>  .../networking/{iavf.txt => iavf.rst}         |  0
>  Documentation/networking/{ice.txt => ice.rst} |  0
> Documentation/networking/{igb.txt => igb.rst} |  0
>  .../networking/{igbvf.txt => igbvf.rst}       |  0
>  Documentation/networking/index.rst            |  9 ++++++++
>  .../networking/{ixgb.txt => ixgb.rst}         |  0
>  .../networking/{ixgbe.txt => ixgbe.rst}       |  0
>  .../networking/{ixgbevf.txt => ixgbevf.rst}   |  0
>  MAINTAINERS                                   | 18 +++++++--------
>  drivers/net/ethernet/intel/Kconfig            | 23 +++++++++++++++----
>  13 files changed, 37 insertions(+), 33 deletions(-)  rename
> Documentation/networking/{e1000e.txt => e1000e.rst} (100%)  rename
> Documentation/networking/{i40e.txt => i40e.rst} (100%)  rename
> Documentation/networking/{iavf.txt => iavf.rst} (100%)  rename
> Documentation/networking/{ice.txt => ice.rst} (100%)  rename
> Documentation/networking/{igb.txt => igb.rst} (100%)  rename
> Documentation/networking/{igbvf.txt => igbvf.rst} (100%)  rename
> Documentation/networking/{ixgb.txt => ixgb.rst} (100%)  rename
> Documentation/networking/{ixgbe.txt => ixgbe.rst} (100%)  rename
> Documentation/networking/{ixgbevf.txt => ixgbevf.rst} (100%)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


