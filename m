From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 17 Feb 2017 03:26:28 +0000
Subject: [Intel-wired-lan] [next PATCH v5 02/12] igb: Use length to
 determine if descriptor is done
In-Reply-To: <20170207022532.9864.50994.stgit@localhost.localdomain>
References: <20170207022339.9864.87863.stgit@localhost.localdomain>
 <20170207022532.9864.50994.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C59AB1D@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, February 6, 2017 6:26 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH v5 02/12] igb: Use length to
> determine if descriptor is done
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This change makes it so that we use the length of the packet instead of the
> DD status bit to determine if a new descriptor is ready to be processed.
> The obvious advantage is that it cuts down on reads as we don't really even
> need the DD bit if going from a 0 to a non-zero value on size is enough to
> inform us that the packet has been completed.
> 
> In addition I have updated the code so that we only reset the Rx descriptor
> length for descriptor zero when resetting a ring instead of having to do a
> memset with 0 over the entire ring.  By doing this we can save some time on
> initialization.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> v2: Update ethtool loopback test to use length check instead of DD check
> 
>  drivers/net/ethernet/intel/igb/igb_ethtool.c |    2 +-
>  drivers/net/ethernet/intel/igb/igb_main.c    |   14 ++++++++------
>  2 files changed, 9 insertions(+), 7 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
