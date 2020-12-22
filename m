From: Andre Guedes <andre.guedes@intel.com>
Date: Mon, 21 Dec 2020 17:13:44 -0800
Subject: [Intel-wired-lan] [PATCH 06/10] igc: Introduce
 igc_update_tx_stats()
In-Reply-To: <20201221225811.GC2943@ranger.igk.intel.com>
References: <20201217202415.77891-1-andre.guedes@intel.com>
 <20201217202415.77891-7-andre.guedes@intel.com>
 <20201221225811.GC2943@ranger.igk.intel.com>
Message-ID: <160859962405.45139.5477040596348797483@bgdudka-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Quoting Maciej Fijalkowski (2020-12-21 14:58:11)
> On Thu, Dec 17, 2020 at 12:24:11PM -0800, Andre Guedes wrote:
> > Likewise we do with the RX stats, this patch encapsulates the code that
> > updates the driver TX stats in its own local helper.
> 
> I think you can squash this onto previous patch.

I can do that.
