From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 23 Apr 2016 02:15:59 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v2 3/3] igb/igbvf: Add
 support	for GSO partial
In-Reply-To: <20160414211938.14141.76178.stgit@ahduyck-xeon-server>
References: <20160414210725.14141.25917.stgit@ahduyck-xeon-server>
 <20160414211938.14141.76178.stgit@ahduyck-xeon-server>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81EF0A65@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Thursday, April 14, 2016 2:20 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; alexander.duyck at gmail.com
> Subject: [Intel-wired-lan] [next-queue PATCH v2 3/3] igb/igbvf: Add support
> for GSO partial
> 
> This patch adds support for partial GSO segmentation in the case of
> tunnels.  Specifically with this change the driver an perform segmenation
> as long as the frame either has IPv6 inner headers, or we are allowed to
> mangle the IP IDs on the inner header.  This is needed because we will not
> be modifying any fields from the start of the start of the outer transport
> header to the start of the inner transport header as we are treating them
> like they are just a block of IP options.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c |  137 +++++++++++++++-------
>  drivers/net/ethernet/intel/igbvf/netdev.c |  182 +++++++++++++++++----------
> --
>  2 files changed, 203 insertions(+), 116 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
