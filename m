From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 10 May 2016 01:31:49 +0000
Subject: [Intel-wired-lan] [PATCH] igb: adjust ptp timestamps for tx/rx
	latency
In-Reply-To: <1462317056-28805-1-git-send-email-nathan.sullivan@ni.com>
References: <1462317056-28805-1-git-send-email-nathan.sullivan@ni.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81EFAB94@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-
> owner at vger.kernel.org] On Behalf Of Nathan Sullivan
> Sent: Tuesday, May 3, 2016 4:11 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; Nelson, Shannon
> <shannon.nelson@intel.com>; Wyborny, Carolyn
> <carolyn.wyborny@intel.com>; Skidmore, Donald C
> <donald.c.skidmore@intel.com>; Allan, Bruce W <bruce.w.allan@intel.com>;
> Ronciak, John <john.ronciak@intel.com>; Williams, Mitch A
> <mitch.a.williams@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; Nathan Sullivan <nathan.sullivan@ni.com>
> Subject: [PATCH] igb: adjust ptp timestamps for tx/rx latency
> 
> Table 7-62 on page 338 of the i210 datasheet lists TX and RX latencies
> for the various speeds the chip supports.  To give better ptp timestamp
> accuracy, adjust the timestamps by the amounts Intel gives based on
> current link speed.
> 
> Signed-off-by: Nathan Sullivan <nathan.sullivan@ni.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h     |    8 +++++++
>  drivers/net/ethernet/intel/igb/igb_ptp.c |   36
> ++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

