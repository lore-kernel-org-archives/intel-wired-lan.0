From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 17 Feb 2017 03:30:13 +0000
Subject: [Intel-wired-lan] [next PATCH v5 11/12] igb: Break out Rx
 buffer	page management
In-Reply-To: <20170207022720.9864.8155.stgit@localhost.localdomain>
References: <20170207022339.9864.87863.stgit@localhost.localdomain>
 <20170207022720.9864.8155.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C59ABC5@ORSMSX103.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH v5 11/12] igb: Break out Rx buffer
> page management
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> At this point we have 2 to 3 paths that can be taken depending on what Rx
> modes are enabled.  In order to better support that and improve the
> maintainability I am breaking out the common bits from those paths and
> making them into their own functions.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> v3: Rebase patch on v3 changes to fix pointer arithmetic mismatch
> v4: Rebase on top of changes to split up buffer size and padding changes
> v5: Fix rebase which left me with unused variables
> 
>  drivers/net/ethernet/intel/igb/igb_main.c |  235 +++++++++++++++---------
> -----
>  1 file changed, 121 insertions(+), 114 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
