From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 14 Jul 2017 21:49:41 +0000
Subject: [Intel-wired-lan] [PATCH 2/3] igb: expose mailbox unlock method
In-Reply-To: <20170628152226.25369-3-gedwards@ddn.com>
References: <20170628152226.25369-1-gedwards@ddn.com>
 <20170628152226.25369-3-gedwards@ddn.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C64E01A@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Greg Edwards
> Sent: Wednesday, June 28, 2017 8:22 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Greg Edwards <gedwards@ddn.com>
> Subject: [Intel-wired-lan] [PATCH 2/3] igb: expose mailbox unlock method
> 
> Add a mailbox unlock method to e1000_mbx_operations, which will be used
> to unlock the PF/VF mailbox by the PF.
> 
> Signed-off-by: Greg Edwards <gedwards@ddn.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_hw.h  |  1 +
>  drivers/net/ethernet/intel/igb/e1000_mbx.c | 39
> ++++++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/igb/e1000_mbx.h |  1 +
>  3 files changed, 41 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
