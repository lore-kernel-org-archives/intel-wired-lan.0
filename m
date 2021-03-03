From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Wed, 3 Mar 2021 10:36:24 -0800
Subject: [Intel-wired-lan] [PATCH intel-net 0/3] intel: Rx headroom fixes
In-Reply-To: <20210303153928.11764-1-maciej.fijalkowski@intel.com>
References: <20210303153928.11764-1-maciej.fijalkowski@intel.com>
Message-ID: <20210303103624.00003aff@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Maciej Fijalkowski wrote:

> Fix Rx headroom by calling *_rx_offset() after the build_skb Rx ring
> flag is set.
> 
> It was reported by Jesper in [0] that XDP_REDIRECT stopped working after
> [1] patch in i40e.

Looks good to me, thanks for the fixes Maciej, and especially to
Jesper for the report of the issue.

For the series: 
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
