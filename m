From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 17 Feb 2017 03:30:43 +0000
Subject: [Intel-wired-lan] [next PATCH v5 12/12] igb: Re-add support
	for	build_skb in igb
In-Reply-To: <20170207022732.9864.74558.stgit@localhost.localdomain>
References: <20170207022339.9864.87863.stgit@localhost.localdomain>
 <20170207022732.9864.74558.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C59ABE0@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, February 6, 2017 6:28 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH v5 12/12] igb: Re-add support for
> build_skb in igb
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This reverts commit f9d40f6a9921 ("igb: Revert support for build_skb in
> igb") and adds a few changes to update it to work with the latest version
> of igb. We are now able to revert the removal of this due to the fact
> that with the recent changes to the page count and the use of
> DMA_ATTR_SKIP_CPU_SYNC we can make the pages writable so we should
> not be
> invalidating the additional data added when we call build_skb.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c |   47
> +++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
