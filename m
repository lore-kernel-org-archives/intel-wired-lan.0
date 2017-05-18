From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 18 May 2017 02:33:55 +0000
Subject: [Intel-wired-lan] [next-queue v2] igb: Remove useless argument
In-Reply-To: <20170516225516.65557-1-jeffrey.t.kirsher@intel.com>
References: <20170516225516.65557-1-jeffrey.t.kirsher@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C5F8E7D@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Jeff Kirsher
> Sent: Tuesday, May 16, 2017 3:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Benjamin Poirier <bpoirier@suse.com>
> Subject: [Intel-wired-lan] [next-queue v2] igb: Remove useless argument
> 
> From: Benjamin Poirier <bpoirier@suse.com>
> 
> Given that all callers of igb_update_stats() pass the same two arguments:
> (adapter, &adapter->stats64), the second argument can be removed.
> 
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h         |    2 +-
>  drivers/net/ethernet/intel/igb/igb_ethtool.c |    2 +-
>  drivers/net/ethernet/intel/igb/igb_main.c    |   10 +++++-----
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 

I'm getting a warning from checkpatch with this:
------------------------------------------------------------
WARNING: function definition argument 'struct igb_adapter *' should also have an identifier name
#25: FILE: drivers/net/ethernet/intel/igb/igb.h:670:
+void igb_update_stats(struct igb_adapter *);

total: 0 errors, 1 warnings, 0 checks, 51 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.
u1515:[2]/usr/src/kernels/next-queue>
------------------------------------------------------------
But it otherwise seems fine so I'm not inclined to hold it up for that.

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
