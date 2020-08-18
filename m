From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 18 Aug 2020 14:37:02 -0700
Subject: [Intel-wired-lan] [PATCH 2/2] igc: Fix not considering the TX
 delay for timestamps
In-Reply-To: <20200817231231.2971207-2-vinicius.gomes@intel.com>
References: <20200817231231.2971207-1-vinicius.gomes@intel.com>
 <20200817231231.2971207-2-vinicius.gomes@intel.com>
Message-ID: <20200818143702.00002850@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Vinicius Costa Gomes wrote:

> When timestamping a packet there's a delay between the start of the
> packet and the point where the hardware actually captures the
> timestamp. This difference needs to be considered if we want accurate
> timestamps.
> 
> This was done on the RX side, but not on the TX side.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Please see my responses to the other patch.
