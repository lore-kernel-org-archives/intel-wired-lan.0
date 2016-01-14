From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 14 Jan 2016 03:07:19 +0000
Subject: [Intel-wired-lan] [next PATCH 03/11] igb: Allow asymmetric
 configuration of MTU versus Rx frame size
In-Reply-To: <20160107071039.13648.55302.stgit@localhost.localdomain>
References: <20160107070850.13648.21033.stgit@localhost.localdomain>,
 <20160107071039.13648.55302.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E4F13E@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Alexander Duyck [aduyck at mirantis.com]
> Sent: Wednesday, January 06, 2016 11:10 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 03/11] igb: Allow asymmetric configuration of MTU versus Rx frame size
> 
> Since the igb driver is using page based receive there is no point in
> limiting the Rx capabilities of the device.  The driver can receive 9K
> jumbo frames at all times.  The only changes needed due to MTU changes are
> updates for the FIFO sizes and flow-control watermarks.
> 
> Update the maximum frame size to reflect the 9.5K limitation of the
> hardware, and replace all instances of max_frame_size with
> MAX_JUMBO_FRAME_SIZE when referring to an Rx FIFO or frame.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_defines.h |    3 -
>  drivers/net/ethernet/intel/igb/igb_main.c      |  107 +++++++++---------------
>  2 files changed, 42 insertions(+), 68 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
