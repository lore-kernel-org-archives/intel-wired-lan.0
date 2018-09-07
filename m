From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 7 Sep 2018 00:04:15 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] Documentation: ixgb: Convert to
 RST format
In-Reply-To: <20180829153939.26656-2-jeffrey.t.kirsher@intel.com>
References: <20180829153939.26656-1-jeffrey.t.kirsher@intel.com>
 <20180829153939.26656-2-jeffrey.t.kirsher@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B96555CA6@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Wednesday, August 29, 2018 8:40 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/2] Documentation: ixgb: Convert to RST
> format
> 
> Now that the document has been updated to conform to the reStructured
> Text
> guidelines, we can now change the file extension and update the other
> related references.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  Documentation/networking/index.rst              | 1 +
>  Documentation/networking/{ixgb.txt => ixgb.rst} | 0
>  MAINTAINERS                                     | 2 +-
>  drivers/net/ethernet/intel/Kconfig              | 2 +-
>  4 files changed, 3 insertions(+), 2 deletions(-)
>  rename Documentation/networking/{ixgb.txt => ixgb.rst} (100%)
> 

The 1/2 file may need some changes, but the rst conversion seems to come out fine, so...
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
