From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 17 Feb 2017 03:29:49 +0000
Subject: [Intel-wired-lan] [next PATCH v5 10/12] igb: Add support
	for	padding packet
In-Reply-To: <20170207022709.9864.74231.stgit@localhost.localdomain>
References: <20170207022339.9864.87863.stgit@localhost.localdomain>
 <20170207022709.9864.74231.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C59ABB7@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, February 6, 2017 6:27 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH v5 10/12] igb: Add support for padding
> packet
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> With the size of the frame limited we can now write to an offset within the
> buffer instead of having to write at the very start of the buffer.  The
> advantage to this is that it allows us to leave padding room for things
> like supporting XDP in the future.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> v4: Split this code out of patch 6 of the original series.
> 
>  drivers/net/ethernet/intel/igb/igb.h      |   11 +++++++++++
>  drivers/net/ethernet/intel/igb/igb_main.c |   14 ++++++++++++--
>  2 files changed, 23 insertions(+), 2 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
