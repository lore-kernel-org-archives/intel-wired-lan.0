From: Andre Guedes <andre.guedes@intel.com>
Date: Wed, 21 Oct 2020 15:16:35 -0700
Subject: [Intel-wired-lan] [PATCH 1/9] igc: Fix igc_ptp_rx_pktstamp()
In-Reply-To: <20201021135005.GA58344@ranger.igk.intel.com>
References: <20201009025349.4037-1-andre.guedes@intel.com>
 <20201009025349.4037-2-andre.guedes@intel.com>
 <20201021135005.GA58344@ranger.igk.intel.com>
Message-ID: <160331859515.64680.4070714452715978307@lsachorn-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Maciej,

Quoting Maciej Fijalkowski (2020-10-21 06:50:05)
> On Thu, Oct 08, 2020 at 07:53:41PM -0700, Andre Guedes wrote:
> > The comment describing the timestamps layout in the packet buffer is
> > wrong and the code is actually retrieving the timestamp in Timer 1
> > reference instead of Timer 0. This hasn't been a big issue so far
> > because hardware is configured to report both timestamps using Timer 0
> > (see IGC_SRRCTL register configuration in igc_ptp_enable_rx_timestamp()
> > helper). This patch fixes the comment and the code so we retrieve the
> > timestamp in Timer 0 reference as expected.
> > 
> > This patch also takes the opportunity to get rid of the hw.mac.type check
> > since it is not required.
> 
> How is this related to adding XDP support?

It is not directly related, however patches in this series depends on this patch
to apply (see "igc: Refactor rx timestamp handling"). That's why I put it as the
first patch in the series.

- Andre
