From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jun 2016 16:03:00 +0000
Subject: [Intel-wired-lan] [next PTACH S38-v2 2/7] i40e: enable
	VSI	broadcast promiscuous mode instead of adding broadcast filter
In-Reply-To: <1466439039-16378-3-git-send-email-bimmy.pujari@intel.com>
References: <1466439039-16378-1-git-send-email-bimmy.pujari@intel.com>
 <1466439039-16378-3-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9E8EA3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, June 20, 2016 9:11 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PTACH S38-v2 2/7] i40e: enable VSI broadcast
> promiscuous mode instead of adding broadcast filter
> 
> From: Kiran Patil <kiran.patil@intel.com>
> 
> This patch sets VSI brodcast promiscuous mode during VSI add sequence and
> prevents adding MAC filter if specified MAC address is broadcast.
> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Change-ID: Ia62251fca095bc449d0497fc44bec3a5a0136773
> ---
> Testing Hints :
> 1. Bring up network interface, assign IP address.
> 2. Make sure it can ping to link partner.
> This proves that ARP request are processed correctly due to VSI broadcast
> promiscuous mode even though MAC filter for broadcast address is not
> programmed.
> 
> Likewise tried the test case mentioned in HSD where source MAC is
> broadcast and those packets are getting forwarded to one of the rx-queue.
> 
> HSD-number: 7661069
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 32 ++++++++++++++++++----
> -------
>  1 file changed, 20 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Functions as expected
