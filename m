From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 21 Mar 2017 16:39:14 +0000
Subject: [Intel-wired-lan] [next PATCH S63 1/6] i40e/i40evf: Use length
 to	determine if descriptor is done
In-Reply-To: <1489511727-10959-1-git-send-email-bimmy.pujari@intel.com>
References: <1489511727-10959-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040682B@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, March 14, 2017 10:15 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S63 1/6] i40e/i40evf: Use length to
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
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: Iebdf9cdb36c454ef092df27199b92ad09c374231
> ---
> Testing Hints:
>         Perform various Rx tests to verify we are not corrupting any Rx data.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 24 ++++++++++++------------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 24 ++++++++++++------------
>  2 files changed, 24 insertions(+), 24 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


