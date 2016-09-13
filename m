From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 13 Sep 2016 18:22:25 +0000
Subject: [Intel-wired-lan] [next PATCH S46 5/8] i40e: Split Flow
 Director	descriptor config into separate function
In-Reply-To: <1473715124-31296-6-git-send-email-bimmy.pujari@intel.com>
References: <1473715124-31296-1-git-send-email-bimmy.pujari@intel.com>
 <1473715124-31296-6-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FD0D7@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, September 12, 2016 2:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S46 5/8] i40e: Split Flow Director
> descriptor config into separate function
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> In an effort to improve code readability I am splitting the Flow Director filter
> configuration out into a separate function like we have done for the standard
> xmit path.  The general idea is to provide a single block of code that translates
> the flow specification into a proper Flow Director descriptor.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: Id355ad8030c4e6c72c57504fa09de60c976a8ffe
> ---
> Testing Hints:
>         This will impact the Flow Director setup for Rx NFC based flows.  A
>         good test for this will be to add multiple flows via ethtool -N
>         interface and verify that all flow-type rules are being added
>         correctly.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 115 ++++++++++++++++-------
> -----
>  1 file changed, 64 insertions(+), 51 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Flow director rules and functions work as expected


