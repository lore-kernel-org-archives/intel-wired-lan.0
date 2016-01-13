From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 13 Jan 2016 04:24:10 +0000
Subject: [Intel-wired-lan] [PATCH] igb: rename igb define to be more
 generic
In-Reply-To: <20160111173450.19024.84504.stgit@htfujina-fc.jf.intel.com>
References: <20160111173450.19024.84504.stgit@htfujina-fc.jf.intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E4DCB6@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Todd Fujinaka [todd.fujinaka at intel.com]
> Sent: Monday, January 11, 2016 9:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] igb: rename igb define to be more generic
> 
> E1000_MRQC_ENABLE_RSS_4Q enables 4 and 8 queues depending on the part
> so rename to be generic.
> 
> Similarly, E1000_MRQC_ENABLE_VMDQ_RSS_2Q has no numeric meaning so
> rename to be more generic.
> 
> Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_82575.h |    4 ++--
>  drivers/net/ethernet/intel/igb/igb_main.c    |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
