From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 29 Aug 2018 00:42:44 +0000
Subject: [Intel-wired-lan] [PATCH v2] Documentation: igb: Update kernel
 documentation
In-Reply-To: <20180827210640.11543-1-jeffrey.t.kirsher@intel.com>
References: <20180827210640.11543-1-jeffrey.t.kirsher@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B96551AC6@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Jeff Kirsher
> Sent: Monday, August 27, 2018 2:07 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2] Documentation: igb: Update kernel
> documentation
> 
> Updated the igb kernel documentation with the latest information.
> Cleaned up the command line parameters, which do not exist with the
> in-kernel driver.  Converted the documentation to the RST format.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
> v1: Initial documentation update
> 
> v2: Convert to RST format and clean up command line parameters that do
>     not exist
> 
>  Documentation/networking/igb.rst   | 188
> +++++++++++++++++++++++++++++
>  Documentation/networking/igb.txt   | 129 --------------------
>  Documentation/networking/index.rst |   1 +
>  MAINTAINERS                        |   2 +-
>  drivers/net/ethernet/intel/Kconfig |   2 +-
>  5 files changed, 191 insertions(+), 131 deletions(-)
>  create mode 100644 Documentation/networking/igb.rst
>  delete mode 100644 Documentation/networking/igb.txt
> 

A small nits.  In the Command Line Parameters section:
> +The default value for each parameter is generally the recommended setting,
> +unless otherwise noted.

The only command line option remaining in the this document is max_vfs and it does not have a logical default, so the statement of a default value being recommended does not make a lot of sense.

But I don't feel this is worth blocking the otherwise needed changes. so...

Tested-by: Aaron Brown <aaron.f.brown@intel.com>


