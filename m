From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 29 Aug 2018 01:53:12 +0000
Subject: [Intel-wired-lan] [PATCH v3] Documentation: igbvf: Update
 kernel documentation
In-Reply-To: <20180827221522.16362-1-jeffrey.t.kirsher@intel.com>
References: <20180827221522.16362-1-jeffrey.t.kirsher@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B96551B46@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Jeff Kirsher
> Sent: Monday, August 27, 2018 3:15 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3] Documentation: igbvf: Update kernel
> documentation
> 
> Updated the igbvf kernel documentation with the latest information.
> Cleaned up references to older kernel versions and converted the
> documentation to the RST format
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
> v1: Initial submission
> 
> v2: fixed up documentation based on community feedback and internal
>     review
> 
> v3: cleaned up old kernel version references, converted to RST format
> 
>  Documentation/networking/igbvf.rst | 64 ++++++++++++++++++++++++
>  Documentation/networking/igbvf.txt | 80 ------------------------------
>  Documentation/networking/index.rst |  1 +
>  MAINTAINERS                        |  2 +-
>  drivers/net/ethernet/intel/Kconfig |  2 +-
>  5 files changed, 67 insertions(+), 82 deletions(-)
>  create mode 100644 Documentation/networking/igbvf.rst
>  delete mode 100644 Documentation/networking/igbvf.txt

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
